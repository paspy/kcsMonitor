using System;
using System.IO;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Collections.Concurrent;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Net;
using System.Net.Http;
using System.IO.Compression;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

using Paspy.kcsMonitor.Utility;
using Paspy.kcsMonitor.Modules.Data;
namespace Paspy.kcsMonitor.Modules {
    sealed class SenkaModule : BaseModule {

        private class Collector {
            private HttpClient m_client = new HttpClient(new HttpClientHandler { AutomaticDecompression = DecompressionMethods.GZip | DecompressionMethods.Deflate });
            public int Id { set; get; }
            public string ServerName { set; get; }
            public string ServerAddress { set; get; }
            public int MemberId { set; get; }
            public string Token { set; get; }
            public HttpClient GetClient() { return m_client; }
        }

        private Dictionary<string, Collector> m_dictCollectors;
        private Dictionary<string, List<Teitoku>> m_dictLatestSortedSenkaDB;
        private Dictionary<string, List<Teitoku>> m_dictPreviousSortedSenkaDB;
        private Dictionary<string, List<RawMember>> m_dictRawMemberDB;
        private string m_sTokenFile;

        public SenkaModule(string tokenFile = "") : base() {
            m_exportPath = Path.Combine(Directory.GetCurrentDirectory(), MODULE_PATH);
            Directory.CreateDirectory(m_exportPath);
            m_sTokenFile = tokenFile;
            m_dictCollectors = new Dictionary<string, Collector>();
            m_dictPreviousSortedSenkaDB = new Dictionary<string, List<Teitoku>>();
            m_dictLatestSortedSenkaDB = new Dictionary<string, List<Teitoku>>();
            var next = GetNextCycleTimeLeft();
            m_checkingTimer = new Timer(StartModuleCycle, null, next, Timeout.Infinite);

            Utils.Log("SenkaModule has been initialized. Module will start in " + FormatedTimeLeft(), "SenkaModule", ConsoleColor.Cyan);
            Utils.Log("Press [T] to report time left.", "SenkaModule", ConsoleColor.Cyan);
        }

        public override void ReportTime() {
            if (!IsModuleRunning)
                Utils.Log("Module will start in " + FormatedTimeLeft(), "SenkaModule", ConsoleColor.Yellow);
        }

        protected override void StartModuleCycle(object state) {
            IsModuleRunning = true;
            try {

                ImportTokens();
                ImportPreviousLocalSenkaData();
                ImportLatestLocalSenkaData();

                //var prevList = m_dictPreviousSortedSenkaDB.Values.ToList();
                //var currList = m_dictLatestSortedSenkaDB.Values.ToList();
                //for (int i = 0; i < m_dictPreviousSortedSenkaDB.Values.Count; i++) {
                //    foreach (var pt in prevList[i]) {
                //        var found = currList[i].Find(ct => ct.MemberId == pt.MemberId);
                //        if (found == null && pt.RankNo < 500) {
                //            Debug.WriteLine("No." + pt.RankNo + " " + pt.Nickname + " " + pt.Server);
                //        }
                //    }
                //}

                GetRemoteLatestSenkaData();
                MatchingFromPreviousSenkaData();
                MatchingFromRawMemberList();
                CalculateDiffBetweenPrevAndCurr();
                ExportSenka();

                var next = GetNextCycleTimeLeft();
                m_checkingTimer.Change(next, Timeout.Infinite);
                Utils.Log("Current execution cycle has finished. Next cycle will start in " + FormatedTimeLeft(), "SenkaModule", ConsoleColor.Cyan);
            } catch (Exception) {
                Utils.Log("Critical Error Found. Restart in 5 seconds.", "SenkaModule", ConsoleColor.Red);
                m_checkingTimer.Change(5000, Timeout.Infinite);

            }
            m_dictPreviousSortedSenkaDB.Clear();
            m_dictLatestSortedSenkaDB.Clear();
            m_dictCollectors.Clear();
            GC.Collect(GC.MaxGeneration, GCCollectionMode.Forced);
            IsModuleRunning = false;
        }

