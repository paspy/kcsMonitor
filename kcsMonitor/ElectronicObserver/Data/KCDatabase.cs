////////////////////////////////////////////////////////
// Original author: Andante
// https://twitter.com/andanteyk
// https://github.com/andanteyk/ElectronicObserver
////////////////////////////////////////////////////////
using System;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using Paspy.kcsMonitor.KCData.ExportData;
using Paspy.kcsMonitor.Utility;

namespace ElectronicObserver.Data {

    /// <summary>
    /// 艦これのデータを扱う中核です。
    /// </summary>
    public sealed class KCDatabase {

        const string SHIP_SWF_URL = "http://{0}/kcs/resources/swf/ships/{1}.swf";
        const string SLOTITM_CARD_URL = "http://{0}/kcs/resources/image/slotitem/card/{1}.png";
        const string SLOTITM_ITEM_UP_URL = "http://{0}/kcs/resources/image/slotitem/item_up/{1}.png";
        const string SLOTITM_ITEM_ON_URL = "http://{0}/kcs/resources/image/slotitem/item_on/{1}.png";
        const string SLOTITM_CHARACTER_URL = "http://{0}/kcs/resources/image/slotitem/item_character/{1}.png";

        #region Initialize

        private IDDictionary<ShipDataMaster> m_newAddedMasterShips;
        private IDDictionary<ShipType> m_newAddedShipTypes;
        private IDDictionary<EquipmentDataMaster> m_newAddedEquipmentDataMaster;
        private IDDictionary<EquipmentType> m_newAddedEquipmentTypes;
        private IDDictionary<UseItemMaster> m_newAddedUseItemMaster;
        private IDDictionary<MapAreaData> m_newAddedMapAreaData;
        private IDDictionary<MapInfoData> m_newAddedMapInfoData;
        private IDDictionary<MissionData> m_newAddedMissionData;

        private IDDictionary<ShipDataMaster> m_updatedMasterShips;
        private IDDictionary<ShipType> m_updatedShipTypes;
        private IDDictionary<EquipmentDataMaster> m_updatedEquipmentDataMaster;
        private IDDictionary<EquipmentType> m_updatedEquipmentTypes;
        private IDDictionary<UseItemMaster> m_updatedUseItemMaster;
        private IDDictionary<MapAreaData> m_updatedMapAreaData;
        private IDDictionary<MapInfoData> m_updatedMapInfoData;
        private IDDictionary<MissionData> m_updatedMissionData;

        private KCDatabase() {
            MasterShips = new IDDictionary<ShipDataMaster>();
            ShipTypes = new IDDictionary<ShipType>();
            MasterEquipments = new IDDictionary<EquipmentDataMaster>();
            EquipmentTypes = new IDDictionary<EquipmentType>();
            MasterUseItems = new IDDictionary<UseItemMaster>();
            MapArea = new IDDictionary<MapAreaData>();
            MapInfo = new IDDictionary<MapInfoData>();
            Mission = new IDDictionary<MissionData>();

            m_updatedMasterShips = new IDDictionary<ShipDataMaster>();
            m_updatedShipTypes = new IDDictionary<ShipType>();
            m_updatedEquipmentDataMaster = new IDDictionary<EquipmentDataMaster>();
            m_updatedEquipmentTypes = new IDDictionary<EquipmentType>();
            m_updatedUseItemMaster = new IDDictionary<UseItemMaster>();
            m_updatedMapAreaData = new IDDictionary<MapAreaData>();
            m_updatedMapInfoData = new IDDictionary<MapInfoData>();
            m_updatedMissionData = new IDDictionary<MissionData>();

            m_newAddedMasterShips = new IDDictionary<ShipDataMaster>();
            m_newAddedShipTypes = new IDDictionary<ShipType>();
            m_newAddedEquipmentDataMaster = new IDDictionary<EquipmentDataMaster>();
            m_newAddedEquipmentTypes = new IDDictionary<EquipmentType>();
            m_newAddedUseItemMaster = new IDDictionary<UseItemMaster>();
            m_newAddedMapAreaData = new IDDictionary<MapAreaData>();
            m_newAddedMapInfoData = new IDDictionary<MapInfoData>();
            m_newAddedMissionData = new IDDictionary<MissionData>();
        }

        /// <summary>
        /// Clear the database
        /// </summary>
        public void Clear() {
            MasterShips.Clear();
            ShipTypes.Clear();
            MasterEquipments.Clear();
            EquipmentTypes.Clear();
            MasterUseItems.Clear();
            MapArea.Clear();
            MapInfo.Clear();
            Mission.Clear();
        }

