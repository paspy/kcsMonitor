package
{
   import common.models.MissionData;
   import common.models.PayItemData;
   import common.models.ServerConstData;
   import common.models.map.MapData;
   import flash.utils.Dictionary;
   import vo.IncentiveData;
   import vo.MasterBGMData;
   import vo.MasterFurnitureData;
   import vo.MasterShipData;
   import vo.MasterShipTypeData;
   import vo.MasterShipUpgradeData;
   import vo.MasterSlotItemData;
   import vo.StartData;
   import vo.UseItemData;
   import vo.UserAirUnitData;
   import vo.UserBuildDockData;
   import vo.UserData;
   import vo.UserDeckData;
   import vo.UserFurnitureData;
   import vo.UserRecordData;
   import vo.UserRepairDockData;
   import vo.UserSlotItemData;
   
   public class DataFacade
   {
      
      private static var _dataDictionary:Dictionary = new Dictionary();
      
      private static var _am:String = "";
       
      
      public function DataFacade()
      {
         super();
         _dataDictionary["server_const"] = new ServerConstData();
         _dataDictionary["incentive"] = new IncentiveData();
         _dataDictionary["start"] = new StartData();
         _dataDictionary["masterPortBGM"] = new MasterBGMData();
         _dataDictionary["masterShip"] = new MasterShipData();
         _dataDictionary["masterFurniture"] = new MasterFurnitureData();
         _dataDictionary["masterSlotItem"] = new MasterSlotItemData();
         _dataDictionary["masterShipType"] = new MasterShipTypeData();
         _dataDictionary["masterShipUpgrade"] = new MasterShipUpgradeData();
         _dataDictionary["map"] = new MapData();
         _dataDictionary["useItem"] = new UseItemData();
         _dataDictionary["payItem"] = new PayItemData();
         _dataDictionary["mission"] = new MissionData();
         _dataDictionary["userData"] = new UserData();
         _dataDictionary["userDeck"] = new UserDeckData();
         _dataDictionary["userFurniture"] = new UserFurnitureData();
         _dataDictionary["userSlotItem"] = new UserSlotItemData();
         _dataDictionary["userRecord"] = new UserRecordData();
         _dataDictionary["buildDock"] = new UserBuildDockData();
         _dataDictionary["repairDock"] = new UserRepairDockData();
         _dataDictionary["userAirUnit"] = new UserAirUnitData();
      }
      
      public static function get am() : String
      {
         var _loc1_:String = _am;
         _am = "";
         return _loc1_;
      }
      
      public static function set am(param1:String) : void
      {
         _am = param1;
      }
      
      public static function getServerConstData() : ServerConstData
      {
         return _dataDictionary["server_const"];
      }
      
      public static function getIncentiveData() : IncentiveData
      {
         return _dataDictionary["incentive"];
      }
      
      public static function getStartData() : StartData
      {
         return _dataDictionary["start"];
      }
      
      public static function getMasterBGMData() : MasterBGMData
      {
         return _dataDictionary["masterPortBGM"];
      }
      
      public static function getMasterShipData() : MasterShipData
      {
         return _dataDictionary["masterShip"];
      }
      
      public static function getMasterFurnitureData() : MasterFurnitureData
      {
         return _dataDictionary["masterFurniture"];
      }
      
      public static function getMasterSlotItemData() : MasterSlotItemData
      {
         return _dataDictionary["masterSlotItem"];
      }
      
      public static function getMasterShipTypeData() : MasterShipTypeData
      {
         return _dataDictionary["masterShipType"];
      }
      
      public static function getMasterShipUpgradeData() : MasterShipUpgradeData
      {
         return _dataDictionary["masterShipUpgrade"];
      }
      
      public static function getMapData() : MapData
      {
         return _dataDictionary["map"];
      }
      
      public static function getUseItemData() : UseItemData
      {
         return _dataDictionary["useItem"];
      }
      
      public static function getPayItemData() : PayItemData
      {
         return _dataDictionary["payItem"];
      }
      
      public static function getMissionData() : MissionData
      {
         return _dataDictionary["mission"];
      }
      
      public static function getUserData() : UserData
      {
         return _dataDictionary["userData"];
      }
      
      public static function getUserDeckData() : UserDeckData
      {
         return _dataDictionary["userDeck"];
      }
      
      public static function getUserFurnitureData() : UserFurnitureData
      {
         return _dataDictionary["userFurniture"];
      }
      
      public static function getUserSlotItemData() : UserSlotItemData
      {
         return _dataDictionary["userSlotItem"];
      }
      
      public static function getUserRecordData() : UserRecordData
      {
         return _dataDictionary["userRecord"];
      }
      
      public static function getBuildDockData() : UserBuildDockData
      {
         return _dataDictionary["buildDock"];
      }
      
      public static function getRepairDockData() : UserRepairDockData
      {
         return _dataDictionary["repairDock"];
      }
      
      public static function getUserAirUnitData() : UserAirUnitData
      {
         return _dataDictionary["userAirUnit"];
      }
   }
}
