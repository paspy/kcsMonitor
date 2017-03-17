package dto
{
   import common.util.Util;
   
   public class MissionDTO
   {
       
      
      public const STATE_NOT_MISSION:int = 0;
      
      public const STATE_ACCOMPLISHED_MISSION:int = 1;
      
      public const STATE_MISSION_COMPLETE:int = 2;
      
      public const STATE_MISSION_CANCELED:int = 3;
      
      private var _o:Object;
      
      public function MissionDTO(param1:Object)
      {
         super();
         _o = param1;
      }
      
      public function get state() : int
      {
         return _getMisstionData()[0];
      }
      
      public function get missionID() : int
      {
         return _getMisstionData()[1];
      }
      
      public function get completeTime() : Number
      {
         return _getMisstionData()[2];
      }
      
      public function get deckID() : int
      {
         return Util.getInt(_o,"api_id",-1);
      }
      
      public function get deckName() : String
      {
         return Util.getString(_o,"api_name","");
      }
      
      public function isNoMission() : Boolean
      {
         return state == 0;
      }
      
      public function isComplete() : Boolean
      {
         return state == 2;
      }
      
      public function getDeckShipsID() : Array
      {
         return Util.getArray(_o,"api_ship",[0,0,0,0]).concat();
      }
      
      public function update(param1:Array) : void
      {
         _o["api_mission"] = param1;
      }
      
      public function updateCompleteTime(param1:int) : void
      {
         _o["api_mission"][0] = 3;
         _o["api_mission"][2] = param1;
      }
      
      private function _getMisstionData() : Array
      {
         return Util.getArray(_o,"api_mission",[0,0,0,0]);
      }
   }
}
