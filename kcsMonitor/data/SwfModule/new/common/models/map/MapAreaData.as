package common.models.map
{
   import common.util.Util;
   import flash.utils.Dictionary;
   
   public class MapAreaData
   {
       
      
      private var _o:Object;
      
      private var _infoDic:Dictionary;
      
      public function MapAreaData(param1:Object)
      {
         super();
         _o = param1;
      }
      
      public function get areaID() : int
      {
         return Util.getInt(_o,"api_id",-1);
      }
      
      public function get areaName() : String
      {
         return Util.getString(_o,"api_name");
      }
      
      public function setMasterData(param1:Vector.<MapInfoData>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _infoDic = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1[_loc3_];
            if(areaID == _loc2_.areaID)
            {
               _infoDic[_loc2_.infoNo] = _loc2_;
            }
            _loc3_++;
         }
      }
      
      public function getInfoData(param1:int) : MapInfoData
      {
         if(hasInfoData(param1))
         {
            return _infoDic[param1];
         }
         return null;
      }
      
      public function hasInfoData(param1:int) : Boolean
      {
         return _infoDic.hasOwnProperty(param1);
      }
      
      public function isActiveAirUnit() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _infoDic;
         for each(var _loc1_ in _infoDic)
         {
            if(_loc1_.availableAirUnitCount() > 0 && _loc1_.isActive() == true)
            {
               return true;
            }
         }
         return false;
      }
   }
}
