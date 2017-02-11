using System.Threading;
using System.Threading.Tasks;
using System.Net.Http;

namespace Paspy.kcsMonitor.Utility {
    public class RetryHandler : DelegatingHandler {
        private int m_maxRetries;
        public RetryHandler(HttpMessageHandler innerHandler, int maxRetries = 30)
            : base(innerHandler) {
            m_maxRetries = maxRetries;
        }

        protected override async Task<HttpResponseMessage> SendAsync(
            HttpRequestMessage request,
            CancellationToken cancellationToken) {
            HttpResponseMessage response = null;
            for (int i = 1; i <= m_maxRetries; i++) {
                response = await base.SendAsync(request, cancellationToken);
                if (response.IsSuccessStatusCode) {
                    return response;
                }
                Utils.Log(string.Format("{0} download failed. ({1})", request.RequestUri.ToString(), i), "RetryHandler");
            }
            return response;
        }
    }

}
