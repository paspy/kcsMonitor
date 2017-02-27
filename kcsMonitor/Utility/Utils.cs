using System;
using System.IO;
using System.Text;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading;
using System.Threading.Tasks;
using System.Security.Cryptography;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Linq;
using Newtonsoft.Json.Linq;

using Microsoft.Practices.EnterpriseLibrary.TransientFaultHandling;

namespace Paspy.kcsMonitor.Utility {
    public static class Utils {
        private static object locker = new object();

        public static void Log(string log, string module = "kcsMonitor", ConsoleColor fgc = ConsoleColor.Gray, ConsoleColor bgc = ConsoleColor.Black) {
            lock (locker) {
                using (StreamWriter sw = new StreamWriter(new FileStream("data/kcsMonitor.log", FileMode.Append, FileAccess.Write, FileShare.ReadWrite), Encoding.UTF8)) {

                    string s = string.Format("[{0}][{1}] {2}", DateTime.UtcNow.ToString(), module, log);
                    string head = string.Format("[{0}][{1}] ", DateTime.UtcNow.ToString(), module);
                    Console.BackgroundColor = ConsoleColor.Black;
                    Console.ForegroundColor = ConsoleColor.Gray;
                    Console.Write(head);
                    Console.BackgroundColor = bgc;
                    Console.ForegroundColor = fgc;
                    Console.WriteLine(log);
                    Console.BackgroundColor = ConsoleColor.Black;
                    Console.ForegroundColor = ConsoleColor.Gray;
                    sw.WriteLine(s);
                }
            }
        }

        public static bool StreamAreEqualHash(byte[] first, byte[] second) {
            byte[] firstHash = MD5.Create().ComputeHash(first);
            byte[] secondHash = MD5.Create().ComputeHash(second);

            for (int i = 0; i < firstHash.Length; i++) {
                if (firstHash[i] != secondHash[i])
                    return false;
            }
            return true;
        }

        public static HttpRequestMessage CreateHttpRequestMessage(string destUrl, HttpContent content) {
            var msg = new HttpRequestMessage();
            msg.Method = HttpMethod.Post;
            msg.Headers.Accept.Add(new MediaTypeWithQualityHeaderValue("*/*"));
            msg.Headers.AcceptEncoding.Add(new StringWithQualityHeaderValue("gzip"));
            msg.Headers.AcceptEncoding.Add(new StringWithQualityHeaderValue("deflate"));
            msg.Headers.UserAgent.ParseAdd("Mozilla/5.0 (Android; U; zh-CN) AppleWebKit/533.19.4 (KHTML, like Gecko) AdobeAIR/21.0 rqxbjmdizgzp");
            msg.Headers.ExpectContinue = false;
            msg.Headers.Referrer = new Uri("app:/AppMain.swf/[[DYNAMIC]]/1");
            msg.Headers.Add("x-flash-version", "21,0,0,174");
            msg.RequestUri = new Uri(destUrl);
            msg.Content = content;
            return msg;
        }

        public static DateTime GetJstNow() {
            return TimeZoneInfo.ConvertTime(
                DateTime.Now, TimeZoneInfo.Local,
                TimeZoneInfo.FindSystemTimeZoneById(RuntimeInformation.IsOSPlatform(OSPlatform.Windows) ? TZConvert("Sapporo") : "Japan"));
        }

        public static async Task<byte[]> DownloadDataTaskAsync(string address) {
            CancellationTokenSource source = new CancellationTokenSource();
            CancellationToken token = source.Token;
            try {
                using (var httpClient = new HttpClient()) {
                    using (var request = new HttpRequestMessage(HttpMethod.Get, new Uri(address))) {
                        var response = await RequestAsync(() => httpClient.SendAsync(request, token));
                        if (response == null) source.Cancel();
                        MemoryStream contentStream = await response.Content.ReadAsStreamAsync() as MemoryStream;
                        return contentStream.ToArray();
                    }
                }
            } catch (AggregateException) {

                throw;
            } finally {
                source.Dispose();
            }
        }

        private sealed class TransientErrorCatchAllStrategy : ITransientErrorDetectionStrategy {
            public bool IsTransient(Exception ex) {
                return true;
            }
        }