        /// <summary>
        /// Clear the updated database
        /// </summary>
        public void ClearUpdated() {
            m_updatedMasterShips.Clear();
            m_updatedShipTypes.Clear();
            m_updatedEquipmentDataMaster.Clear();
            m_updatedEquipmentTypes.Clear();
            m_updatedUseItemMaster.Clear();
            m_updatedMapAreaData.Clear();
            m_updatedMapInfoData.Clear();
            m_updatedMissionData.Clear();
            m_newAddedMasterShips.Clear();
            m_newAddedShipTypes.Clear();
            m_newAddedEquipmentDataMaster.Clear();
            m_newAddedEquipmentTypes.Clear();
            m_newAddedUseItemMaster.Clear();
            m_newAddedMapAreaData.Clear();
            m_newAddedMapInfoData.Clear();
            m_newAddedMissionData.Clear();
        }
        #endregion

        /// <summary>
        /// 艦船のマスターデータ
        /// </summary>
        public IDDictionary<ShipDataMaster> MasterShips { get; private set; }

        /// <summary>
        /// 艦種データ
        /// </summary>
        public IDDictionary<ShipType> ShipTypes { get; private set; }

        /// <summary>
        /// 装備のマスターデータ
        /// </summary>
        public IDDictionary<EquipmentDataMaster> MasterEquipments { get; private set; }

        /// <summary>
        /// 装備種別
        /// </summary>
        public IDDictionary<EquipmentType> EquipmentTypes { get; private set; }

        /// <summary>
        /// アイテムのマスターデータ
        /// </summary>
        public IDDictionary<UseItemMaster> MasterUseItems { get; private set; }

        /// <summary>
        /// 海域カテゴリデータ
        /// </summary>
        public IDDictionary<MapAreaData> MapArea { get; private set; }

        /// <summary>
        /// 海域データ
        /// </summary>
        public IDDictionary<MapInfoData> MapInfo { get; private set; }

        /// <summary>
        /// 遠征データ
        /// </summary>
        public IDDictionary<MissionData> Mission { get; private set; }

