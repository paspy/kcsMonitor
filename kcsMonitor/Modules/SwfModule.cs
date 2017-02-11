using System;
using System.IO;
using System.Net;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

using Paspy.kcsMonitor.Utility;

namespace Paspy.kcsMonitor.Modules {
    class SwfModule : BaseModule {

        private Random m_random;
        private string m_rndServerAddr;
        private Dictionary<string, byte[]> m_tmpSwfs;
        public SwfModule(int fetchTime = 60000) : base(fetchTime) {
            m_exportPath = Path.Combine(Directory.GetCurrentDirectory(), MODULE_PATH);
            Directory.CreateDirectory(m_exportPath);
            m_tmpSwfs = new Dictionary<string, byte[]>();
            m_random = new Random();
            Utils.Log("SwfModule has been initialized. Checking time interval is " + (fetchTime / 1000) + "s.", "SwfModule");
        }

        protected override void StartModuleCycle(object state) {
            IsModuleRunning = true;
            m_rndServerAddr = Consts.WorldServerAddr[m_random.Next(0, Consts.WorldServerAddr.Count)];
            Utils.Log("DownloadAndCheck Start. Server address: " + m_rndServerAddr, "SwfModule");
            var tt = new TimeTracker("start");
            var taskResult = DownloadAllSwfsAsync(SwfPaths).Result;
            tt.AddLap("end");
            if (taskResult == null) {
                Utils.Log("Some of files are not properly downloaded, current execution canceled.", "SwfModule");
                return;
            }
            Utils.Log("All files downloaded. Time elapsed: " + tt.GetLapTimeDiff("start", "end", TimeTracker.TimeFormat.Seconds) + "s.", "SwfModule");

            var existingFiles = Directory.GetFiles(m_exportPath);
            if (existingFiles.Length < 1) {
                foreach (var stream in taskResult) {
                    File.WriteAllBytes(Path.Combine(m_exportPath, stream.Key), stream.Value.ToArray());
                }
            }

            foreach (var fileWithPath in existingFiles) {
                string filename = Path.GetFileName(fileWithPath);
                if (!SwfFileNames.Contains(filename)) {
                    Utils.Log("File: " + filename + " is missing. Get a latest version.", "SwfModule");
                    File.WriteAllBytes(fileWithPath, taskResult[filename].ToArray());
                } else {
                    var existingSwf = File.ReadAllBytes(fileWithPath);
                    if (!Utils.StreamAreEqualHash(existingSwf, taskResult[filename].ToArray())) {
                        Utils.Log("File: " + filename + " is different from stored version, achieve and update to latest version.", "SwfModule");
                        var utcDate = DateTime.UtcNow.ToString("yyyyMMddHH");
                        var achievedPath = Path.Combine(m_exportPath, utcDate);
                        Directory.CreateDirectory(achievedPath);
                        var newFilePath = Path.Combine(achievedPath, filename);
                        File.Move(fileWithPath, newFilePath);
                        File.WriteAllBytes(fileWithPath, taskResult[filename].ToArray());
                    }
                }
            }
            Utils.Log("Current execution cycle is completed.", "SwfModule");
            m_checkingTimer.Change(m_timeInterval, Timeout.Infinite);
            IsModuleRunning = false;
        }

        async Task<Dictionary<string, MemoryStream>> DownloadAllSwfsAsync(IEnumerable<string> urls) {
            try {
                var dictionary = urls.ToDictionary(
                    url => new Uri(string.Format(url, m_rndServerAddr)),
                    url => Utils.DownloadDataTaskAsync(string.Format(url, m_rndServerAddr))
                );
                List<Task> taskLst = new List<Task>();
                foreach (var item in dictionary) {
                    taskLst.Add(item.Value.ContinueWith((p) => {
                        Utils.Log(item.Key.OriginalString + " downloaded.", "SwfModule");
                    }, TaskContinuationOptions.OnlyOnRanToCompletion));
                }

                await Task.WhenAll(taskLst);
                var resultDict = dictionary.ToDictionary(
                    pair => Path.GetFileName(pair.Key.LocalPath),
                    pair => new MemoryStream(pair.Value.Result)
                );

                // decode core.swf
                resultDict["Core_decoded.swf"] = DecodeCoreSwf(resultDict["Core.swf"]);
                return resultDict;
            } catch (Exception ex) {
                Utils.Log(ex.Message, "SwfModule");
                return null;
            }
        }

        private MemoryStream DecodeCoreSwf(MemoryStream Original) {
            var size = (Original.Length - 128) >> 3;
            var OriginalByte = Original.ToArray();
            var decodedBytes = new MemoryStream();
            decodedBytes.Write(OriginalByte, 0, 128);
            foreach (var i in DECODE_ORDER) {
                var start = (int)(i * size + 128);
                var end = (int)((i + 1) * size + 128);
                decodedBytes.Write(OriginalByte, start, end - start);
            }
            return decodedBytes;
        }


        const string MODULE_PATH = @"data\SwfModule\";

        private static readonly int[] DECODE_ORDER = { 0, 7, 2, 5, 4, 3, 6, 1 };

        private static readonly string[] SwfPaths = {
            @"http://{0}/kcs/Core.swf",
            @"http://{0}/kcs/mainD2.swf",
            @"http://{0}/kcs/PortMain.swf",
            @"http://{0}/kcs/scenes/AlbumMain.swf",
            @"http://{0}/kcs/scenes/ArsenalMain.swf",
            @"http://{0}/kcs/scenes/BattleMain.swf",
            @"http://{0}/kcs/scenes/BattleResultMain.swf",
            @"http://{0}/kcs/scenes/DutyMain.swf",
            @"http://{0}/kcs/scenes/InteriorMain.swf",
            @"http://{0}/kcs/scenes/ItemlistMain.swf",
            @"http://{0}/kcs/scenes/OrganizeMain.swf",
            @"http://{0}/kcs/scenes/RecordMain.swf",
            @"http://{0}/kcs/scenes/RemodelMain.swf",
            @"http://{0}/kcs/scenes/RepairMain.swf",
            @"http://{0}/kcs/scenes/RevampMain.swf",
            @"http://{0}/kcs/scenes/SallyMain.swf",
            @"http://{0}/kcs/scenes/SupplyMain.swf",
            @"http://{0}/kcs/scenes/TitleMain.swf",
            @"http://{0}/kcs/scenes/tutorial.swf",
            @"http://{0}/kcs/scenes/WeddingMain.swf",
        };

        private static readonly string[] SwfFileNames = {
            "Core.swf",
            "Core_decoded.swf",
            "mainD2.swf",
            "PortMain.swf",
            "AlbumMain.swf",
            "ArsenalMain.swf",
            "BattleMain.swf",
            "BattleResultMain.swf",
            "DutyMain.swf",
            "InteriorMain.swf",
            "ItemlistMain.swf",
            "OrganizeMain.swf",
            "RecordMain.swf",
            "RemodelMain.swf",
            "RepairMain.swf",
            "RevampMain.swf",
            "SallyMain.swf",
            "SupplyMain.swf",
            "TitleMain.swf",
            "tutorial.swf",
            "WeddingMain.swf",
        };

    }

}
