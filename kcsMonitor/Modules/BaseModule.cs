using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Runtime.InteropServices;

namespace Paspy.kcsMonitor.Modules {
    public abstract class BaseModule {
        protected Timer m_checkingTimer;
        protected int m_timeInterval;
        protected bool m_isWindows;
        protected string m_exportPath;
        public BaseModule(int fetchTime) {
            m_isWindows = RuntimeInformation.IsOSPlatform(OSPlatform.Windows);
            m_timeInterval = fetchTime;
            m_checkingTimer = new Timer(StartModuleCycle, null, 0, Timeout.Infinite);
            IsModuleRunning = false;
        }

        public virtual bool IsModuleRunning { get; protected set; }

        public virtual void Restart() {
            if (!IsModuleRunning && m_checkingTimer != null) {
                m_checkingTimer.Dispose();
                m_checkingTimer = new Timer(StartModuleCycle, null, 0, Timeout.Infinite);
            }
        }

        protected virtual void StartModuleCycle(object state) { }
    }
}