        public void InitializeApiStart2(dynamic data) {
            string APIName = "api_start2";

            if (data.api_data != null && data.api_result == 1) {
                data = data.api_data;
            }

            //特別置換処理
            data.api_mst_stype[7].api_name = "巡洋戦艦";

            ClearUpdated();

            //api_mst_ship
            foreach (var elem in data.api_mst_ship) {

                int id = (int)elem.api_id;
                if (MasterShips[id] == null) {
                    var ship = new ShipDataMaster();
                    ship.LoadFromResponse(APIName, elem);
                    MasterShips.Add(ship);
                } else {
                    MasterShips[id].LoadFromResponse(APIName, elem);
                }
            }

            //改装関連のデータ設定
            foreach (var ship in MasterShips) {
                var remodelID = ship.Value.RemodelAfterShipID;
                if (remodelID != 0) {
                    MasterShips[remodelID].RemodelBeforeShipID = ship.Key;
                }
            }

            //api_mst_shipgraph
            foreach (var elem in data.api_mst_shipgraph) {

                int id = (int)elem.api_id;
                ShipDataMaster ship = MasterShips[id];
                if (ship != null) {
                    ship.ResourceName = elem.api_filename;
                    dynamic versions = elem.api_version;
                    ship.ResourceGraphicVersion = versions[0];
                    ship.ResourceVoiceVersion = versions[1];
                    ship.ResourcePortVoiceVersion = versions[2];
                }
            }

            //api_mst_slotitem_equiptype
            foreach (var elem in data.api_mst_slotitem_equiptype) {

                int id = (int)elem.api_id;
                if (EquipmentTypes[id] == null) {
                    var eqt = new EquipmentType();
                    eqt.LoadFromResponse(APIName, elem);
                    EquipmentTypes.Add(eqt);
                } else {
                    EquipmentTypes[id].LoadFromResponse(APIName, elem);
                }
            }


            //api_mst_stype
            foreach (var elem in data.api_mst_stype) {
                int id = (int)elem.api_id;
                if (ShipTypes[id] == null) {
                    var spt = new ShipType();
                    spt.LoadFromResponse(APIName, elem);
                    ShipTypes.Add(spt);
                } else {
                    ShipTypes[id].LoadFromResponse(APIName, elem);
                }
            }


            //api_mst_slotitem
            foreach (var elem in data.api_mst_slotitem) {
                int id = (int)elem.api_id;
                if (MasterEquipments[id] == null) {
                    var eq = new EquipmentDataMaster();
                    eq.LoadFromResponse(APIName, elem);
                    MasterEquipments.Add(eq);
                } else {
                    MasterEquipments[id].LoadFromResponse(APIName, elem);
                }
            }

            //api_mst_slotitemgraph
            /*
			foreach ( var elem in data.api_mst_slotitemgraph ) {

				int id = (int)elem.api_id;
				EquipmentDataMaster eq = db.MasterEquipments[id];
				if ( eq != null ) {
					eq.ResourceVersion = elem.api_version;
				}
			}
			*/

            //api_mst_useitem
            foreach (var elem in data.api_mst_useitem) {

                int id = (int)elem.api_id;
                if (MasterUseItems[id] == null) {
                    var item = new UseItemMaster();
                    item.LoadFromResponse(APIName, elem);
                    MasterUseItems.Add(item);
                } else {
                    MasterUseItems[id].LoadFromResponse(APIName, elem);
                }
            }

            //api_mst_maparea
            foreach (var elem in data.api_mst_maparea) {
                int id = (int)elem.api_id;
                if (MapArea[id] == null) {
                    var item = new MapAreaData();
                    item.LoadFromResponse(APIName, elem);
                    MapArea.Add(item);
                } else {
                    MapArea[id].LoadFromResponse(APIName, elem);
                }
            }

            //api_mst_mapinfo
            foreach (var elem in data.api_mst_mapinfo) {

                int id = (int)elem.api_id;
                if (MapInfo[id] == null) {
                    var item = new MapInfoData();
                    item.LoadFromResponse(APIName, elem);
                    MapInfo.Add(item);
                } else {
                    MapInfo[id].LoadFromResponse(APIName, elem);
                }
            }

            //api_mst_mission
            foreach (var elem in data.api_mst_mission) {
                int id = (int)elem.api_id;
                if (Mission[id] == null) {
                    var item = new MissionData();
                    item.LoadFromResponse(APIName, elem);
                    Mission.Add(item);
                } else {
                    Mission[id].LoadFromResponse(APIName, elem);
                }
            }

            //api_mst_shipupgrade
            Dictionary<int, int> upgradeLevels = new Dictionary<int, int>();
            foreach (var elem in data.api_mst_shipupgrade) {

                int idbefore = (int)elem.api_current_ship_id;
                int idafter = (int)elem.api_id;
                var shipbefore = MasterShips[idbefore];
                var shipafter = MasterShips[idafter];
                int level = (int)elem.api_upgrade_level;

                if (upgradeLevels.ContainsKey(idafter)) {
                    if (level < upgradeLevels[idafter]) {
                        shipafter.RemodelBeforeShipID = idbefore;
                        upgradeLevels[idafter] = level;
                    }
                } else {
                    shipafter.RemodelBeforeShipID = idbefore;
                    upgradeLevels.Add(idafter, level);
                }

                if (shipbefore != null) {
                    shipbefore.NeedBlueprint = (int)elem.api_drawing_count;
                    shipbefore.NeedCatapult = (int)elem.api_catapult_count;
                }
            }
        }

