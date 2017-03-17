package dto
{
   import common.util.Util;
   import vo.BaseData;
   import vo.MasterShipData;
   
   public class BuildDockDTO extends BaseData
   {
      
      public static const STATE_CLOSE:int = -1;
      
      public static const STATE_NONE:int = 0;
      
      public static const STATE_BUILD:int = 2;
      
      public static const STATE_COMPLETE:int = 3;
       
      
      private var _o:Object;
      
      public function BuildDockDTO(param1:Object)
      {
         super();
         _o = param1;
      }
      
      public function set highSpeedFlg(param1:Boolean) : void
      {
         if(DataFacade.getBuildDockData().getDataFromID(dockID) != this)
         {
            _o = DataFacade.getBuildDockData().getDataFromID(dockID).getObject();
         }
         _o["highSpeedFlg"] = !!param1?1:0;
      }
      
      public function get highSpeedFlg() : Boolean
      {
         return Util.getInt(_o,"highSpeedFlg",0) == 1;
      }
      
      public function get dockID() : int
      {
         return _getInt(_o,"api_id",0);
      }
      
      public function get state() : int
      {
         return Util.getInt(_o,"api_state",-1);
      }
      
      public function get charaID() : int
      {
         return Util.getInt(_o,"api_created_ship_id",0);
      }
      
      public function get completeTime() : Number
      {
         return Util.getNumber(_o,"api_complete_time",0);
      }
      
      public function isOpened() : Boolean
      {
         return state > -1;
      }
      
      public function isLargeBuild() : Boolean
      {
         return Util.getInt(_o,"api_item1",0) >= 1000;
      }
      
      public function getRemainTime() : Number
      {
         var _loc1_:Number = new Date().getTime();
         return Math.max(0,completeTime - _loc1_);
      }
      
      public function getBuildTime() : Number
      {
         var _loc1_:MasterShipData = DataFacade.getMasterShipData();
         return _loc1_.getBuildTime_msec(charaID);
      }
      
      public function getbuildPhaseCount() : int
      {
         var _loc1_:int = DataFacade.getMasterShipData().getShipType(charaID);
         return DataFacade.getMasterShipTypeData().getShipTypeData(_loc1_).buildPhaseCount;
      }
      
      public function openDock(param1:Boolean = false) : void
      {
         var _loc2_:Boolean = param1 || state == -1;
         if(_loc2_)
         {
            _o["api_state"] = 0;
         }
      }
      
      public function buildComplete(param1:Boolean = false) : void
      {
         var _loc3_:Number = new Date().getTime();
         var _loc2_:Boolean = param1 || state == 2 && completeTime < _loc3_;
         if(_loc2_)
         {
            highSpeedFlg = false;
            _o["api_state"] = 3;
            _o["api_complete_time"] = 0;
            _o["api_complete_time_str"] = "";
         }
      }
      
      function getObject() : Object
      {
         return _o;
      }
   }
}