        // sample usage: var response = await RequestAsync(() => httpClient.GetAsync(url));
        public static Task<HttpResponseMessage> RequestAsync(Func<Task<HttpResponseMessage>> requester, int times = 20, int interval = 1) {
            var transientErrorDetectionStrategy = new TransientErrorCatchAllStrategy();
            var retryPolicy = new RetryPolicy(transientErrorDetectionStrategy, times, new TimeSpan(0, 0, interval));
            //you can subscribe to the RetryPolicy.Retrying event here to be notified 
            //of retry attempts (e.g. for logging purposes)
            return retryPolicy.ExecuteAsync(async () => {
                HttpResponseMessage response;
                try {
                    response = await requester().ConfigureAwait(false);
                } catch (TaskCanceledException e) //HttpClient throws this on timeout
                  {
                    //we need to convert it to a different exception
                    //otherwise ExecuteAsync will think we requested cancellation
                    var ne = new HttpRequestException("Critical HTTP exception", e);
                    Log(ne.Message, "RequestAsync", ConsoleColor.Red);
                    throw ne;
                }
                //assuming you treat an unsuccessful status code as an error
                //otherwise just return the response here
                return response.EnsureSuccessStatusCode();
            });
        }

        public static string TZConvert(string railsTimeZoneId) {
            return RailsWindowsMapping.ContainsKey(railsTimeZoneId)
                ? RailsWindowsMapping[railsTimeZoneId]
                : null;
        }

