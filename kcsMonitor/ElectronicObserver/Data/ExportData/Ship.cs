using System.Collections.Generic;

namespace Paspy.kcsMonitor.KCData.ExportData {
    public class Ship {
        public Ship() {
            ShipIllustrateBase64 = new List<string>();
        }
        public int ID { set; get; }
        public int AlbumNo { set; get; }
        public string Name { set; get; }
        public string Introduction { set; get; }
        public bool IsAbyssal { set; get; }
        public bool IsLimitedIllustration { set; get; }
        public string HitPoint { set; get; }
        public string Firepower { set; get; }
        public string Torpedo { set; get; }
        public string AntiAir { set; get; }
        public string Armor { set; get; }
        public string Luck { set; get; }
        public string Speed { set; get; }
        public int EquipmentSlot { set; get; }
        public string AircraftSlot { set; get; }
        public int AircraftTotal { set; get; }
        public int RemodelLv { set; get; }
        public int RemodelSteel { set; get; }
        public int RemodelAmmo { set; get; }
        public string IllustrationSwfLink { get; set; }
        public List<string> ShipIllustrateBase64 { get; set; }
    }

}
