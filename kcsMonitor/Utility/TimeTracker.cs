using System;
using System.Collections.Generic;

namespace Paspy.kcsMonitor.Utility {
    /// <summary>
    /// A small object to measure the time between two or more operations.
    /// </summary>
    public class TimeTracker {
        #region Nested Types
        public enum TimeFormat { Nanoseconds, Microseconds, Milliseconds, Seconds, Minutes, Hours }
        #endregion Nested Types

        #region Private Fields
        private Dictionary<string, long> m_TrackList;
        #endregion Private Fields

        #region Constructor
        public TimeTracker() : this(null) {
        }

        public TimeTracker(string lapName) {
            if (TrackList == null) m_TrackList = new Dictionary<string, long>();
            if (!string.IsNullOrEmpty(lapName)) AddLap(lapName);
        }
        #endregion Constructor

        #region Methods
        /// <summary>
        /// Adds a lap to the TimeTracker
        /// </summary>
        /// <param name="lapName"></param>
        public void AddLap(string lapName) {
            TrackList[lapName] = GetCurrentTime();
        }

        /// <summary>
        /// Gets the TimeDiff between the two given laps in time units specified by the given [TimeTracker.TimeFormat]
        /// </summary>
        /// <param name="startLap">name of the starting lap</param>
        /// <param name="endLap">name of the ending lap</param>
        /// <param name="format">a valid [TimeTracker.TimeFormat] enum value</param>
        /// <returns>a decimal representing the TimeDiff in time units specified by the given [TimeTracker.TimeFormat].</returns>
        public decimal GetLapTimeDiff(string startLap, string endLap, TimeFormat format = TimeFormat.Milliseconds) {
            if (!TrackList.ContainsKey(startLap)) throw new Exception(String.Format("Starting Lap '{0}' cannot be found.", startLap));
            if (!TrackList.ContainsKey(endLap)) throw new Exception(String.Format("Ending Lap '{0}' cannot be found.", endLap));
            return CalculateTime(TrackList[endLap] - TrackList[startLap], format);
        }

        protected virtual decimal CalculateTime(long tDiff, TimeFormat format = TimeFormat.Milliseconds) {
            switch (format) {
                case TimeFormat.Nanoseconds:
                    return (decimal)(tDiff * 100);
                case TimeFormat.Microseconds:
                    return (decimal)(tDiff / (long)10);
                case TimeFormat.Milliseconds:
                default:
                    return (decimal)(tDiff / (long)10000);
                case TimeFormat.Seconds:
                    return (decimal)(tDiff / (long)10000000);
                case TimeFormat.Minutes:
                    return (decimal)(tDiff / (long)600000000);
                case TimeFormat.Hours:
                    return (decimal)(tDiff / (long)36000000000);
            }
        }

        /// <summary>
        /// Protected (overridable) method to get the current lap time.
        /// </summary>
        /// <returns></returns>
        protected virtual long GetCurrentTime() {
            return DateTime.UtcNow.ToFileTimeUtc();
        }

        /// <summary>
        /// Protected method to check if given lap name exists.
        /// </summary>
        /// <param name="lapNames"></param>
        protected void CheckLapNames(params string[] lapNames) {
            foreach (string n in lapNames) if (!TrackList.ContainsKey(n)) throw new Exception(String.Format("Lap '{0}' cannot be found.", n));
        }
        #endregion Methods

        #region Properties
        /// <summary>
        /// Returns TRUE if the TimeTracker's TrackList is Empty, FALSE otherwise.
        /// </summary>
        public bool IsEmpty {
            get { return (TrackList == null || TrackList.Count == 0); }
        }

        /// <summary>
        /// Dictionary containing the laps (if any)
        /// </summary>
        protected Dictionary<string, long> TrackList {
            get { return m_TrackList; }
        }
        #endregion Properties
    }
}
