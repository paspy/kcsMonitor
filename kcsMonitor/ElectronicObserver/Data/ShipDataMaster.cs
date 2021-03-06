﻿////////////////////////////////////////////////////////
// Original author: Andante
// https://twitter.com/andanteyk
// https://github.com/andanteyk/ElectronicObserver
////////////////////////////////////////////////////////
using System;
using System.Linq;
using System.Collections.ObjectModel;

namespace ElectronicObserver.Data {

    /// <summary>
    /// 艦船のマスターデータを保持します。
    /// </summary>
    public class ShipDataMaster : ResponseWrapper, IIdentifiable {

        /// <summary>
        /// 艦船ID
        /// </summary>
        public int ShipID {
            get { return int.Parse((string)RawData.api_id); }
        }

        /// <summary>
        /// 図鑑番号
        /// </summary>
        public int AlbumNo {
            get {
                try {
                    return RawData.api_sortno != null ? int.Parse((string)RawData.api_sortno) : 0;
                } catch (Exception) {
                    return 0;
                }
                //return !RawData.api_sortno() ? 0 : (string)RawData.api_sortno;
            }
        }

        /// <summary>
        /// 名前
        /// </summary>
        public string Name {
            get { return (string)RawData.api_name; }
        }

        /// <summary>
        /// 読み
        /// </summary>
        public string NameReading {
            get { return RawData.api_yomi; }
        }

        /// <summary>
        /// 艦種
        /// </summary>
        public int ShipType {
            get { return int.Parse((string)RawData.api_stype); }
        }


        /// <summary>
        /// 改装Lv.
        /// </summary>
        public int RemodelAfterLevel {
            //get { return !RawData.api_afterlv() ? 0 : (string)RawData.api_afterlv; }
            get {
                try {
                    return RawData.api_afterlv != null ? int.Parse((string)RawData.api_afterlv) : 0;
                } catch (Exception) {
                    return 0;
                }
            }
        }

        /// <summary>
        /// 改装後の艦船ID
        /// 0=なし
        /// </summary>
        public int RemodelAfterShipID {
            //get { return !RawData.api_aftershipid() ? 0 : int.Parse((string)RawData.api_aftershipid); }
            get {
                try {
                    return RawData.api_aftershipid != null ? int.Parse((string)RawData.api_aftershipid) : 0;
                } catch (Exception) {
                    return 0;
                }
            }
        }

        /// <summary>
        /// 改装後の艦船
        /// </summary>
        public ShipDataMaster RemodelAfterShip {
            get { return RemodelAfterShipID > 0 ? KCDatabase.Instance.MasterShips[RemodelAfterShipID] : null; }
        }


        /// <summary>
        /// 改装前の艦船ID
        /// 0=なし
        /// </summary>
        public int RemodelBeforeShipID { get; internal set; }

        /// <summary>
        /// 改装前の艦船
        /// </summary>
        public ShipDataMaster RemodelBeforeShip {
            get { return RemodelBeforeShipID > 0 ? KCDatabase.Instance.MasterShips[RemodelBeforeShipID] : null; }
        }