        private void GetRemoteLatestSenkaData() {
            try {
                List<Task> tasks = new List<Task>();
                var threadSafeSenkaDB = new ConcurrentDictionary<string, BlockingCollection<Teitoku>>();
                bool needExport = false;
                foreach (var collector in m_dictCollectors.Values) {
                    if (m_dictLatestSortedSenkaDB.ContainsKey(collector.ServerName))
                        if (m_dictLatestSortedSenkaDB[collector.ServerName].Count > 0)
                            continue;
                    needExport = true; // if any server missing, save to file.
                    threadSafeSenkaDB[collector.ServerName] = new BlockingCollection<Teitoku>();
                    for (int pageNo = 1; pageNo < 100; pageNo++) {
                        var newTask = GetRankPageInfoAsync(pageNo, collector);
                        tasks.Add(newTask.ContinueWith((p) => {
                            foreach (var teitoku in p.Result) {
                                threadSafeSenkaDB[collector.ServerName].Add(teitoku);
                            }
                            Utils.Log(string.Format("Total {0} has been cached from server {1}. (Unordered Log)", threadSafeSenkaDB[collector.ServerName].Count, collector.ServerName), "SenkaModule");
                        }, TaskContinuationOptions.OnlyOnRanToCompletion));
                        if (tasks.Count >= 25) {
                            Task.WaitAll(tasks.ToArray());
                            tasks.Clear();
                        }
                    }
                    Task.WaitAll(tasks.ToArray());
                    threadSafeSenkaDB[collector.ServerName].Add(new Teitoku(0, "Metadata")); // a metadata
                    m_dictLatestSortedSenkaDB[collector.ServerName] = threadSafeSenkaDB[collector.ServerName].OrderBy(x => x.RankNo).ToList(); // sort by ranking number
                    m_dictLatestSortedSenkaDB[collector.ServerName].First().Server = collector.ServerName;

                    var duplicateNicknames = m_dictLatestSortedSenkaDB[collector.ServerName].GroupBy(x => x.Nickname).Where(x => x.Count() > 1).Select(x => x.Key); // find duplicate nicknames
                    m_dictLatestSortedSenkaDB[collector.ServerName].First().Comment = string.Format("Duplicates: {0}", string.Join(",", duplicateNicknames)); // record duplicate nicknames to metadata
                    Utils.Log(string.Format("All senka data from {0} has been cached and sorted.", collector.ServerName), "SenkaModule", ConsoleColor.Green);
                    tasks.Clear();
                }
                ExportSenka(needExport);
            } catch (Exception e) {
                Utils.Log("Critical Error at GetRemoteLatestSenkaData: " + e.Message, "SenkaModule", ConsoleColor.Red);
                throw;
            }
        }

        private void GetCollectorsMemberIds() {
            try {
                List<Task> tasks = new List<Task>();
                foreach (var collector in m_dictCollectors.Values) {
                    tasks.Add(Task.Run(async () => {
                        if (collector.MemberId <= 0) {
                            var postContent = new Dictionary<string, string> {
                                {"api_verno","1"},
                                {"api_token", collector.Token},
                            };
                            var httpReqMsg = Utils.CreateHttpRequestMessage(
                                    string.Format(API_GET_MEMBER_RECORD, collector.ServerAddress), new FormUrlEncodedContent(postContent));
                            var respones = await Utils.RequestAsync(() => collector.GetClient().SendAsync(httpReqMsg));
                            var rawResult = await respones.Content.ReadAsStringAsync();
                            var rawJson = rawResult.Substring(7); // delete "svdata="
                            dynamic json = JToken.Parse(rawJson);
                            if ((int)json.api_result != 1) {
                                string msg = json.api_result_msg;
                                Utils.Log(string.Format("Error on acquiring memberId, code: {0}.", json.api_result), "SenkaModule", ConsoleColor.Red);
                                throw new NotSupportedException(); // TO-DO acquire a new token
                            }
                            collector.MemberId = (int)(json.api_data.api_member_id);
                            Utils.Log("Get Member ID " + collector.MemberId + " for Collector from server " + collector.ServerName + " completed.", "SenkaModule", ConsoleColor.Green);
                        }
                    }));
                }
                Task.WaitAll(tasks.ToArray());
            } catch (Exception e) {
                Utils.Log("Critical Error at GetCollectorsMemberIds: " + e.Message, "SenkaModule", ConsoleColor.Red);
                throw;
            }
        }

        private void ImportTokens() {
            var file = DEFAULT_TOKEN_FILE;
            if (m_sTokenFile.Length > 0)
                file = m_sTokenFile;
            try {
                if (Path.GetExtension(file).ToLower().Equals(".xml")) {
                    var xTokens = XDocument.Load(file);
                    var kcServers = xTokens.Element("KCServer").Elements();
                    foreach (var serverInfo in kcServers) {
                        if (serverInfo.Value.Length > 0) {
                            Collector newCollector = new Collector();
                            newCollector.Id = int.Parse(serverInfo.Attribute("id").Value);
                            newCollector.ServerAddress = Consts.WorldServerAddr[newCollector.Id - 1];
                            newCollector.ServerName = Consts.WorldServerName[newCollector.Id - 1];
                            newCollector.Token = serverInfo.Value;
                            m_dictCollectors[newCollector.ServerName] = newCollector;
                        }
                    }

                } else if (Path.GetExtension(file).ToLower().Equals(".json")) {
                    throw new NotImplementedException();
                } else {
                    throw new ArgumentException();
                }
                GetCollectorsMemberIds();

            } catch (Exception e) {
                Utils.Log("Critical Error at ImportTokens: " + e.Message, "SenkaModule", ConsoleColor.Red);
                throw;
            }

        }

