using System;
using System.Collections.Generic;

/// <summary>
/// Version 1.0.0
/// </summary>
namespace Paspy.kcsMonitor.Modules.Data {

    public struct PracticeShip {
        public long _id { get; set; }
        public int Level { get; set; }
        public int ShipId { get; set; }
        public int Star { get; set; }
    }

    public class Teitoku {
        public Teitoku(int rn = 0, string nn = "", string r = "", string c = "", int m = 0, int s = 0) {
            RankNo = rn; Nickname = nn; Rank = r; Comment = c; MedalNum = m; Senka = s;
            LastUpdate = DateTime.UtcNow;
        }

        public Teitoku() {
            LastUpdate = DateTime.UtcNow;
        }

        #region Share Properties
        public string Nickname { get; set; }
        public string Comment { get; set; }
        public string Rank { get; set; }
        #endregion

        #region Ranking
        public int RankNo { get; set; }
        public int MedalNum { get; set; }
        public int Senka { get; set; }
        #endregion

        #region Practice
        public int HeadquarterLevel { get; set; }
        public int MemberId { get; set; }
        public long Experiences { get; set; }
        public string DeckName { get; set; }
        public List<PracticeShip> DeckShips { get; set; }
        public int ShipSlots { get; set; }
        public int CurrentShips { get; set; }
        public int ItemSlots { get; set; }
        public int CurrentItems { get; set; }
        public int Furnitures { get; set; }
        #endregion

        #region Extra
        /// <summary>
        /// EOSenka = PrevEOSenka + CurrSenka - PrevSenka - (CurrExp - PrevExp) / 1428.0
        /// </summary>
        public double EOSenka { get; set; }
        public double TotalEOSenka { get; set; }
        public int DeltaRankNo { get; set; }
        public int DeltaSenka { get; set; }
        public double AverageSenkaPerHour { get; set; }
        #endregion

        #region Miscellaneous
        public string Server { get; set; }
        public List<RawMember> Candidates { get; set; }
        public DateTime LastUpdate { get; set; }
        #endregion

    }
}
