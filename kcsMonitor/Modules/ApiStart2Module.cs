using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Diagnostics;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Threading;

using Paspy.kcsMonitor.Utility;
using Paspy.kcsMonitor.KCData.ExportData;
using ElectronicObserver.Data;

namespace Paspy.kcsMonitor.Modules {
    class ApiStart2Module : BaseModule {

        private string m_loginId;
        private string m_password;
        private string m_token;
        private string m_server;
        private bool m_forceUpdateToken;
        private KCDatabase m_kcdbRef;
        Dictionary<string, List<Ship>> m_exportedShips;
        List<SlotItem> m_exportedSlotItems;
        public ApiStart2Module(string loginId, string password, int fetchTime = 60000) : base(fetchTime) {
            m_loginId = loginId;
            m_password = password;
            m_forceUpdateToken = false;
            m_exportPath = Path.Combine(Directory.GetCurrentDirectory(), MODULE_PATH);
            Directory.CreateDirectory(m_exportPath);
            m_kcdbRef = KCDatabase.Instance;
            Utils.Log("ApiStart2Module has been initialized. Checking time interval is " + (fetchTime / 1000) + "s.", "ApiStart2Module");
        }

        protected override void StartModuleCycle(object state) {
            IsModuleRunning = true;
            string latestJsonStr = null;
            try {
                Utils.Log("CheckAPIStart2 Start.", "ApiStart2Module");
                var tt = new TimeTracker("start");
                latestJsonStr = UpdateApiStart2Json().Result; // return valid json or error code
                tt.AddLap("end");
                if (latestJsonStr != null && latestJsonStr.Length > 3) {
                    Utils.Log("Latest api_start2 JSON downloaded. Time elapsed: " + tt.GetLapTimeDiff("start", "end", TimeTracker.TimeFormat.Seconds) + "s.", "ApiStart2Module");
                    var existingJsonFile = Path.Combine(m_exportPath, "api_start2.latest.json");
                    if (File.Exists(existingJsonFile)) {
                        string existingJsonStr = File.ReadAllText(existingJsonFile);
                        dynamic oldJson = JValue.Parse(existingJsonStr);
                        dynamic newJson = JValue.Parse(latestJsonStr);
                        if (!JToken.DeepEquals(oldJson, newJson)) {
                            Utils.Log("Found newer api_start2, achieve and update to latest version.", "ApiStart2Module");
                            var utcDate = DateTime.UtcNow.ToString("yyyyMMdd");
                            var newFilePath = Path.Combine(m_exportPath, string.Format(".api_start2.{0}.json", utcDate));
                            ExportNewContents(oldJson, newJson, utcDate);
                            File.Copy(existingJsonFile, newFilePath, true);
                            File.WriteAllText(existingJsonFile, latestJsonStr, new UTF8Encoding(false));
                            Utils.Log("All changes are saved. Current checking cycle ended.", "ApiStart2Module");

                        } else {
                            Utils.Log("Nothing change. Current checking cycle ended.", "ApiStart2Module");
                        }
                    } else {
                        File.WriteAllText(existingJsonFile, latestJsonStr, new UTF8Encoding(false));
                    }
                } else {
                    Utils.Log("Error occurred on UpdateApiStart2Json. Current checking cycle ended.", "ApiStart2Module");
                }
            } catch (Exception ex) {
                Utils.Log(ex.Message, "ApiStart2Module");
            }
            m_forceUpdateToken = !(latestJsonStr != null && latestJsonStr.Length > 3);
            m_checkingTimer.Change((m_forceUpdateToken&&!latestJsonStr.Equals("200")) ? 3000 : m_timeInterval, Timeout.Infinite);
            IsModuleRunning = false;
        }