        public void UpdateApiStart2(dynamic data) {
            string APIName = "api_start2";

            if (data.api_data != null && data.api_result == 1) {
                data = data.api_data;
            }

            //特別置換処理
            data.api_mst_stype[7].api_name = "巡洋戦艦";

            //api_mst_ship
            foreach (var elem in data.api_mst_ship) {
                int id = (int)elem.api_id;
                if (MasterShips[id] == null) {
                    var ship = new ShipDataMaster();
                    ship.LoadFromResponse(APIName, elem);
                    m_newAddedMasterShips.Add(ship);
                } else if (!JToken.DeepEquals(MasterShips[id].RawData, elem)) {
                    var ship = new ShipDataMaster();
                    ship.LoadFromResponse(APIName, elem);
                    m_updatedMasterShips.Add(ship);
                }
            }

            //api_mst_shipgraph
            foreach (var elem in data.api_mst_shipgraph) {
                int id = (int)elem.api_id;
                ShipDataMaster ship = m_updatedMasterShips[id];
                if (ship != null) {
                    ship.ResourceName = elem.api_filename;
                    dynamic versions = elem.api_version;
                    ship.ResourceGraphicVersion = versions[0];
                    ship.ResourceVoiceVersion = versions[1];
                    ship.ResourcePortVoiceVersion = versions[2];
                }
                ship = m_newAddedMasterShips[id];
                if (ship != null) {
                    ship.ResourceName = elem.api_filename;
                    dynamic versions = elem.api_version;
                    ship.ResourceGraphicVersion = versions[0];
                    ship.ResourceVoiceVersion = versions[1];
                    ship.ResourcePortVoiceVersion = versions[2];
                }
            }

            //api_mst_slotitem_equiptype
            foreach (var elem in data.api_mst_slotitem_equiptype) {
                int id = (int)elem.api_id;
                if (EquipmentTypes[id] == null) {
                    var eqt = new EquipmentType();
                    eqt.LoadFromResponse(APIName, elem);
                    m_newAddedEquipmentTypes.Add(eqt);
                } else if (!JToken.DeepEquals(EquipmentTypes[id].RawData, elem)) {
                    var eqt = new EquipmentType();
                    eqt.LoadFromResponse(APIName, elem);
                    m_updatedEquipmentTypes.Add(eqt);
                }
            }

            //api_mst_stype
            foreach (var elem in data.api_mst_stype) {
                int id = (int)elem.api_id;
                if (ShipTypes[id] == null) {
                    var spt = new ShipType();
                    spt.LoadFromResponse(APIName, elem);
                    m_newAddedShipTypes.Add(spt);
                } else {
                    var spt = new ShipType();
                    spt.LoadFromResponse(APIName, elem);
                    if (!JToken.DeepEquals(ShipTypes[id].RawData, spt.RawData))
                        m_updatedShipTypes.Add(spt);
                }
            }

            //api_mst_slotitem
            foreach (var elem in data.api_mst_slotitem) {
                int id = (int)elem.api_id;
                if (MasterEquipments[id] == null) {
                    var eq = new EquipmentDataMaster();
                    eq.LoadFromResponse(APIName, elem);
                    m_newAddedEquipmentDataMaster.Add(eq);
                } else if (!JToken.DeepEquals(MasterEquipments[id].RawData, elem)) {
                    var eq = new EquipmentDataMaster();
                    eq.LoadFromResponse(APIName, elem);
                    m_updatedEquipmentDataMaster.Add(eq);
                }
            }

            //api_mst_useitem
            foreach (var elem in data.api_mst_useitem) {
                int id = (int)elem.api_id;
                if (MasterUseItems[id] == null) {
                    var item = new UseItemMaster();
                    item.LoadFromResponse(APIName, elem);
                    m_newAddedUseItemMaster.Add(item);
                } else if (!JToken.DeepEquals(MasterUseItems[id].RawData, elem)) {
                    var item = new UseItemMaster();
                    item.LoadFromResponse(APIName, elem);
                    m_updatedUseItemMaster.Add(item);
                }
            }

            //api_mst_maparea
            foreach (var elem in data.api_mst_maparea) {
                int id = (int)elem.api_id;
                if (MapArea[id] == null) {
                    var item = new MapAreaData();
                    item.LoadFromResponse(APIName, elem);
                    m_newAddedMapAreaData.Add(item);
                } else if (!JToken.DeepEquals(MapArea[id].RawData, elem)) {
                    var item = new MapAreaData();
                    item.LoadFromResponse(APIName, elem);
                    m_updatedMapAreaData.Add(item);
                }
            }

            //api_mst_mapinfo
            foreach (var elem in data.api_mst_mapinfo) {
                int id = (int)elem.api_id;
                if (MapInfo[id] == null) {
                    var item = new MapInfoData();
                    item.LoadFromResponse(APIName, elem);
                    m_newAddedMapInfoData.Add(item);
                } else if (!JToken.DeepEquals(MapInfo[id].RawData, elem)) {
                    var item = new MapInfoData();
                    item.LoadFromResponse(APIName, elem);
                    m_updatedMapInfoData.Add(item);
                }
            }

            //api_mst_mission
            foreach (var elem in data.api_mst_mission) {
                int id = (int)elem.api_id;
                if (Mission[id] == null) {
                    var item = new MissionData();
                    item.LoadFromResponse(APIName, elem);
                    m_newAddedMissionData.Add(item);
                } else if (!JToken.DeepEquals(Mission[id].RawData, elem)) {
                    var item = new MissionData();
                    item.LoadFromResponse(APIName, elem);
                    m_updatedMissionData.Add(item);
                }
            }

        }

        public void PrintUpdatedReport() {

        }

