package manager
{
   import dto.MissionDTO;
   
   public class MissionManager
   {
       
      
      private var _missions:Vector.<MissionDTO>;
      
      public function MissionManager()
      {
         super();
      }
      
      public function isMissionComplete() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _missions.length)
         {
            if(_missions[_loc1_].isComplete())
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function update(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _missions = new Vector.<MissionDTO>();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new MissionDTO(param1[_loc3_]);
            if(!_loc2_.isNoMission())
            {
               _missions.push(_loc2_);
            }
            _loc3_++;
         }
      }
      
      public function updateMissionState(param1:int, param2:Array) : void
      {
         var _loc3_:MissionDTO = _getMissionDTO_Deck(param1);
         if(_loc3_)
         {
            _loc3_.update(param2);
         }
      }
      
      public function updateMissionCompleteTimeState(param1:int, param2:int) : void
      {
         var _loc3_:MissionDTO = _getMissionDTO_Deck(param1);
         if(_loc3_)
         {
            _loc3_.updateCompleteTime(param2);
         }
      }
      
      public function shiftData() : MissionDTO
      {
         if(_missions.length)
         {
            return _missions.shift();
         }
         return null;
      }
      
      public function shiftCompleteData() : MissionDTO
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _missions.length)
         {
            if(_missions[_loc2_].isComplete())
            {
               _loc1_ = _missions[_loc2_];
               _missions.splice(_loc2_,1);
               return _loc1_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getMissionID(param1:int) : int
      {
         var _loc2_:MissionDTO = _getMissionDTO_Deck(param1);
         if(_loc2_)
         {
            return _loc2_.missionID;
         }
         return 0;
      }
      
      public function getState(param1:int) : Number
      {
         var _loc2_:MissionDTO = _getMissionDTO_Deck(param1);
         if(_loc2_)
         {
            return _loc2_.state;
         }
         return 0;
      }
      
      public function getCompleteTime(param1:int) : Number
      {
         var _loc2_:MissionDTO = _getMissionDTO_Deck(param1);
         if(_loc2_)
         {
            return _loc2_.completeTime;
         }
         return -1;
      }
      
      private function _getMissionDTO_Deck(param1:int) : MissionDTO
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _missions.length)
         {
            if(_missions[_loc2_].deckID == param1)
            {
               return _missions[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}