        private void ExportNewContents(dynamic oldJson, dynamic newJson, string subdir = "") {
            m_kcdbRef.InitializeApiStart2(oldJson);
            m_kcdbRef.UpdateApiStart2(newJson);
            m_kcdbRef.ExportNewAddedShipAndSlotitem(m_server, out m_exportedShips, out m_exportedSlotItems);
            var newEquipPath = Path.Combine(MODULE_PATH, "export", subdir, "new_equipment");
            var newShipPath = Path.Combine(MODULE_PATH, "export", subdir, "new_ship");
            var newLimitedPath = Path.Combine(MODULE_PATH, "export", subdir, "new_limited");
            var newAbyssalPath = Path.Combine(MODULE_PATH, "export", subdir, "new_abyssal");
            var jsonPath = Path.Combine(MODULE_PATH, "export", subdir);
            Directory.CreateDirectory(newEquipPath);
            Directory.CreateDirectory(newShipPath);

            var taskLst = new List<Task>();
            foreach (var shipTypes in m_exportedShips.Values) {
                foreach (var ship in shipTypes) {
                    taskLst.Add(
                        Task.Run(async () => {
                            var swfPath = Path.Combine(ship.IsAbyssal ? newAbyssalPath : ship.IsLimitedIllustration ? newLimitedPath : newShipPath, string.Format("{0}_{1}", ship.ID, ship.Name));
                            var swfFile = Path.Combine(swfPath, string.Format("{0}_{1}{2}", ship.ID, ship.Name, Path.GetExtension(ship.IllustrationSwfLink)));
                            Directory.CreateDirectory(swfPath);
                            ship.IllustrationSwfLink = await DownloadAndConvertToBase64Async(ship.IllustrationSwfLink, swfFile);
                        }).ContinueWith((p) => {
                            Utils.Log(ship.Name + " swf has downloaded.", "ApiStart2Module");
                        }, TaskContinuationOptions.OnlyOnRanToCompletion)
                    );
                }
            }
            foreach (var item in m_exportedSlotItems) {
                if (item.IsAbyssal) continue;
                foreach (var link in item.ItemIllustrateLinks) {
                    taskLst.Add(
                        Task.Run(async () => {
                            var fnNoExt = Path.GetFileNameWithoutExtension(link);
                            var file = Path.Combine(newEquipPath, string.Format("{0}_{1}{2}", fnNoExt, new Uri(link).Segments[5].TrimEnd('/'), Path.GetExtension(link)));
                            item.ItemIllustrateBase64[Path.GetFileName(file)] = await DownloadAndConvertToBase64Async(link, file);
                        }).ContinueWith((p) => {
                            Utils.Log(item.Name + " image has downloaded.", "ApiStart2Module");
                        }, TaskContinuationOptions.OnlyOnRanToCompletion)
                    );
                }
            }
            Task.WhenAll(taskLst).Wait();
            foreach (var shipType in m_exportedShips) {
                File.WriteAllText(Path.Combine(jsonPath, string.Format("new_{0}.json", shipType.Key)), JsonConvert.SerializeObject(shipType.Value, Formatting.Indented));
            }
            File.WriteAllText(Path.Combine(jsonPath, "new_equipment.json"), JsonConvert.SerializeObject(m_exportedSlotItems, Formatting.Indented));
        }

        private async Task<string> UpdateApiStart2Json() {
            try {
                GetTokenFromKcsAuthPy(m_forceUpdateToken);
                if (m_token.Length <= 3) return m_token;
                var postContent = new Dictionary<string, string> {
                        {"api_token", m_token},
                        {"api_verno","1"},
                    };
                var httpReqMsg = Utils.CreateHttpRequestMessage(string.Format(API_URL, m_server), new FormUrlEncodedContent(postContent));
                var respones = await new HttpClient(new HttpClientHandler { AutomaticDecompression = DecompressionMethods.GZip | DecompressionMethods.Deflate }).SendAsync(httpReqMsg);
                var rawResult = await respones.Content.ReadAsStringAsync();
                var rawJson = rawResult.Substring(7);
                dynamic json = JValue.Parse(rawJson);
                if ((int)json.api_result != 1) {
                    string msg = json.api_result_msg;
                    Utils.Log(string.Format("Error on acquiring api_start2, code: {0}.", json.api_result), "ApiStart2Module");
                    m_forceUpdateToken = true;
                    return null;
                }
                m_forceUpdateToken = false;
                return rawJson;
            } catch (Exception ex) {
                Utils.Log(ex.Message, "ApiStart2Module");
                return null;
            }
        }