        /// <summary>
        /// 改装に必要な弾薬
        /// </summary>
        public int RemodelAmmo {
            //get { return !RawData.api_afterbull() ? 0 : (string)RawData.api_afterbull; }
            get { try { return RawData.api_afterbull != null ? int.Parse((string)RawData.api_afterbull) : 0; } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// 改装に必要な鋼材
        /// </summary>
        public int RemodelSteel {
            //get { return !RawData.api_afterfuel() ? 0 : (string)RawData.api_afterfuel; }
            get { try { return RawData.api_afterfuel != null ? int.Parse((string)RawData.api_afterfuel) : 0; } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// 改装に改装設計図が必要かどうか
        /// </summary>
        public int NeedBlueprint { get; internal set; }

        /// <summary>
        /// 改装に試製甲板カタパルトが必要かどうか
        /// </summary>
        public int NeedCatapult { get; internal set; }


        #region Parameters

        /// <summary>
        /// 耐久初期値
        /// </summary>
        public int HPMin {
            //get {
            //    if (RawData.api_taik()) {
            //        return (string)RawData.api_taik[0];
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null)
            //            return p.HPMin;
            //        else
            //            return 0;
            //    }
            //}
            get {
                try {
                    return RawData.api_taik != null ? int.Parse((string)RawData.api_taik[0]) : 0;
                } catch (Exception) {
                    return 0;
                }
            }
        }

        /// <summary>
        /// 耐久最大値
        /// </summary>
        public int HPMax {
            //get {
            //    if (RawData.api_taik()) {
            //        return (string)RawData.api_taik[1];
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null)
            //            return p.HPMax;
            //        else
            //            return 0;
            //    }
            //}
            get { try { return RawData.api_taik != null ? int.Parse((string)RawData.api_taik[1]) : 0; } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// 装甲初期値
        /// </summary>
        public int ArmorMin {
            //get {
            //    if (RawData.api_souk()) {
            //        return (string)RawData.api_souk[0];
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null)
            //            return p.ArmorMin;
            //        else
            //            return 0;
            //    }
            //}
            get { try { return RawData.api_souk != null ? int.Parse((string)RawData.api_souk[0]) : 0; } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// 装甲最大値
        /// </summary>
        public int ArmorMax {
            //get {
            //    if (RawData.api_souk()) {
            //        return (string)RawData.api_souk[1];
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null)
            //            return p.ArmorMax;
            //        else
            //            return 0;
            //    }
            //}
            get { try { return RawData.api_souk != null ? int.Parse((string)RawData.api_souk[1]) : 0; } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// 火力初期値
        /// </summary>
        public int FirepowerMin {
            //get {
            //    if (RawData.api_houg()) {
            //        return (string)RawData.api_houg[0];
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null)
            //            return p.FirepowerMin;
            //        else
            //            return 0;
            //    }
            //}
            get { try { return RawData.api_houg != null ? int.Parse((string)RawData.api_houg[0]) : 0; } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// 火力最大値
        /// </summary>
        public int FirepowerMax {
            //get {
            //    if (RawData.api_houg()) {
            //        return (string)RawData.api_houg[1];
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null)
            //            return p.FirepowerMax;
            //        else
            //            return 0;
            //    }
            //}
            get { try { return RawData.api_houg != null ? int.Parse((string)RawData.api_houg[1]) : 0; } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// 雷装初期値
        /// </summary>
        public int TorpedoMin {
            //get {
            //    if (RawData.api_raig()) {
            //        return (string)RawData.api_raig[0];
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null)
            //            return p.TorpedoMin;
            //        else
            //            return 0;
            //    }
            //}
            get { try { return RawData.api_raig != null ? int.Parse((string)RawData.api_raig[0]) : 0; } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// 雷装最大値
        /// </summary>
        public int TorpedoMax {
            //get {
            //    if (RawData.api_raig()) {
            //        return (string)RawData.api_raig[1];
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null)
            //            return p.TorpedoMax;
            //        else
            //            return 0;
            //    }
            //}
            get { try { return RawData.api_raig != null ? int.Parse((string)RawData.api_raig[1]) : 0; } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// 対空初期値
        /// </summary>
        public int AAMin {
            //get {
            //    if (RawData.api_tyku()) {
            //        return (string)RawData.api_tyku[0];
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null)
            //            return p.AAMin;
            //        else
            //            return 0;
            //    }
            //}
            get { try { return RawData.api_tyku != null ? int.Parse((string)RawData.api_tyku[0]) : 0; } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// 対空最大値
        /// </summary>
        public int AAMax {
            //get {
            //    if (RawData.api_tyku()) {
            //        return (string)RawData.api_tyku[1];
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null)
            //            return p.AAMax;
            //        else
            //            return 0;
            //    }
            //}
            get { try { return RawData.api_tyku != null ? int.Parse((string)RawData.api_tyku[1]) : 0; } catch (Exception) { return 0; } }
        }


        /// <summary>
        /// 対潜
        /// </summary>
        //public ShipParameterRecord.Parameter ASW {
        //    get {
        //        var p = GetParameterElement();
        //        if (p != null)
        //            return p.ASW;
        //        else
        //            return null;
        //    }
        //}

        /// <summary>
        /// 回避
        /// </summary>
        //public ShipParameterRecord.Parameter Evasion {
        //    get {
        //        var p = GetParameterElement();
        //        if (p != null)
        //            return p.Evasion;
        //        else
        //            return null;
        //    }
        //}

        /// <summary>
        /// 索敵
        /// </summary>
        //public ShipParameterRecord.Parameter LOS {
        //    get {
        //        var p = GetParameterElement();
        //        if (p != null)
        //            return p.LOS;
        //        else
        //            return null;
        //    }
        //}


        /// <summary>
        /// 運初期値
        /// </summary>
        public int LuckMin {
            //get {
            //    if (RawData.api_luck()) {
            //        return (string)RawData.api_luck[0];
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null)
            //            return p.LuckMin;
            //        else
            //            return 0;
            //    }
            //}
            get { try { return RawData.api_luck != null ? int.Parse((string)RawData.api_luck[0]) : 0; } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// 運最大値
        /// </summary>
        public int LuckMax {
            //get {
            //    if (RawData.api_luck()) {
            //        return (string)RawData.api_luck[1];
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null)
            //            return p.LuckMax;
            //        else
            //            return 0;
            //    }
            //}
            get { try { return RawData.api_luck != null ? int.Parse((string)RawData.api_luck[1]) : 0; } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// 速力
        /// 0=陸上基地, 5=低速, 10=高速
        /// </summary>
        public int Speed {
            get { return int.Parse((string)RawData.api_soku); }
        }

        /// <summary>
        /// 射程
        /// </summary>
        public int Range {
            //get {
            //    if (RawData.api_leng()) {
            //        return (string)RawData.api_leng;
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null)
            //            return p.Range;
            //        else
            //            return 0;
            //    }
            //}
            get { try { return RawData.api_leng != null ? int.Parse((string)RawData.api_leng) : 0; } catch (Exception) { return 0; } }
        }
        #endregion


        /// <summary>
        /// 装備スロットの数
        /// </summary>
        public int SlotSize {
            get { return int.Parse((string)RawData.api_slot_num); }
        }

        /// <summary>
        /// 各スロットの航空機搭載数
        /// </summary>
        public ReadOnlyCollection<int> Aircraft {
            //get {
            //    if (RawData.api_maxeq()) {
            //        return Array.AsReadOnly((int[])RawData.api_maxeq);
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null && p.Aircraft != null)
            //            return Array.AsReadOnly(p.Aircraft);
            //        else
            //            return Array.AsReadOnly(new[] { 0, 0, 0, 0, 0 });
            //    }
            //}
            get {
                try {
                    if (RawData.api_maxeq != null)
                        return new ReadOnlyCollection<int>(new[] {
                            int.Parse((string)RawData.api_maxeq[0]),
                            int.Parse((string)RawData.api_maxeq[1]),
                            int.Parse((string)RawData.api_maxeq[2]),
                            int.Parse((string)RawData.api_maxeq[3]),
                            int.Parse((string)RawData.api_maxeq[4])
                        });
                    else
                        return new ReadOnlyCollection<int>(new[] { 0, 0, 0, 0, 0 });
                } catch (Exception) {
                    return new ReadOnlyCollection<int>(new[] { 0, 0, 0, 0, 0 });
                }
            }
        }

        /// <summary>
        /// 搭載
        /// </summary>
        public int AircraftTotal {
            get { return Aircraft.Sum(a => Math.Max(a, 0)); }
        }


        /// <summary>
        /// 初期装備のID
        /// </summary>
        //public ReadOnlyCollection<int> DefaultSlot {
        //    get {
        //        var p = GetParameterElement();
        //        if (p != null && p.DefaultSlot != null)
        //            return Array.AsReadOnly<int>(p.DefaultSlot);
        //        else
        //            return null;
        //    }
        //}


        /// <summary>
        /// 建造時間(分)
        /// </summary>
        public int BuildingTime {
            //get { return !RawData.api_buildtime() ? 0 : (string)RawData.api_buildtime; }
            get { try { return RawData.api_buildtime != null ? int.Parse((string)RawData.api_buildtime) : 0; } catch (Exception) { return 0; } }
        }


        /// <summary>
        /// 解体資材 // to - do
        /// </summary>
        public ReadOnlyCollection<int> Material {
            //get { return Array.AsReadOnly<int>(!RawData.api_broken() ? new[] { 0, 0, 0, 0 } : (int[])RawData.api_broken); }
            get { try { return new ReadOnlyCollection<int>((int[])RawData.api_broken); } catch (Exception) { return new ReadOnlyCollection<int>(new[] { 0, 0, 0, 0 }); } }
        }

        /// <summary>
        /// 近代化改修の素材にしたとき上昇するパラメータの量 // to - do
        /// </summary>
        public ReadOnlyCollection<int> PowerUp {
            //get { return Array.AsReadOnly<int>(!RawData.api_powup() ? new[] { 0, 0, 0, 0 } : (int[])RawData.api_powup); }
            get { try { return new ReadOnlyCollection<int>((int[])RawData.api_powup); } catch (Exception) { return new ReadOnlyCollection<int>(new[] { 0, 0, 0, 0 }); } }
        }

        /// <summary>
        /// レアリティ
        /// </summary>
        public int Rarity {
            //get { return !RawData.api_backs() ? 0 : (string)RawData.api_backs; }
            get { try { return int.Parse((string)RawData.api_backs); } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// ドロップ/ログイン時のメッセージ
        /// </summary>
        public string MessageGet {
            //get {
            //    if (RawData.api_getmes()) {
            //        return ((string)RawData.api_getmes).Replace("<br>", "\n");
            //    } else {
            //        var p = GetParameterElement();
            //        if (p != null && p.MessageGet != null)
            //            return p.MessageGet.Replace("<br>", "\n");
            //        else
            //            return "";
            //    }
            //}
            get { try { return RawData.api_getmes != null ? ((string)RawData.api_getmes).Replace("<br>", "\n") : ""; } catch (Exception) { return ""; } }
        }

        /// <summary>
        /// 艦船名鑑でのメッセージ
        /// </summary>
        //public string MessageAlbum {
        //    get {
        //        var p = GetParameterElement();
        //        if (p != null && p.MessageAlbum != null)
        //            return p.MessageAlbum.Replace("<br>", "\n");
        //        else
        //            return "";
        //    }
        //}


        /// <summary>
        /// 搭載燃料
        /// </summary>
        public int Fuel {
            //get { return !RawData.api_fuel_max() ? 0 : (string)RawData.api_fuel_max; }
            get { try { return int.Parse((string)RawData.api_fuel_max); } catch (Exception) { return 0; } }
        }

        /// <summary>
        /// 搭載弾薬
        /// </summary>
        public int Ammo {
            //get { return !RawData.api_bull_max() ? 0 : (string)RawData.api_bull_max; }
            get { try { return int.Parse((string)RawData.api_bull_max); } catch (Exception) { return 0; } }
        }


        /// <summary>
        /// ボイス再生フラグ
        /// </summary>
        public int VoiceFlag {
            //get { return !RawData.api_voicef() ? 0 : (string)RawData.api_voicef; }
            get { try { return int.Parse((string)RawData.api_voicef); } catch (Exception) { return 0; } }
        }


        /// <summary>
        /// リソースのファイル/フォルダ名
        /// </summary>
        public string ResourceName { get; internal set; }

        /// <summary>
        /// 画像リソースのバージョン
        /// </summary>
        public string ResourceGraphicVersion { get; internal set; }

        /// <summary>
        /// ボイスリソースのバージョン
        /// </summary>
        public string ResourceVoiceVersion { get; internal set; }

        /// <summary>
        /// 母港ボイスリソースのバージョン
        /// </summary>
        public string ResourcePortVoiceVersion { get; internal set; }



        //以下、自作計算プロパティ群

        /// <summary>
        /// ケッコンカッコカリ後のHP
        /// </summary>
        public int HPMaxMarried {
            get {
                int incr;
                if (HPMin < 30) incr = 4;
                else if (HPMin < 40) incr = 5;
                else if (HPMin < 50) incr = 6;
                else if (HPMin < 70) incr = 7;
                else if (HPMin < 90) incr = 8;
                else incr = 9;

                return Math.Min(HPMin + incr, HPMax);
            }
        }

        /// <summary>
        /// 深海棲艦かどうか
        /// ShipID >= 825 is limited illusitration
        /// </summary>
        public bool IsAbyssalShip {
            get { return 500 < ShipID && ShipID < 825; }
        }

        /// <summary>
        /// 深海棲艦のクラス
        /// 0=その他, 1=通常, 2=elite, 3=flagship, 4=改flagship|後期型, 5=後期型elite, 6=後期型flagship
        /// </summary>
        public int AbyssalShipClass {
            get {
                if (!IsAbyssalShip)
                    return 0;

                else if (Name.Contains("後期型")) {
                    if (NameReading == "flagship")
                        return 6;
                    else if (NameReading == "elite")
                        return 5;
                    else
                        return 4;

                } else if (Name.Contains("改") && NameReading == "flagship")
                    return 4;
                else if (NameReading == "flagship")
                    return 3;
                else if (NameReading == "elite")
                    return 2;
                else if (NameReading == "" ||
                          NameReading == "-")
                    return 1;
                else
                    return 0;
            }
        }

        /// <summary>
        /// クラスも含めた艦名
        /// </summary>
        public string NameWithClass {
            get {
                if (!IsAbyssalShip || NameReading == "" || NameReading == "-")
                    return Name;
                else
                    return string.Format("{0} {1}", Name, NameReading);
            }
        }

        /// <summary>
        /// 陸上基地かどうか
        /// </summary>
        public bool IsLandBase {
            get {
                return Speed == 0;
            }
        }


        /// <summary>
        /// 図鑑に載っているか
        /// </summary>
        public bool IsListedInAlbum {
            get { return 0 < AlbumNo && AlbumNo <= 350; }
        }


        /// <summary>
        /// 艦種名
        /// </summary>
        public string ShipTypeName {
            get { return KCDatabase.Instance.ShipTypes[ShipType].Name; }
        }


        /// <summary>
        /// 自身のパラメータレコードを取得します。
        /// </summary>
        /// <returns></returns>
        //private ShipParameterRecord.ShipParameterElement GetParameterElement() {
        //    //return RecordManager.Instance.ShipParameter[ShipID];
        //    return null; // disable record loading
        //}

        public ShipDataMaster() {
            RemodelBeforeShipID = 0;
        }

        public int ID {
            get { return ShipID; }
        }

        public override string ToString() {
            return string.Format("[{0}] {1}", ShipID, NameWithClass);
        }

    }
}