        private void ImportPreviousLocalSenkaData() {
            bool isFirstDay = (Utils.GetJstNow().Day == 1);
            var jst = Utils.GetJstNow();
            var lastDay = DateTime.DaysInMonth(jst.Year, jst.Month - 1);
            int prevDay = jst.Hour >= 0 && jst.Hour < 3 ? isFirstDay ? lastDay : (jst.Day - 1) : jst.Day;
            int prevHour = jst.Hour >= 3 && jst.Hour < 15 ? 3 : 15;
            if (prevHour == 15) prevHour = 3;
            else {
                prevHour = 15;
                prevDay = isFirstDay ? lastDay : prevDay - 1;
            }
            var filename =
                string.Format("{0}-{1}-{2}_{3}.json", jst.Year.ToString("D4"), (isFirstDay ? prevHour == 3 ? jst.Month : jst.Month - 1 : jst.Month).ToString("D2"), prevDay.ToString("D2"), prevHour.ToString("D2"));
            //filename = "2017-05-01_03.json";

            string[] subServerDirs = Directory.GetDirectories(m_exportPath);
            foreach (var serverExt in subServerDirs) {
                var filenameWithPath = Path.Combine(serverExt, filename);
                if (File.Exists(filenameWithPath)) {
                    var serverName = Path.GetFileNameWithoutExtension(serverExt).Substring(3); // delete XX_ prefix
                    m_dictPreviousSortedSenkaDB[serverName] =
                        JsonConvert.DeserializeObject<List<Teitoku>>(File.ReadAllText(filenameWithPath));
                    Utils.Log(string.Format("Found and load the PREVIOUS {0}'s senka data {1}.", serverName, filename), "SenkaModule", ConsoleColor.DarkMagenta);
                }
            }
        }

        private void ImportLatestLocalSenkaData() {
            var jst = Utils.GetJstNow();
            var filename =
                string.Format(
                    "{0}-{1}-{2}_{3}.json",
                    jst.Year.ToString("D4"),
                    jst.Month.ToString("D2"),
                    jst.Hour >= 0 && jst.Hour < 3 ? (jst.Day - 1).ToString("D2") : jst.Day.ToString("D2"),
                    (jst.Hour >= 3 && jst.Hour < 15 ? 3 : 15).ToString("D2"));

            string[] subServerDirs = Directory.GetDirectories(m_exportPath);
            foreach (var serverExt in subServerDirs) {
                var filenameWithPath = Path.Combine(serverExt, filename);
                if (File.Exists(filenameWithPath)) {
                    var serverName = Path.GetFileNameWithoutExtension(serverExt).Substring(3); // delete XX_ prefix
                    m_dictLatestSortedSenkaDB[serverName] =
                        JsonConvert.DeserializeObject<List<Teitoku>>(File.ReadAllText(filenameWithPath));
                    Utils.Log(string.Format("Found and load the LATEST {0}'s senka data {1}.", serverName, filename), "SenkaModule", ConsoleColor.DarkYellow);
                }
            }
        }

        private void MatchingFromPreviousSenkaData() {
            List<Task> tasks = new List<Task>();
            foreach (var serverPair in m_dictLatestSortedSenkaDB) {
                tasks.Add(Task.Run(() => DistinctFromPreviousSenkaData(serverPair.Key)));
            }
            Task.WaitAll(tasks.ToArray());
        }

