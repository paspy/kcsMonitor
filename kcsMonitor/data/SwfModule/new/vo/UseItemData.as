package vo
{
   import common.util.Util;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class UseItemData extends EventDispatcher
   {
      
      public static const EVENT_CHANGE_MATERIAL:String = "EVENT_CHANGE";
      
      public static const EVENT_USE_BAUXITE_AT_SUPPLY:String = "EVENT_USE_BAUXITE_AT_SUPPLY";
      
      public static const FUEL_ITEMID:int = 31;
      
      public static const AMMO_ITEMID:int = 32;
      
      public static const STEEL_ITEMID:int = 33;
      
      public static const BAUX_ITEMID:int = 34;
      
      public static const BUILDKIT_ITEMID:int = 2;
      
      public static const REPAIRKIT_ITEMID:int = 1;
      
      public static const DEVKIT_ITEMID:int = 3;
      
      public static const REVKIT_ITEMID:int = 4;
      
      public static const KAGUCOIN_ITEMID:int = 44;
      
      public static const DOCK_KEY_ITEMID:int = 49;
      
      public static const CRAFTSMAN_ITEMID:int = 52;
      
      public static const MAMIYA_ITEMID:int = 54;
      
      public static const IRAKO_ITEMID:int = 59;
      
      public static const MARRIAGE_RING_ITEMID:int = 55;
      
      public static const MEDAL_ITEMID:int = 57;
      
      public static const REMODEL_RECIPE_ITEMID:int = 58;
      
      public static const PRESENTBOX_ITEMID:int = 60;
      
      public static const MEDAL_KOU_ITEMID:int = 61;
      
      public static const RHOMBUS_MOCHI_ITEMID:int = 62;
      
      public static const HEADQUARTERS_ENLARGE_ITEMID:int = 63;
      
      public static const REINFORCEMENT_WORK_ITEMID:int = 64;
      
      public static const EXTRA_CATAPULT_ITEMID:int = 65;
      
      public static const PIKE_ITEMID:int = 68;
      
      public static const TYPE_NE_ENGINE:int = 71;
      
      public static const DECO_MATERIAL_ITEMID:int = 72;
       
      
      private var _masterArr:Array = null;
      
      private var _masterDic:Dictionary = null;
      
      private var _dic:Dictionary = null;
      
      public function UseItemData()
      {
         super();
         _masterDic = new Dictionary();
         _dic = new Dictionary();
      }
      
      public function get fuel() : int
      {
         return getCount(31);
      }
      
      public function get ammo() : int
      {
         return getCount(32);
      }
      
      public function get steel() : int
      {
         return getCount(33);
      }
      
      public function get baux() : int
      {
         return getCount(34);
      }
      
      public function get buildKit() : int
      {
         return getCount(2);
      }
      
      public function get repairKit() : int
      {
         return getCount(1);
      }
      
      public function get devKit() : int
      {
         return getCount(3);
      }
      
      public function get revKit() : int
      {
         return getCount(4);
      }
      
      public function getUseitemIDList() : Array
      {
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _masterDic;
         for(var _loc1_ in _masterDic)
         {
            _loc2_.push(parseInt(_loc1_));
         }
         return _loc2_;
      }
      
      public function setMasterData(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _masterArr = param1;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_];
            _loc2_ = Util.getInt(_loc3_,"api_id",-1);
            if(_loc2_ != -1)
            {
               _masterDic[_loc2_] = _loc3_;
            }
            _loc4_++;
         }
         _getItemDataFromMaster(55)["list_index"] = 1;
         _getItemDataFromMaster(57)["list_index"] = 2;
         _getItemDataFromMaster(4)["list_index"] = 3;
         _getItemDataFromMaster(59)["list_index"] = 4;
         _getItemDataFromMaster(60)["list_index"] = 5;
         _getItemDataFromMaster(56)["list_index"] = 6;
         _getItemDataFromMaster(61)["list_index"] = 7;
         _getItemDataFromMaster(74)["list_index"] = 8;
         _getItemDataFromMaster(10)["list_index"] = 9;
         _getItemDataFromMaster(11)["list_index"] = 10;
         _getItemDataFromMaster(12)["list_index"] = 11;
         _getItemDataFromMaster(54)["list_index"] = 12;
         _getItemDataFromMaster(58)["list_index"] = 13;
         _getItemDataFromMaster(52)["list_index"] = 14;
         _getItemDataFromMaster(63)["list_index"] = 15;
         _getItemDataFromMaster(64)["list_index"] = 16;
         _getItemDataFromMaster(1)["list_index"] = 17;
         _getItemDataFromMaster(2)["list_index"] = 18;
         _getItemDataFromMaster(3)["list_index"] = 19;
         _getItemDataFromMaster(49)["list_index"] = 20;
         _getItemDataFromMaster(50)["list_index"] = 21;
         _getItemDataFromMaster(51)["list_index"] = 22;
         _getItemDataFromMaster(62)["list_index"] = 23;
         _getItemDataFromMaster(68)["list_index"] = 24;
         _getItemDataFromMaster(70)["list_index"] = 25;
         _getItemDataFromMaster(65)["list_index"] = 26;
         _getItemDataFromMaster(71)["list_index"] = 27;
         _getItemDataFromMaster(69)["list_index"] = 28;
         _getItemDataFromMaster(66)["list_index"] = 29;
         _getItemDataFromMaster(67)["list_index"] = 30;
         _getItemDataFromMaster(73)["list_index"] = 31;
      }
      
      public function setData(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _clearItemDic();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_];
            _loc2_ = Util.getInt(_loc3_,"api_id",-1);
            if(_loc2_ != -1)
            {
               _dic[_loc2_] = _loc3_;
            }
            _loc4_++;
         }
      }
      
      public function setMaterial(param1:Array) : void
      {
         if(param1.length >= 4)
         {
            __setCount(31,param1[0]["api_value"]);
            __setCount(32,param1[1]["api_value"]);
            __setCount(33,param1[2]["api_value"]);
            __setCount(34,param1[3]["api_value"]);
         }
         if(param1.length >= 8)
         {
            __setCount(1,param1[5]["api_value"]);
            __setCount(2,param1[4]["api_value"]);
            __setCount(3,param1[6]["api_value"]);
            __setCount(4,param1[7]["api_value"]);
         }
         dispatchEvent(new Event("EVENT_CHANGE"));
      }
      
      public function setMaterial2(param1:Array) : void
      {
         if(param1.length >= 4)
         {
            __setCount(31,param1[0]);
            __setCount(32,param1[1]);
            __setCount(33,param1[2]);
            __setCount(34,param1[3]);
         }
         if(param1.length >= 8)
         {
            __setCount(1,param1[5]);
            __setCount(2,param1[4]);
            __setCount(3,param1[6]);
            __setCount(4,param1[7]);
         }
         dispatchEvent(new Event("EVENT_CHANGE"));
      }
      
      public function setKaguCoin(param1:int) : void
      {
         __setCount(44,param1);
      }
      
      public function getName(param1:int) : String
      {
         var _loc2_:Object = _getItemDataFromMaster(param1);
         return Util.getString(_loc2_,"api_name","");
      }
      
      public function getDescription(param1:int) : String
      {
         var _loc2_:Object = _getItemDataFromMaster(param1);
         return Util.getArray(_loc2_,"api_description",["",""])[0];
      }
      
      public function getOption(param1:int) : String
      {
         var _loc2_:Object = _getItemDataFromMaster(param1);
         return Util.getArray(_loc2_,"api_description",["",""])[1];
      }
      
      public function getCount(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_count",0);
      }
      
      public function useAirUnitExtension() : void
      {
         var _loc1_:Object = _getItemData(73);
         var _loc2_:int = Util.getInt(_loc1_,"api_count",0);
         __setCount(73,_loc2_ - 1);
      }
      
      public function getUseType(param1:int) : int
      {
         var _loc2_:Object = _getItemDataFromMaster(param1);
         return Util.getInt(_loc2_,"api_usetype",0);
      }
      
      public function getListIndex(param1:int) : Array
      {
         max_num = param1;
         var ITEM_MAX:int = max_num;
         var indexes:Array = _masterArr.sortOn("list_index",8 | 16);
         var itemIDs:Array = new Array(ITEM_MAX);
         itemIDs.forEach(function(param1:*, param2:int, param3:Array):void
         {
            param3[param2] = -1;
         });
         var i:int = 0;
         while(i < indexes.length)
         {
            var index:int = indexes[i];
            var itemData:Object = _masterArr[index];
            var itemID:int = Util.getInt(itemData,"api_id");
            var listIndex:int = Util.getInt(itemData,"list_index",0);
            if(itemID > 0 && listIndex > 0 && listIndex <= ITEM_MAX)
            {
               itemIDs[listIndex - 1] = itemID;
            }
            i = Number(i) + 1;
         }
         return itemIDs;
      }
      
      public function isUsableInItemList(param1:int) : Boolean
      {
         return getUseType(param1) == 4;
      }
      
      public function getDockKeyNum() : int
      {
         return getCount(49);
      }
      
      private function _getItemDataFromMaster(param1:int) : Object
      {
         if(_masterDic.hasOwnProperty(param1))
         {
            return _masterDic[param1];
         }
         return {};
      }
      
      private function _getItemData(param1:int) : Object
      {
         if(!_dic.hasOwnProperty(param1))
         {
            _dic[param1] = {};
         }
         return _dic[param1];
      }
      
      private function _isMaterialID(param1:int) : Boolean
      {
         return param1 == 31 || param1 == 32 || param1 == 33 || param1 == 34 || param1 == 2 || param1 == 1 || param1 == 3 || param1 == 4;
      }
      
      private function _clearItemDic() : void
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _dic;
         for(var _loc2_ in _dic)
         {
            _loc1_ = parseInt(_loc2_);
            if(_isMaterialID(_loc1_) == false && _loc1_ != 44)
            {
               delete _dic[_loc1_];
            }
         }
      }
      
      function __useRepairDockKey() : Boolean
      {
         if(getDockKeyNum() > 0)
         {
            _dic[49]["api_count"] = _dic[49]["api_count"] - 1;
            return true;
         }
         return false;
      }
      
      function __setCount(param1:int, param2:int) : void
      {
         var _loc3_:Object = _getItemData(param1);
         _loc3_["api_count"] = param2;
      }
      
      function __useItem(param1:int, param2:int = 1) : Boolean
      {
         var _loc3_:int = getCount(param1);
         if(_loc3_ >= param2)
         {
            __setCount(param1,_loc3_ - param2);
            if(_isMaterialID(param1))
            {
               dispatchEvent(new Event("EVENT_CHANGE"));
            }
            return true;
         }
         return false;
      }
   }
}