        private static readonly IReadOnlyDictionary<string, string> RailsWindowsMapping = new Dictionary<string, string> {
            {"Abu Dhabi", "Arabian Standard Time"},
            {"Adelaide", "Cen. Australia Standard Time"},
            {"Alaska", "Alaskan Standard Time"},
            {"Almaty", "Central Asia Standard Time"},
            {"American Samoa", "UTC-11"},
            {"Amsterdam", "W. Europe Standard Time"},
            {"Arizona", "US Mountain Standard Time"},
            {"Astana", "Bangladesh Standard Time"},
            {"Athens", "GTB Standard Time"},
            {"Atlantic Time (Canada)", "Atlantic Standard Time"},
            {"Auckland", "New Zealand Standard Time"},
            {"Azores", "Azores Standard Time"},
            {"Baghdad", "Arabic Standard Time"},
            {"Baku", "Azerbaijan Standard Time"},
            {"Bangkok", "SE Asia Standard Time"},
            {"Beijing", "China Standard Time"},
            {"Belgrade", "Central Europe Standard Time"},
            {"Berlin", "W. Europe Standard Time"},
            {"Bern", "W. Europe Standard Time"},
            {"Bogota", "SA Pacific Standard Time"},
            {"Brasilia", "E. South America Standard Time"},
            {"Bratislava", "Central Europe Standard Time"},
            {"Brisbane", "E. Australia Standard Time"},
            {"Brussels", "Romance Standard Time"},
            {"Bucharest", "GTB Standard Time"},
            {"Budapest", "Central Europe Standard Time"},
            {"Buenos Aires", "Argentina Standard Time"},
            {"Cairo", "Egypt Standard Time"},
            {"Canberra", "AUS Eastern Standard Time"},
            {"Cape Verde Is.", "Cape Verde Standard Time"},
            {"Caracas", "Venezuela Standard Time"},
            {"Casablanca", "Morocco Standard Time"},
            {"Central America", "Central America Standard Time"},
            {"Central Time (US & Canada)", "Central Standard Time"},
            {"Chennai", "India Standard Time"},
            {"Chihuahua", "Mountain Standard Time (Mexico)"},
            {"Chongqing", "China Standard Time"},
            {"Copenhagen", "Romance Standard Time"},
            {"Darwin", "AUS Central Standard Time"},
            {"Dhaka", "Bangladesh Standard Time"},
            {"Dublin", "GMT Standard Time"},
            {"Eastern Time (US & Canada)", "Eastern Standard Time"},
            {"Edinburgh", "GMT Standard Time"},
            {"Ekaterinburg", "Ekaterinburg Standard Time"},
            {"Fiji", "Fiji Standard Time"},
            {"Georgetown", "SA Western Standard Time"},
            {"Greenland", "Greenland Standard Time"},
            {"Guadalajara", "Central Standard Time (Mexico)"},
            {"Guam", "West Pacific Standard Time"},
            {"Hanoi", "SE Asia Standard Time"},
            {"Harare", "South Africa Standard Time"},
            {"Hawaii", "Hawaiian Standard Time"},
            {"Helsinki", "FLE Standard Time"},
            {"Hobart", "Tasmania Standard Time"},
            {"Hong Kong", "China Standard Time"},
            {"Indiana (East)", "US Eastern Standard Time"},
            {"International Date Line West", "UTC-11"},
            {"Irkutsk", "North Asia East Standard Time"},
            {"Islamabad", "Pakistan Standard Time"},
            {"Istanbul", "Turkey Standard Time"},
            {"Jakarta", "SE Asia Standard Time"},
            {"Jerusalem", "Israel Standard Time"},
            {"Kabul", "Afghanistan Standard Time"},
            {"Kaliningrad", "Kaliningrad Standard Time"},
            {"Kamchatka", "Russia Time Zone 11"},
            {"Karachi", "Pakistan Standard Time"},
            {"Kathmandu", "Nepal Standard Time"},
            {"Kolkata", "India Standard Time"},
            {"Krasnoyarsk", "North Asia Standard Time"},
            {"Kuala Lumpur", "Singapore Standard Time"},
            {"Kuwait", "Arab Standard Time"},
            {"Kyiv", "FLE Standard Time"},
            {"La Paz", "SA Western Standard Time"},
            {"Lima", "SA Pacific Standard Time"},
            {"Lisbon", "GMT Standard Time"},
            {"Ljubljana", "Central Europe Standard Time"},
            {"London", "GMT Standard Time"},
            {"Madrid", "Romance Standard Time"},
            {"Magadan", "Magadan Standard Time"},
            {"Marshall Is.", "UTC+12"},
            {"Mazatlan", "Mountain Standard Time (Mexico)"},
            {"Melbourne", "AUS Eastern Standard Time"},
            {"Mexico City", "Central Standard Time (Mexico)"},
            {"Mid-Atlantic", "UTC-02"},
            {"Midway Island", "UTC-11"},
            {"Minsk", "Belarus Standard Time"},
            {"Monrovia", "Greenwich Standard Time"},
            {"Monterrey", "Central Standard Time (Mexico)"},
            {"Montevideo", "Montevideo Standard Time"},
            {"Moscow", "Russian Standard Time"},
            {"Mountain Time (US & Canada)", "Mountain Standard Time"},
            {"Mumbai", "India Standard Time"},
            {"Muscat", "Arabian Standard Time"},
            {"Nairobi", "E. Africa Standard Time"},
            {"New Caledonia", "Central Pacific Standard Time"},
            {"New Delhi", "India Standard Time"},
            {"Newfoundland", "Newfoundland Standard Time"},
            {"Novosibirsk", "N. Central Asia Standard Time"},
            {"Nuku'alofa", "Tonga Standard Time"},
            {"Osaka", "Tokyo Standard Time"},
            {"Pacific Time (US & Canada)", "Pacific Standard Time"},
            {"Paris", "Romance Standard Time"},
            {"Perth", "W. Australia Standard Time"},
            {"Port Moresby", "West Pacific Standard Time"},
            {"Prague", "Central Europe Standard Time"},
            {"Pretoria", "South Africa Standard Time"},
            {"Quito", "SA Pacific Standard Time"},
            {"Rangoon", "Myanmar Standard Time"},
            {"Riga", "FLE Standard Time"},
            {"Riyadh", "Arab Standard Time"},
            {"Rome", "W. Europe Standard Time"},
            {"Samara", "Russia Time Zone 3"},
            {"Samoa", "Samoa Standard Time"},
            {"Santiago", "Pacific SA Standard Time"},
            {"Sapporo", "Tokyo Standard Time"},
            {"Sarajevo", "Central European Standard Time"},
            {"Saskatchewan", "Canada Central Standard Time"},
            {"Seoul", "Korea Standard Time"},
            {"Singapore", "Singapore Standard Time"},
            {"Skopje", "Central European Standard Time"},
            {"Sofia", "FLE Standard Time"},
            {"Solomon Is.", "Central Pacific Standard Time"},
            {"Srednekolymsk", "Russia Time Zone 10"},
            {"Sri Jayawardenepura", "Sri Lanka Standard Time"},
            {"St. Petersburg", "Russian Standard Time"},
            {"Stockholm", "W. Europe Standard Time"},
            {"Sydney", "AUS Eastern Standard Time"},
            {"Taipei", "Taipei Standard Time"},
            {"Tallinn", "FLE Standard Time"},
            {"Tashkent", "West Asia Standard Time"},
            {"Tbilisi", "Georgian Standard Time"},
            {"Tehran", "Iran Standard Time"},
            {"Tijuana", "Pacific Standard Time"},
            {"Tokelau Is.", "Tonga Standard Time"},
            {"Tokyo", "Tokyo Standard Time"},
            {"Ulaanbaatar", "Ulaanbaatar Standard Time"},
            {"Urumqi", "Central Asia Standard Time"},
            {"UTC", "UTC"},
            {"Vienna", "W. Europe Standard Time"},
            {"Vilnius", "FLE Standard Time"},
            {"Vladivostok", "Vladivostok Standard Time"},
            {"Volgograd", "Russian Standard Time"},
            {"Warsaw", "Central European Standard Time"},
            {"Wellington", "New Zealand Standard Time"},
            {"West Central Africa", "W. Central Africa Standard Time"},
            {"Yakutsk", "Yakutsk Standard Time"},
            {"Yerevan", "Caucasus Standard Time"},
            {"Zagreb", "Central European Standard Time"}
            };
    }

}