        private void MatchingFromRawMemberList() {
            m_dictRawMemberDB = new Dictionary<string, List<RawMember>>();
            string[] subServerDirs = Directory.GetDirectories(m_exportPath);
            // load raw members for data matching
            foreach (var serverExt in subServerDirs) {
                var serverNamePrefix = Path.GetFileNameWithoutExtension(serverExt);
                var serverName = serverNamePrefix.Substring(3); // delete XX_ prefix
                var rawMemberFile = Path.Combine(m_exportPath, string.Format(DEFAULT_MEMBER_DB_ZIP, serverNamePrefix));
                if (File.Exists(rawMemberFile)) {
                    using (var zipMS = new MemoryStream(File.ReadAllBytes(rawMemberFile)))
                    using (ZipArchive archive = new ZipArchive(zipMS)) {
                        var jsonStream = archive.Entries.ToList().Find(x => x.FullName.EndsWith(".json", StringComparison.OrdinalIgnoreCase)).Open();
                        using (StreamReader sr = new StreamReader(jsonStream, System.Text.Encoding.UTF8))
                        using (var jsonTextReader = new JsonTextReader(sr)) {
                            var serializer = new JsonSerializer();
                            m_dictRawMemberDB[serverName] = serializer.Deserialize<List<RawMember>>(jsonTextReader);
                        }
                    }
                }
                Utils.Log(string.Format("{0}'s raw member list has been loaded.", serverName), "SenkaModule", ConsoleColor.DarkYellow);

            }

            // 1st - Find matching nickname in raw member list
            List<Task> tasks = new List<Task>();
            foreach (var serverPair in m_dictLatestSortedSenkaDB) {
                tasks.Add(Task.Run(() => DistinctByNicknameFromRawMemberList(serverPair.Key)));
            }
            Task.WaitAll(tasks.ToArray());
            m_dictRawMemberDB.Clear();
            GC.Collect(GC.MaxGeneration, GCCollectionMode.Forced);

            // 2nd - Distinguished by updated from Kancolle server
            Utils.Log("Distinguished by updated from Kancolle server started.", "SenkaModule", ConsoleColor.DarkYellow);
            foreach (var serverPair in m_dictLatestSortedSenkaDB) {
                DistinctFromRemoteServerAsync(serverPair.Key).ContinueWith((p) => {
                    Utils.Log(string.Format("Server {0} candidates matching completed.", p.Result), "SenkaModule", ConsoleColor.Green);
                }, TaskContinuationOptions.OnlyOnRanToCompletion).Wait();
            }

            // 3rd - Update and combine all data from practice
            Utils.Log("Update and combine all data from Kancolle server started.", "SenkaModule", ConsoleColor.DarkYellow);
            foreach (var serverPair in m_dictLatestSortedSenkaDB) {
                CachingByServerFromLatestInfoAsync(serverPair.Key).ContinueWith((p) => {
                    Utils.Log(string.Format("Server {0} Senka data has been combined and updated.", p.Result), "SenkaModule", ConsoleColor.Green);
                }, TaskContinuationOptions.OnlyOnRanToCompletion).Wait();
            }
        }

        private void DistinctFromPreviousSenkaData(string serverName) {
            if (!m_dictPreviousSortedSenkaDB.ContainsKey(serverName)) return;
            var prevSenkaList = m_dictPreviousSortedSenkaDB[serverName];

            var latestSenkaList = m_dictLatestSortedSenkaDB[serverName];
            int foundNum = 0;
            for (int i = 1/*skip metadata*/; i < latestSenkaList.Count(); i++) {
                var currTeitoku = latestSenkaList[i];
                var candidates = prevSenkaList.FindAll(x =>
                    currTeitoku.Nickname == x.Nickname &&
                    currTeitoku.Senka - x.Senka <= (440 + 1030) // The top record Senka per half day plus all EO Senka
                );
                if (candidates.Count == 1) {
                    currTeitoku.MemberId = candidates.First().MemberId;
                    currTeitoku.Candidates = null;
                    foundNum++;
                }
            }
            Utils.Log(string.Format(
                "Server {0} distinguished from previous Senka completed, {1} duplicates.",
                serverName, latestSenkaList.Count() - foundNum), "SenkaModule", ConsoleColor.Green);
        }

        private void DistinctByNicknameFromRawMemberList(string serverName) {
            var rawMemberList = m_dictRawMemberDB[serverName];
            var latestSenkaList = m_dictLatestSortedSenkaDB[serverName];
            int dupNum = 0;
            for (int i = 1/*skip metadata*/; i < latestSenkaList.Count(); i++) {
                if (latestSenkaList[i].MemberId > 0 || latestSenkaList[i].Candidates != null) continue;
                var currTeitoku = latestSenkaList[i];
                var candidates = rawMemberList.FindAll(x => (x.nickname == currTeitoku.Nickname));
                if (candidates.Count == 1) {
                    currTeitoku.MemberId = candidates.First().memberId;
                    currTeitoku.Candidates = null;
                } else if (candidates.Count > 1) {
                    currTeitoku.Candidates = candidates;
                    dupNum++;
                }
            }
            Utils.Log(string.Format("Server {0} candidates matching completed, {1} duplicates.", serverName, dupNum), "SenkaModule", ConsoleColor.Green);
        }

