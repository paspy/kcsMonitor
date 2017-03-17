package common.models
{
   import common.util.Util;
   import flash.utils.Dictionary;
   
   public class PayItemData
   {
       
      
      private var _masterArr:Array;
      
      private var _masterDic:Dictionary = null;
      
      private var _dic:Dictionary = null;
      
      private var _shopIndexes:Array;
      
      private var _specialPrizeIndexes:Array;
      
      public function PayItemData()
      {
         super();
      }
      
      public function get shopIndexes() : Array
      {
         return _shopIndexes;
      }
      
      public function get specialPrizeIndexes() : Array
      {
         return _specialPrizeIndexes;
      }
      
      public function hasMasterData() : Boolean
      {
         return _masterDic != null;
      }
      
      public function hasData() : Boolean
      {
         return _dic != null;
      }
      
      public function setMasterData(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _masterArr = param1;
         _masterDic = new Dictionary();
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
         _getItemDataFromMaster(1)["list_index"] = 1;
         _getItemDataFromMaster(2)["list_index"] = 2;
         _getItemDataFromMaster(3)["list_index"] = 3;
         _getItemDataFromMaster(4)["list_index"] = 4;
         _getItemDataFromMaster(11)["list_index"] = 5;
         _getItemDataFromMaster(14)["list_index"] = 6;
         _getItemDataFromMaster(24)["list_index"] = 7;
         _getItemDataFromMaster(5)["list_index"] = 8;
         _getItemDataFromMaster(6)["list_index"] = 9;
         _getItemDataFromMaster(7)["list_index"] = 10;
         _getItemDataFromMaster(8)["list_index"] = 11;
         _getItemDataFromMaster(9)["list_index"] = 12;
         _getItemDataFromMaster(10)["list_index"] = 13;
         _getItemDataFromMaster(25)["list_index"] = 14;
         _getItemDataFromMaster(13)["list_index"] = 15;
         _getItemDataFromMaster(15)["list_index"] = 16;
         _getItemDataFromMaster(17)["list_index"] = 17;
         _getItemDataFromMaster(16)["list_index"] = 18;
         _getItemDataFromMaster(18)["list_index"] = 19;
         _getItemDataFromMaster(19)["list_index"] = 20;
         _getItemDataFromMaster(26)["list_index"] = 21;
         _getItemDataFromMaster(20)["list_index"] = 22;
         _getItemDataFromMaster(21)["list_index"] = 23;
         _getItemDataFromMaster(23)["list_index"] = 24;
         _getItemDataFromMaster(22)["list_index"] = 25;
         _getItemDataFromMaster(27)["list_index"] = 26;
         _getItemDataFromMaster(16)["relate_userdata"] = 1;
         _getItemDataFromMaster(11)["relate_slotitem"] = 1;
         _getItemDataFromMaster(14)["relate_slotitem"] = 1;
         _getItemDataFromMaster(21)["relate_slotitem"] = 1;
         _getItemDataFromMaster(24)["relate_slotitem"] = 1;
         _getItemDataFromMaster(25)["relate_slotitem"] = 1;
         _shopIndexes = [];
         _specialPrizeIndexes = [];
      }
      
      public function setShopListData(param1:Object) : void
      {
         if(param1.hasOwnProperty("api_cabinet_1") && param1["api_cabinet_1"] is Array)
         {
            _shopIndexes = param1["api_cabinet_1"];
         }
         if(param1.hasOwnProperty("api_cabinet_2") && param1["api_cabinet_2"] is Array)
         {
            _specialPrizeIndexes = param1["api_cabinet_2"];
         }
      }
      
      public function setData(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _dic = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_];
            _loc2_ = Util.getInt(_loc3_,"api_payitem_id",-1);
            if(_loc2_ != -1)
            {
               _dic[_loc2_] = _loc3_;
            }
            _loc4_++;
         }
      }
      
      public function getName(param1:int) : String
      {
         var _loc2_:Object = _getItemDataFromMaster(param1);
         return Util.getString(_loc2_,"api_name","");
      }
      
      public function getDescription(param1:int) : String
      {
         var _loc3_:Object = _getItemDataFromMaster(param1);
         var _loc2_:String = Util.getString(_loc3_,"api_description","");
         return Util.formatNewLine(_loc2_);
      }
      
      public function getEffects(param1:int) : Object
      {
         var _loc4_:Object = _getItemDataFromMaster(param1);
         var _loc3_:Array = Util.getArray(_loc4_,"api_item",[0,0,0,0,0,0,0,0]);
         var _loc2_:Object = {};
         _loc2_[31] = _loc3_[0];
         _loc2_[32] = _loc3_[1];
         _loc2_[33] = _loc3_[2];
         _loc2_[34] = _loc3_[3];
         _loc2_[2] = _loc3_[4];
         _loc2_[1] = _loc3_[5];
         _loc2_[3] = _loc3_[6];
         _loc2_[4] = _loc3_[7];
         switch(int(param1) - 10)
         {
            case 0:
               _loc2_[49] = 1;
               break;
            case 1:
               _loc2_[50] = 1;
               break;
            default:
               _loc2_[50] = 1;
               break;
            default:
               _loc2_[50] = 1;
               break;
            case 4:
               _loc2_[51] = 1;
               break;
            case 5:
               _loc2_[52] = 1;
               break;
            default:
               _loc2_[52] = 1;
               break;
            default:
               _loc2_[52] = 1;
               break;
            case 8:
               _loc2_[54] = 1;
         }
         return _loc2_;
      }
      
      public function getPrice(param1:int) : int
      {
         var _loc2_:Object = _getItemDataFromMaster(param1);
         return Util.getInt(_loc2_,"api_price",0);
      }
      
      public function getCount(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_count",0);
      }
      
      public function getListIndex(param1:int) : Array
      {
         itemMax = param1;
         var indexes:Array = _masterArr.sortOn("list_index",8 | 16);
         var itemIDs:Array = new Array(itemMax);
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
            if(itemID > 0 && listIndex > 0 && listIndex <= itemMax)
            {
               itemIDs[listIndex - 1] = itemID;
            }
            i = Number(i) + 1;
         }
         return itemIDs;
      }
      
      public function isRelateMaterialData(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:Object = _getItemDataFromMaster(param1);
         var _loc2_:Array = Util.getArray(_loc3_,"api_item",[0,0,0,0,0,0,0,0]);
         _loc4_ = 0;
         while(_loc4_ < Math.min(_loc2_.length,8))
         {
            if(_loc2_[_loc4_] > 0)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function isRelateUserData(param1:int) : Boolean
      {
         var _loc2_:Object = _getItemDataFromMaster(param1);
         return Util.getInt(_loc2_,"relate_userdata",0) == 1;
      }
      
      public function isRelateSlotitem(param1:int) : Boolean
      {
         var _loc2_:Object = _getItemDataFromMaster(param1);
         return Util.getInt(_loc2_,"relate_slotitem",0) == 1;
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
         if(_dic.hasOwnProperty(param1))
         {
            return _dic[param1];
         }
         return {};
      }
      
      function __setCount(param1:int, param2:int) : void
      {
         var _loc3_:Object = _getItemData(param1);
         _loc3_["api_count"] = param2;
      }
      
      public function __useItem(param1:int) : void
      {
         var _loc2_:int = getCount(param1);
         if(_loc2_ > 0)
         {
            __setCount(param1,_loc2_ - 1);
         }
      }
   }
}
