using System;
using System.IO;
using System.Text;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading;
using System.Threading.Tasks;
using System.Security.Cryptography;
using System.Collections.Generic;
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

        public static DateTime GetNowJST() {
            return TimeZoneInfo.ConvertTime(DateTime.Now, TimeZoneInfo.Local, TimeZoneInfo.FindSystemTimeZoneById("Tokyo Standard Time"));
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

    }
}