        private async Task<List<Teitoku>> GetRankPageInfoAsync(int pageNo, Collector collector) {
            try {
                var postContent = new Dictionary<string, string>
                {
                    {"api_verno","1"},
                    {"api_ranking", KeyGen.CreateSignature(collector.MemberId)},
                    {"api_pageno", pageNo.ToString()},
                    {"api_token", collector.Token},
                };
                var httpReqMsg = Utils.CreateHttpRequestMessage(
                                string.Format(API_RANK_PAGE, collector.ServerAddress), new FormUrlEncodedContent(postContent));
                var respones = await collector.GetClient().SendAsync(httpReqMsg);
                var rawResult = await respones.Content.ReadAsStringAsync();
                var rawJson = rawResult.Substring(7); // delete "svdata="
                dynamic json = JToken.Parse(rawJson);
                if ((int)json.api_result != 1) {
                    string msg = json.api_result_msg;
                    Utils.Log(string.Format("Error on acquiring memberId, code: {0}.", json.api_result), "SenkaModule", ConsoleColor.Red);
                    throw new NotSupportedException(); // TO-DO acquire a new token
                }

                List<Teitoku> currentPageOfTeitoku = new List<Teitoku>();
                foreach (var teitokuJson in json.api_data.api_list) {
                    currentPageOfTeitoku.Add(ParseRankingData(collector, teitokuJson));
                }
                return currentPageOfTeitoku;
            } catch (Exception e) {
                Utils.Log("Critical Error at GetRankPageInfoAsync: " + e.Message, "SenkaModule", ConsoleColor.Red);
                throw;
            }
        }

        private Teitoku ParseRankingData(Collector collector, dynamic eachTeitou) {
            try {
                var decodedData = KeyGen.DecodeRankAndMedal(collector.MemberId, (int)eachTeitou.api_mxltvkpyuklh, (long)eachTeitou.api_wuhnhojjxmke, (long)eachTeitou.api_itslcqtmrxtf);
                Teitoku tetoku = new Teitoku();
                tetoku.Nickname = eachTeitou.api_mtjmdcwtvhdr;
                tetoku.Comment = eachTeitou.api_itbrdpdbkynm;
                tetoku.MedalNum = (int)decodedData["medal"];
                tetoku.Senka = (int)decodedData["rate"];
                tetoku.RankNo = (int)eachTeitou.api_mxltvkpyuklh;
                tetoku.Rank = RANK_NAME[(int)eachTeitou.api_pcumlrymlujh];
                tetoku.Server = collector.ServerName;
                return tetoku;
            } catch (Exception e) {
                Utils.Log("Critical Error at ParseRankingData: " + e.Message, "SenkaModule", ConsoleColor.Red);
                throw;
            }

        }

        private async Task<string> DistinctFromRemoteServerAsync(string serverName) {
            try {
                var senkaList = m_dictLatestSortedSenkaDB[serverName];
                List<Task> tasks = new List<Task>();
                for (int i = 1/*skip metadata*/; i < senkaList.Count(); i++) {
                    if (senkaList[i].Candidates != null) {
                        tasks.Add(
                            DeepDistinctTeitokuAsync(m_dictCollectors[serverName], senkaList[i]).ContinueWith((p) => {
                                senkaList[p.Result.RankNo] = p.Result;
                            }, TaskContinuationOptions.OnlyOnRanToCompletion)
                        );
                    }
                }
                await Task.WhenAll(tasks);
                return serverName;
            } catch (Exception e) {
                Utils.Log("Critical Error at DistinctFromRemoteServerAsync: " + e.Message, "SenkaModule", ConsoleColor.Red);
                throw;
            }
        }

