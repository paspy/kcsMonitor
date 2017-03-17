package manager
{
   import flash.utils.ByteArray;
   
   public class DebugManager
   {
       
      
      public var isEmulate:Boolean = false;
      
      private var _data:Object;
      
      public function DebugManager()
      {
         super();
         _createData();
      }
      
      public function setStartAPI(param1:Object) : void
      {
         _data["start"] = _cloneObject(param1);
      }
      
      public function setMapInfoAPI(param1:Object) : void
      {
         _createData();
         _data["mapinfo"] = _cloneObject(param1);
      }
      
      public function setMapCellAPI(param1:Object) : void
      {
         _createData();
         _data["mapcell"] = _cloneObject(param1);
      }
      
      public function setDeckData(param1:Object) : void
      {
         _data["deck"] = _cloneObject(param1);
      }
      
      public function setNextAPI(param1:Object) : void
      {
         _data["next"].push(_cloneObject(param1));
      }
      
      public function setBattleEmulateData(param1:Object) : void
      {
         _data["battle"].push(_cloneObject(param1));
      }
      
      public function addBattleEmulateData(param1:String, param2:Object) : void
      {
         var _loc3_:Object = _getLastBattleData();
         if(_loc3_.hasOwnProperty("emulate_data") == false)
         {
            _loc3_["emulate_data"] = {};
         }
         _loc3_["emulate_data"][param1] = _cloneObject(param2);
      }
      
      public function getData() : Object
      {
         return _data;
      }
      
      private function _createData() : void
      {
         var _loc1_:Object = _data && _data.hasOwnProperty("mapinfo")?_data["mapinfo"]:{};
         _data = {
            "start":{},
            "deck":{},
            "next":[],
            "battle":[]
         };
         _data["format_version"] = 4;
         _data["emulate_start_time"] = new Date().getTime();
         _data["emulate_start_time_string"] = new Date().toLocaleString();
         _data["mapinfo"] = _loc1_;
      }
      
      private function _getLastBattleData() : Object
      {
         var _loc1_:Array = _data["battle"];
         if(_loc1_.length == 0 || _loc1_[_loc1_.length - 1].hasOwnProperty("result"))
         {
            _loc1_.push({});
         }
         return _loc1_[_loc1_.length - 1];
      }
      
      private function _cloneObject(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
   }
}
