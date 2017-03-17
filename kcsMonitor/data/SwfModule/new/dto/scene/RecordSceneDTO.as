package dto.scene
{
   import scene.ISceneDTO;
   
   public class RecordSceneDTO extends SceneDTO implements ISceneDTO
   {
       
      
      private var _userName:String;
      
      private var _userComment:String;
      
      private var _userLevel:int;
      
      private var _userRankNum:int;
      
      private var _userSallyWinCount:int;
      
      private var _userSallyLoseCount:int;
      
      private var _userSallyRate:Number;
      
      private var _userMissionWinCount:int;
      
      private var _userMissionLoseCount:int;
      
      private var _userMissionRate:Number;
      
      private var _userExerciseWinCount:int;
      
      private var _userExerciseLoseCount:int;
      
      private var _userExerciseRate:Number;
      
      private var _userDeckCount:int;
      
      private var _userBuildDockCount:int;
      
      private var _userRepairDockCount:int;
      
      private var _userShipCount:int;
      
      private var _userEquipCount:int;
      
      private var _userFurnitureCount:int;
      
      private var _userMaxDeckCount:int;
      
      private var _userMaxShipCount:int;
      
      private var _userMaxEquipCount:int;
      
      private var _userMaxMaterialCount:int;
      
      public function RecordSceneDTO(param1:Object = null)
      {
         super(param1);
      }
      
      public function getUserName() : String
      {
         return _userName;
      }
      
      public function setUserName(param1:String) : void
      {
         _userName = param1;
      }
      
      public function getUserComment() : String
      {
         return _userComment;
      }
      
      public function setUserComment(param1:String) : void
      {
         _userComment = param1;
      }
      
      public function getUserLevel() : int
      {
         return _userLevel;
      }
      
      public function setUserLevel(param1:int) : void
      {
         _userLevel = param1;
      }
      
      public function getUserRankNumber() : int
      {
         return _userRankNum;
      }
      
      public function setUserRankNumber(param1:int) : void
      {
         _userRankNum = param1;
      }
      
      public function getUserSallyWinCount() : int
      {
         return _userSallyWinCount;
      }
      
      public function setUserSallyWinCount(param1:int) : void
      {
         _userSallyWinCount = param1;
      }
      
      public function getUserSallyLoseCount() : int
      {
         return _userSallyLoseCount;
      }
      
      public function setUserSallyLoseCount(param1:int) : void
      {
         _userSallyLoseCount = param1;
      }
      
      public function getUserSallyRate() : Number
      {
         return _userSallyRate;
      }
      
      public function setUserSallyRate(param1:Number) : void
      {
         _userSallyRate = param1;
      }
      
      public function getUserMissionWinCount() : int
      {
         return _userMissionWinCount;
      }
      
      public function setUserMissionWinCount(param1:int) : void
      {
         _userMissionWinCount = param1;
      }
      
      public function getUserMissionLoseCount() : int
      {
         return _userMissionLoseCount;
      }
      
      public function setUserMissionLoseCount(param1:int) : void
      {
         _userMissionLoseCount = param1;
      }
      
      public function getUserMissionRate() : Number
      {
         return _userMissionRate;
      }
      
      public function setUserMissionRate(param1:Number) : void
      {
         _userMissionRate = param1;
      }
      
      public function getUserExerciseWinCount() : int
      {
         return _userExerciseWinCount;
      }
      
      public function setUserExerciseWinCount(param1:int) : void
      {
         _userExerciseWinCount = param1;
      }
      
      public function getUserExerciseLoseCount() : int
      {
         return _userExerciseLoseCount;
      }
      
      public function setUserExerciseLoseCount(param1:int) : void
      {
         _userExerciseLoseCount = param1;
      }
      
      public function getUserExerciseRate() : Number
      {
         return _userExerciseRate;
      }
      
      public function setUserExerciseRate(param1:Number) : void
      {
         _userExerciseRate = param1;
      }
      
      public function getUserDeckCount() : int
      {
         return _userDeckCount;
      }
      
      public function setUserDeckCount(param1:int) : void
      {
         _userDeckCount = param1;
      }
      
      public function getUserBuildDockCount() : int
      {
         return _userBuildDockCount;
      }
      
      public function setUserBuildDockCount(param1:int) : void
      {
         _userBuildDockCount = param1;
      }
      
      public function getUserRepairDockCount() : int
      {
         return _userRepairDockCount;
      }
      
      public function setUserRepairDockCount(param1:int) : void
      {
         _userRepairDockCount = param1;
      }
      
      public function getUserShipCount() : int
      {
         return _userShipCount;
      }
      
      public function setUserShipCount(param1:int) : void
      {
         _userShipCount = param1;
      }
      
      public function getUserEquipCount() : int
      {
         return _userEquipCount;
      }
      
      public function setUserEquipCount(param1:int) : void
      {
         _userEquipCount = param1;
      }
      
      public function getUserFurnitureCount() : int
      {
         return _userFurnitureCount;
      }
      
      public function setUserFurnitureCount(param1:int) : void
      {
         _userFurnitureCount = param1;
      }
      
      public function getUserMaxDeckCount() : int
      {
         return _userMaxDeckCount;
      }
      
      public function setUserMaxDeckCount(param1:int) : void
      {
         _userMaxDeckCount = param1;
      }
      
      public function getUserMaxShipCount() : int
      {
         return _userMaxShipCount;
      }
      
      public function setUserMaxShipCount(param1:int) : void
      {
         _userMaxShipCount = param1;
      }
      
      public function getUserMaxEquipCount() : int
      {
         return _userMaxEquipCount;
      }
      
      public function setUserMaxEquipCount(param1:int) : void
      {
         _userMaxEquipCount = param1;
      }
      
      public function getUserMaxMaterialCount() : int
      {
         return _userMaxMaterialCount;
      }
      
      public function setUserMaxMaterialCount(param1:int) : void
      {
         _userMaxMaterialCount = param1;
      }
   }
}