        private async Task<Teitoku> DeepDistinctTeitokuAsync(Collector collector, Teitoku teitoku) {
            try {
                if (!collector.ServerName.Equals(teitoku.Server))
                    throw new ArgumentException(
                        string.Format("Collector and target Teitoku mismatch.{0} != {1}", collector.ServerName, teitoku.Server));
                List<RawMember> prevCandidates = new List<RawMember>();
                using (HttpClient subClient =
                    new HttpClient(new HttpClientHandler {
                        AutomaticDecompression = DecompressionMethods.GZip | DecompressionMethods.Deflate
                    }
                )) {
                    for (int i = 0; i < teitoku.Candidates.Count(); i++) {
                        var candidate = teitoku.Candidates[i];
                        var postContent = new Dictionary<string, string>
                        {
                            {"api_verno","1"},
                            {"api_token", collector.Token},
                            {"api_member_id",candidate.memberId.ToString()},
                        };
                        var httpReqMsg = Utils.CreateHttpRequestMessage(
                                            string.Format(API_GET_ENEMY_INFO, collector.ServerAddress), new FormUrlEncodedContent(postContent));
                        var respones = await Utils.RequestAsync(() => subClient.SendAsync(httpReqMsg));
                        var rawResult = await respones.Content.ReadAsStringAsync();
                        var rawJson = rawResult.Substring(7); // delete "svdata="
                        dynamic json = JToken.Parse(rawJson);
                        if ((int)json.api_result != 1) {
                            string msg = json.api_result_msg;
                            Utils.Log(string.Format("Error on acquiring Candidate details, code: {0}.", json.api_result), "SenkaModule", ConsoleColor.Red);
                            throw new NotSupportedException(); // TO-DO acquire a new token
                        }
                        dynamic api_data = json.api_data;
                        RawMember m = new RawMember();
                        m.memberId = candidate.memberId;
                        m.nickname = candidate.nickname;
                        m.comment = api_data.api_cmt;
                        m.level = (int)api_data.api_level;
                        m.rank = RANK_NAME[(int)api_data.api_rank];
                        prevCandidates.Add(m);
                    }
                    var newCandidates =
                            prevCandidates.FindAll(x => x.comment.Equals(teitoku.Comment) && x.rank.Equals(teitoku.Rank));
                    if (newCandidates.Count() == 1) {
                        teitoku.MemberId = newCandidates.First().memberId;
                        Utils.Log(string.Format("{0} from {1} has been successfully distinguished from {2}.",
                            teitoku.Nickname, teitoku.Server, teitoku.Candidates.Count()), "SenkaModule");
                        teitoku.Candidates.Clear();
                        teitoku.Candidates = null;
                    } else {
                        teitoku.Candidates = newCandidates;
                        Utils.Log(string.Format("{0} from {1} reduced number of cadidates by {2} from {3}.",
                            teitoku.Nickname, teitoku.Server, (prevCandidates.Count() - newCandidates.Count()), prevCandidates.Count()), "SenkaModule", ConsoleColor.Magenta);
                    }
                    return teitoku;
                }
            } catch (Exception e) {
                Utils.Log("Critical Error at DeepDistinctTeitokuAsync: " + e.Message, "SenkaModule", ConsoleColor.Red);
                throw;
            }
        }

        private async Task<string> CachingByServerFromLatestInfoAsync(string serverName) {
            try {
                var senkaList = m_dictLatestSortedSenkaDB[serverName];
                List<Task> tasks = new List<Task>();
                for (int i = 1/*skip metadata*/; i < senkaList.Count(); i++) {
                    if (senkaList[i].MemberId > 0 && senkaList[i].Experiences == 0) {
                        tasks.Add(
                        DeepCachingForEachTeitokuAsync(m_dictCollectors[serverName], senkaList[i]).ContinueWith((p) => {
                            senkaList[p.Result.RankNo] = p.Result;
                        }, TaskContinuationOptions.OnlyOnRanToCompletion));
                        if (tasks.Count() >= 50) {
                            await Task.WhenAll(tasks);
                            Utils.Log(string.Format("Progress from {0} is {1}%.", serverName, (i / (float)senkaList.Count() * 100).ToString("##.#")), "SenkaModule");
                            tasks.Clear();
                        }
                    }
                }
                Task.WaitAll(tasks.ToArray());
                return serverName;
            } catch (Exception e) {
                Utils.Log("Critical Error at CachingByServerFromLatestInfoAsync: " + e.Message, "SenkaModule", ConsoleColor.Red);
                throw;
            }
        }

