package vo
{
   import common.Consts;
   import common.util.Util;
   
   public class UserData
   {
       
      
      private var _obj:Object;
      
      private var _port_bgm_id:String = "101";
      
      private var _duty_executable_count:int = 5;
      
      private var _planeInfo:Object;
      
      private var _eventObj:Object;
      
      public function UserData()
      {
         _obj = {};
         _planeInfo = {};
         _eventObj = {};
         super();
      }
      
      public function setInitData(param1:String, param2:Boolean) : void
      {
         _obj = {
            "api_member_id":param1,
            "api_firstflag":param2
         };
      }
      
      public function setData(param1:Object) : void
      {
         _obj = param1;
         DataFacade.getUseItemData().setKaguCoin(Util.getInt(_obj,"api_fcoin",0));
      }
      
      public function getMemberID() : String
      {
         return Util.getString(_obj,"api_member_id");
      }
      
      public function getNickName() : String
      {
         return Util.getString(_obj,"api_nickname");
      }
      
      public function getComment() : String
      {
         return Util.getString(_obj,"api_comment");
      }
      
      public function getLevel() : int
      {
         return Util.getInt(_obj,"api_level");
      }
      
      public function getExperience() : int
      {
         return Util.getInt(_obj,"api_experience");
      }
      
      public function getRank() : int
      {
         return Util.getInt(_obj,"api_rank");
      }
      
      public function getRankName() : String
      {
         return Consts.RANK_NAME[getRank()];
      }
      
      public function getFirstFlg() : Boolean
      {
         return !Util.getBooleanFromInt(_obj,"api_firstflag");
      }
      
      public function getTutorialProgress() : int
      {
         return Util.getInt(_obj,"api_tutorial_progress");
      }
      
      public function getStWin() : int
      {
         return Util.getInt(_obj,"api_st_win");
      }
      
      public function getStLose() : int
      {
         return Util.getInt(_obj,"api_st_lose");
      }
      
      public function getPtWin() : int
      {
         return Util.getInt(_obj,"api_pt_win");
      }
      
      public function getPtLose() : int
      {
         return Util.getInt(_obj,"api_pt_lose");
      }
      
      public function getMsCount() : int
      {
         return Util.getInt(_obj,"api_ms_count");
      }
      
      public function getMsSuccess() : int
      {
         return Util.getInt(_obj,"api_ms_success");
      }
      
      public function getBuildDockCount() : int
      {
         return Util.getInt(_obj,"api_count_kdock");
      }
      
      public function getRepairDockCount() : int
      {
         return Util.getInt(_obj,"api_count_ndock");
      }
      
      public function getMaxShipCount() : int
      {
         return Util.getInt(_obj,"api_max_chara");
      }
      
      public function getMaxSlotItemCount() : int
      {
         return Util.getInt(_obj,"api_max_slotitem") + 3;
      }
      
      public function getUsingFurniture() : Array
      {
         return Util.getArray(_obj,"api_furniture");
      }
      
      private function _getFurnitureIDs() : Array
      {
         return _obj.api_furniture;
      }
      
      public function getFurnitureFloorID() : int
      {
         return _getFurnitureIDs()[0];
      }
      
      public function getFurnitureWallID() : int
      {
         return _getFurnitureIDs()[1];
      }
      
      public function getFurnitureWindowID() : int
      {
         return _getFurnitureIDs()[2];
      }
      
      public function getFurnitureObjectID() : int
      {
         return _getFurnitureIDs()[3];
      }
      
      public function getFurnitureChestID() : int
      {
         return _getFurnitureIDs()[4];
      }
      
      public function getFurnitureDeskID() : int
      {
         return _getFurnitureIDs()[5];
      }
      
      public function isLargeBuild() : Boolean
      {
         return Util.getInt(_obj,"api_large_dock") == 1;
      }
      
      public function getMedalNum() : int
      {
         return Util.getInt(_obj,"api_medals");
      }
      
      public function getPortMainBGMID() : String
      {
         return _port_bgm_id;
      }
      
      public function setPortMainBGMID(param1:String) : void
      {
         _port_bgm_id = param1;
      }
      
      public function getDutyExecutableCount() : int
      {
         return _duty_executable_count;
      }
      
      public function setDutyExecutableCount(param1:int) : void
      {
         _duty_executable_count = param1;
      }
      
      public function getString() : String
      {
         return JSON.stringify(_obj);
      }
      
      function __setTutorialProgress(param1:int) : void
      {
         _obj["api_tutorial_progress"] = param1;
      }
      
      public function setPlaneInfo(param1:Object) : void
      {
         _planeInfo = param1;
      }
      
      public function get planeInfo() : Object
      {
         return _planeInfo;
      }
      
      public function setEventObj(param1:Object) : void
      {
         _eventObj = param1;
      }
      
      public function get eventObj() : Object
      {
         return _eventObj;
      }
   }
}