        private async Task<string> DownloadAndConvertToBase64Async(string address, string filenameWithPath = "", bool exportImages = false) {
            CancellationTokenSource source = new CancellationTokenSource();
            CancellationToken token = source.Token;
            try {
                using (var httpClient = new HttpClient(new RetryHandler(new HttpClientHandler()))) {
                    using (var request = new HttpRequestMessage(HttpMethod.Get, new Uri(address))) {
                        var response = await httpClient.SendAsync(request, token);
                        if (response == null) source.Cancel();
                        MemoryStream contentStream = await response.Content.ReadAsStreamAsync() as MemoryStream;
                        var b = contentStream.ToArray();
                        if (filenameWithPath.Length > 0)
                            File.WriteAllBytes(filenameWithPath, b);
                        return Convert.ToBase64String(b);
                    }
                }
            } catch (AggregateException ae) {
                foreach (Exception e in ae.InnerExceptions) {
                    if (e is TaskCanceledException)
                        Utils.Log(e.Message + " " + address, "ApiStart2Module");
                    else
                        Utils.Log("Exception: " + e.GetType().Name, "ApiStart2Module");
                }
            } finally {
                source.Dispose();
            }
            return null;
        }

        //private async Task<Dictionary<string, string>> GetImagesFromFFDEC(string swfPath) {

        //}

        private void GetTokenFromKcsAuthPy(bool forceUpdate = false) {
            string jsonPath = Path.Combine(MODULE_PATH, "kcsAuthPy", m_loginId + ".json");
            string resultJson = "";
            try {
                if (File.Exists(jsonPath) && !forceUpdate) {
                    using (var sr = new StreamReader(new FileStream(jsonPath, FileMode.Open, FileAccess.Read), Encoding.UTF8)) {
                        resultJson = sr.ReadLine();
                    }
                } else {
                    string exec = m_isWindows ? @"data\ApiStart2Module\kcsAuthPy\kcsAuthPy.exe" : "python3";
                    using (Process kcsAuthPy = new Process {
                        StartInfo = new ProcessStartInfo(exec) {
                            RedirectStandardOutput = false,
                            RedirectStandardError = false,
                            UseShellExecute = false,
                            CreateNoWindow = true,
                            WorkingDirectory = Path.Combine(MODULE_PATH, "kcsAuthPy"),
                            Arguments = m_isWindows ?
                            string.Format(@"{0} {1}", m_loginId, m_password) :
                            string.Format(@"kcsAuthPy.py {0} {1}", m_loginId, m_password)

                        }
                    }) {
                        kcsAuthPy.Start();
                        Utils.Log("kcsAuthPy begins to acquire a new token. ", "ApiStart2Module");
                        if (!kcsAuthPy.WaitForExit(15000)) {
                            if (!kcsAuthPy.HasExited)
                                kcsAuthPy.Kill();
                            Utils.Log("Timeout: kcsAuthPy going to restart.", "ApiStart2Module");
                            m_forceUpdateToken = true;
                            return;
                        }
                        m_forceUpdateToken = false;
                        GetTokenFromKcsAuthPy(m_forceUpdateToken);
                        return;
                    }
                }
                dynamic dyJson = JValue.Parse(resultJson);
                if ((int)dyJson.result == 1) {
                    m_token = dyJson.api_token;
                    m_server = dyJson.world_addr;
                    Utils.Log(Consts.WorldServerName[(int)dyJson.world_id - 1] + " " + m_token, "ApiStart2Module");
                } else {
                    m_token = dyJson.result;
                    m_server = "";
                    Utils.Log(string.Format("Error: {0}, code: {1}", dyJson.error_msg, dyJson.result), "ApiStart2Module");
                }
            } catch (Exception ex) {
                Utils.Log(ex.Message, "ApiStart2Module");
                return;
            }
        }

        const string MODULE_PATH = "data/ApiStart2Module/";
        const string API_URL = "http://{0}/kcsapi/api_start2";
    }
}