        private async Task<Teitoku> DeepCachingForEachTeitokuAsync(Collector collector, Teitoku teitoku) {
            try {
                if (!collector.ServerName.Equals(teitoku.Server))
                    throw new ArgumentException(
                        string.Format("Collector and target Teitoku mismatch.{0} != {1}", collector.ServerName, teitoku.Server));

                using (HttpClient subClient =
                    new HttpClient(new HttpClientHandler {
                        AutomaticDecompression = DecompressionMethods.GZip | DecompressionMethods.Deflate
                    }
                )) {
                    var postContent = new Dictionary<string, string>
                    {
                        {"api_verno","1"},
                        {"api_token", collector.Token},
                        {"api_member_id",teitoku.MemberId.ToString()},
                    };
                    var httpReqMsg = Utils.CreateHttpRequestMessage(
                                        string.Format(API_GET_ENEMY_INFO, collector.ServerAddress), new FormUrlEncodedContent(postContent));
                    var respones = await Utils.RequestAsync(() => subClient.SendAsync(httpReqMsg));
                    var rawResult = await respones.Content.ReadAsStringAsync();
                    var rawJson = rawResult.Substring(7); // delete "svdata="
                    dynamic json = JToken.Parse(rawJson);
                    if ((int)json.api_result != 1) {
                        string msg = json.api_result_msg;
                        Utils.Log(string.Format("Error on acquiring Teitoku details, code: {0}.", json.api_result), "SenkaModule", ConsoleColor.Red);
                        throw new NotSupportedException(); // TO-DO acquire a new token
                    }
                    dynamic api_data = json.api_data;
                    teitoku.Rank = RANK_NAME[(int)api_data.api_rank];
                    teitoku.Comment = api_data.api_cmt;
                    teitoku.HeadquarterLevel = api_data.api_level;
                    teitoku.Experiences = (long)api_data.api_experience[0];
                    teitoku.DeckName = api_data.api_deckname;
                    #region Disable
                    //teitoku.DeckShips = new List<PracticeShip>();
                    //dynamic ships = api_data.api_deck.api_ships;
                    //foreach (dynamic ship in ships) {
                    //    if (ship.api_level == null) continue;
                    //    var ds = new PracticeShip();
                    //    ds._id = ship.api_id;
                    //    ds.Level = ship.api_level;
                    //    ds.ShipId = ship.api_ship_id;
                    //    ds.Star = ship.api_star;
                    //    teitoku.DeckShips.Add(ds);
                    //}
                    #endregion
                    teitoku.ShipSlots = (int)api_data.api_ship[1];
                    teitoku.CurrentShips = (int)api_data.api_ship[0];
                    teitoku.ItemSlots = (int)api_data.api_slotitem[1];
                    teitoku.CurrentItems = (int)api_data.api_slotitem[0];
                    teitoku.Furnitures = (int)api_data.api_furniture;
                    return teitoku;
                }
            } catch (Exception e) {
                Utils.Log("Critical Error at DeepCachingForEachTeitokuAsync: " + e.Message, "SenkaModule", ConsoleColor.Red);
                throw;
            }
        }

        private void CalculateDiffBetweenPrevAndCurr() {
            foreach (var serverPair in m_dictLatestSortedSenkaDB) {
                if (!m_dictPreviousSortedSenkaDB.ContainsKey(serverPair.Key)) return;
                var prevSenkaList = m_dictPreviousSortedSenkaDB[serverPair.Key];
                var latestSenkaList = m_dictLatestSortedSenkaDB[serverPair.Key];
                for (int i = 1/*skip metadata*/; i < latestSenkaList.Count(); i++) {
                    var currTeitoku = latestSenkaList[i];
                    var prevTeitoku = prevSenkaList.Find(
                        x => currTeitoku.MemberId == x.MemberId && currTeitoku.MemberId > 0
                    );
                    if (prevTeitoku == null) {
                        if ((Utils.GetJstNow().Day == 1)) {
                            currTeitoku.DeltaSenka = currTeitoku.Senka;
                        }
                        continue;
                    }

                    if (prevTeitoku.Experiences > 0) {
                        // Assume max EXP Senka per hour is 20
                        var senkaFromExp = (currTeitoku.Experiences - prevTeitoku.Experiences) / 1428.0;
                        if (currTeitoku.Senka >= prevTeitoku.Senka) { // monthly Senka clear check
                            var tmpEOSenka = (currTeitoku.Senka - prevTeitoku.Senka - senkaFromExp);
                            currTeitoku.EOSenka = (tmpEOSenka + 20) < 75.0 ? 0.0 : tmpEOSenka;
                            currTeitoku.TotalEOSenka = prevTeitoku.TotalEOSenka + currTeitoku.EOSenka;
                            currTeitoku.DeltaSenka = currTeitoku.Senka - prevTeitoku.Senka;
                            //currTeitoku.InheritSenka = prevTeitoku.Senka * 1428.0 / 50000;

                        } else { // first day and first Senka data
                            //var tmpEOSenka = (currTeitoku.Senka - senkaFromExp - prevTeitoku.InheritSenka);
                            //currTeitoku.EOSenka = tmpEOSenka < 75 ? 0 : tmpEOSenka;
                            //currTeitoku.TotalEOSenka = currTeitoku.EOSenka;
                            //currTeitoku.DeltaSenka = currTeitoku.Senka - (int)prevTeitoku.InheritSenka;
                        }
                        currTeitoku.AverageSenkaPerHour = senkaFromExp / (currTeitoku.LastUpdate - prevTeitoku.LastUpdate).TotalHours;
                        currTeitoku.DeltaRankNo = prevTeitoku.RankNo - currTeitoku.RankNo;
                        currTeitoku.DeltaExp = currTeitoku.Experiences - prevTeitoku.Experiences;
                        currTeitoku.LastUpdate = DateTime.UtcNow;
                    }
                }
                Utils.Log(string.Format("server {0} differences has been calculate .", serverPair.Key), "SenkaModule", ConsoleColor.Green);
            }
        }