        public void ExportNewAddedShipAndSlotitem(string server,
            out Dictionary<string, List<Ship>> _exportedShips,
            out List<SlotItem> _exportedSlotItems) {
            _exportedShips = new Dictionary<string, List<Ship>>();
            _exportedSlotItems = new List<SlotItem>();
            _exportedShips["ship"] = new List<Ship>();
            _exportedShips["abyssal"] = new List<Ship>();
            _exportedShips["limited"] = new List<Ship>();
            foreach (var ship in m_newAddedMasterShips.Values) {
                if (_exportedShips["abyssal"].Exists(s => s.Name.Equals(ship.Name))) continue;
                Ship exportShip = new Ship();
                exportShip.ID = ship.ID;
                exportShip.AlbumNo = ship.AlbumNo;
                exportShip.Name = ship.Name;
                exportShip.Introduction = ship.MessageGet;
                exportShip.IsAbyssal = ship.IsAbyssalShip;
                exportShip.IsLimitedIllustration = ship.ID >= 825;
                exportShip.HitPoint = string.Format("{0}/{1}({2})", ship.HPMin, ship.HPMax, ship.HPMaxMarried);
                exportShip.Firepower = string.Format("{0}/{1}", ship.FirepowerMin, ship.FirepowerMax);
                exportShip.Torpedo = string.Format("{0}/{1}", ship.TorpedoMin, ship.TorpedoMax);
                exportShip.AntiAir = string.Format("{0}/{1}", ship.AAMin, ship.AAMax);
                exportShip.Armor = string.Format("{0}/{1}", ship.ArmorMin, ship.ArmorMax);
                exportShip.Luck = string.Format("{0}/{1}", ship.LuckMin, ship.LuckMax);
                exportShip.Speed = ship.Speed <= 5 ? (ship.Speed == 0 ? "陸上基地" : "低速") : "高速"; // 0=陸上基地, 5=低速, 10=高速
                exportShip.EquipmentSlot = ship.SlotSize;
                exportShip.AircraftSlot = string.Format("[{0}][{1}][{2}][{3}]", ship.Aircraft[0], ship.Aircraft[1], ship.Aircraft[2], ship.Aircraft[3]);
                exportShip.AircraftTotal = ship.AircraftTotal;
                exportShip.RemodelLv = ship.RemodelAfterLevel;
                exportShip.RemodelSteel = ship.RemodelSteel;
                exportShip.RemodelAmmo = ship.RemodelAmmo;
                exportShip.IllustrationSwfLink = string.Format(SHIP_SWF_URL, server, ship.ResourceName);
                Utils.Log(string.Format("New Ship: {0}", exportShip.Name), "KCDatabase");
                if (exportShip.IsAbyssal)
                    _exportedShips["abyssal"].Add(exportShip);
                else if (exportShip.IsLimitedIllustration)
                    _exportedShips["limited"].Add(exportShip);
                else
                    _exportedShips["ship"].Add(exportShip);
            }

            foreach (var item in m_newAddedEquipmentDataMaster.Values) {
                SlotItem exportSlotItem = new SlotItem();
                exportSlotItem.ID = item.ID;
                exportSlotItem.AlbumNo = item.AlbumNo;
                exportSlotItem.Name = item.Name;
                exportSlotItem.Introduction = item.Message;
                exportSlotItem.IsAbyssal = item.IsAbyssalEquipment;
                exportSlotItem.Firepower = item.Firepower;
                exportSlotItem.Torpedo = item.Torpedo;
                exportSlotItem.Bombing = item.Bomber;
                exportSlotItem.AntiAir = item.AA;
                exportSlotItem.AntiSub = item.ASW;
                exportSlotItem.Armor = item.Armor;
                exportSlotItem.Accuracy = item.Accuracy;
                exportSlotItem.Evasion = item.Evasion;
                exportSlotItem.LineOfSight = item.LOS;
                exportSlotItem.Range = item.Range;
                exportSlotItem.AircraftCost = item.AircraftCost;
                exportSlotItem.AircraftDistance = item.AircraftDistance;
                if (!exportSlotItem.IsAbyssal) {
                    exportSlotItem.ItemIllustrateLinks = new List<string>()
                    {
                        string.Format(SLOTITM_CARD_URL, server, exportSlotItem.ID),
                        string.Format(SLOTITM_ITEM_UP_URL, server, exportSlotItem.ID),
                        string.Format(SLOTITM_ITEM_ON_URL, server, exportSlotItem.ID),
                        string.Format(SLOTITM_CHARACTER_URL, server, exportSlotItem.ID),
                    };
                }
                Utils.Log(string.Format("New Equipment: {0}", exportSlotItem.Name), "KCDatabase");
                _exportedSlotItems.Add(exportSlotItem);
            }
        }

        #region Singleton

        private static volatile KCDatabase __instance;
        private static object __syncRoot = new object();
        public static KCDatabase Instance {
            get {
                if (__instance == null) {
                    lock (__syncRoot) {
                        if (__instance == null)
                            __instance = new KCDatabase();
                    }
                }
                return __instance;
            }
        }

        #endregion

    }
}
