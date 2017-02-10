////////////////////////////////////////////////////////
// Original author: Andante
// https://twitter.com/andanteyk
// https://github.com/andanteyk/ElectronicObserver
////////////////////////////////////////////////////////

namespace ElectronicObserver.Data {
    public class MapAreaData : APIWrapper, IIdentifiable {

        /// <summary>
        /// 海域カテゴリID
        /// </summary>
        public int MapAreaID {
            get { return (int)RawData.api_id; }
        }

        /// <summary>
        /// 海域カテゴリ名
        /// </summary>
        public string Name {
            get { return RawData.api_name; }
        }

        /// <summary>
        /// 海域タイプ　0=通常, 1=イベント
        /// </summary>
        public int MapType {
            get { return (int)RawData.api_type; }
        }



        public int ID {
            get { return MapAreaID; }
        }
    }
}