        /// <summary>
        /// Has bug
        /// </summary>
        /// <param name="forwardSecond"></param>
        /// <returns></returns>
        private int GetNextCycleTimeLeft(int forwardSecond = 10) {
            var currJST = Utils.GetJstNow().TimeOfDay;
            int hour = 0;
            int day = 0;
            if (currJST.Hours < 3) hour = 3;
            else if (currJST.Hours >= 3 && currJST.Hours < 15) hour = 15;
            else { hour = 3; day++; }
            TimeSpan nextTime = new TimeSpan(currJST.Days + day, hour, 0, currJST.Seconds, 0);
            return (int)Math.Floor((nextTime - currJST).TotalMilliseconds) + forwardSecond * 1000;
        }

        private string FormatedTimeLeft() {
            TimeSpan t = TimeSpan.FromMilliseconds(GetNextCycleTimeLeft());
            return string.Format(
                "{0:D2}:{1:D2}:{2:D2}:{3:D3}ms", t.Hours, t.Minutes, t.Seconds, t.Milliseconds);
        }

        private void ExportSenka(bool needExport = true) {
            if (!needExport) return;
            foreach (var serverPair in m_dictLatestSortedSenkaDB) {
                var prefix = (Consts.WorldServerName.FindIndex(n => n.Equals(serverPair.Value[1].Server)) + 1).ToString("D2");
                var exportFile =
                    Path.Combine(m_exportPath, string.Format("{0}_{1}", prefix, serverPair.Key));
                Directory.CreateDirectory(exportFile);
                var jst = TimeZoneInfo.ConvertTime(serverPair.Value[0].LastUpdate, TimeZoneInfo.FindSystemTimeZoneById(m_isWindows ? Utils.TZConvert("Sapporo") : "Japan"));

                var filename = string.Format(
                    "{0}-{1}-{2}_{3}.json",
                    jst.Year.ToString("D4"),
                    jst.Month.ToString("D2"),
                    jst.Hour >= 0 && jst.Hour < 3 ? (jst.Day - 1).ToString("D2") : jst.Day.ToString("D2"),
                    (jst.Hour >= 3 && jst.Hour < 15 ? 3 : 15).ToString("D2"));

                //filename = "2017-05-01_15.json";

                var localSavePath = Path.Combine(exportFile, filename);
                var serializedJSON = JsonConvert.SerializeObject(serverPair.Value, Formatting.Indented);

                if (File.Exists(localSavePath))
                    File.Copy(localSavePath, localSavePath + string.Format("_{0}.bak", DateTime.Now.ToFileTimeUtc()), true);
                File.WriteAllText(localSavePath, serializedJSON);

                if (m_isWindows) {
                    var botSavePath =
                        Path.Combine(@"D:\Paspy\Documents\kcsMonitor\SenkaData\", string.Format("{0}_{1}", prefix, serverPair.Key), filename);
                    File.WriteAllText(botSavePath, serializedJSON);
                }
                Utils.Log(string.Format("{0}'s senka {1} has been saved.", serverPair.Key, filename), "SenkaModule", ConsoleColor.Yellow);
            }
        }

        private const string MODULE_PATH = @"data/SenkaModule/";
        private const string DEFAULT_MEMBER_DB_ZIP = @"RawMemberData/{0}_2017_01.zip"; // change periodically
        private const string DEFAULT_TOKEN_FILE = @"data/SenkaModule/APITokens.xml";

        private const string API_RANK_PAGE = "http://{0}/kcsapi/api_req_ranking/mxltvkpyuklh";
        private const string API_GET_MEMBER_RECORD = "http://{0}/kcsapi/api_get_member/record";
        private const string API_GET_ENEMY_INFO = "http://{0}/kcsapi/api_req_member/get_practice_enemyinfo";

        private static readonly string[] RANK_NAME =
            { "", "元帥", "大将", "中将", "少将", "大佐", "中佐", "新米中佐", "少佐", "中堅少佐", "新米少佐" };

    }
}
