using System.Collections.Generic;

namespace Paspy.kcsMonitor.KCData.ExportData {
    public class SlotItem {
        public SlotItem() {
            ItemIllustrateLinks = new List<string>();
            ItemIllustrateBase64 = new Dictionary<string, string>();
        }
        public int ID { set; get; }
        public int AlbumNo { set; get; }
        public string Name { set; get; }
        public string Introduction { set; get; }
        public bool IsAbyssal { set; get; }
        public int Firepower { set; get; }
        public int Torpedo { set; get; }
        public int Bombing { set; get; }
        public int AntiAir { set; get; }
        public int AntiSub { set; get; }
        public int Armor { set; get; }
        /// <summary>
        /// 命中 / 対爆
        /// </summary>
        public int Accuracy { set; get; }
        /// <summary>
        /// 回避 / 迎撃
        /// </summary>
        public int Evasion { set; get; }
        public int LineOfSight { set; get; }
        public int Range { set; get; }
        public int AircraftCost { set; get; }
        public int AircraftDistance { set; get; }
        public List<string> ItemIllustrateLinks { get; set; }
        public Dictionary<string, string> ItemIllustrateBase64 { get; set; }
    }

}
