package vo
{
   import common.models.EquipTypeObject;
   import common.models.MaterialModel;
   import common.util.Util;
   import flash.utils.Dictionary;
   
   public class MasterSlotItemData
   {
       
      
      private var _dic:Dictionary;
      
      private var _equipTypeDic:Dictionary;
      
      private var _equipTypeCount:int = 0;
      
      private var _extraEquipTypes:Array;
      
      public function MasterSlotItemData()
      {
         super();
         _dic = new Dictionary();
         _equipTypeDic = new Dictionary();
      }
      
      public function get equipTypeCount() : int
      {
         return _equipTypeCount;
      }
      
      public function getSlotitemIDList() : Array
      {
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _dic;
         for(var _loc1_ in _dic)
         {
            _loc2_.push(parseInt(_loc1_));
         }
         return _loc2_;
      }
      
      public function setData(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         _dic = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = {};
            _loc2_ = param1[_loc4_];
            _loc3_ = _loc2_["api_id"];
            _dic[_loc3_] = _loc2_;
            _loc4_++;
         }
      }
      
      public function setEquipTypeData(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _equipTypeDic = new Dictionary();
         _equipTypeCount = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new EquipTypeObject(param1[_loc3_]);
            _equipTypeDic[_loc2_.id] = _loc2_;
            _equipTypeCount = Number(_equipTypeCount) + 1;
            _loc3_++;
         }
      }
      
      public function setExtraEquipTypeData(param1:Array) : void
      {
         _extraEquipTypes = param1;
      }
      
      public function getExtraEquipTypes() : Array
      {
         return _extraEquipTypes.concat();
      }
      
      public function getName(param1:int) : String
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getString(_loc2_,"api_name","");
      }
      
      public function getMaterialsFromBroken(param1:int) : MaterialModel
      {
         var _loc2_:MaterialModel = new MaterialModel();
         _loc2_.setFromArray4(Util.getArray(_getItemData(param1),"api_broken",[0,0,0,0]));
         return _loc2_;
      }
      
      public function getRarity(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_rare",0);
      }
      
      public function getSyatei(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_leng",0);
      }
      
      public function getKaryoku(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_houg",0);
      }
      
      public function getRaisou(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_raig",0);
      }
      
      public function getTaikuu(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_tyku",0);
      }
      
      public function getTaisen(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_tais",0);
      }
      
      public function getBakusou(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_baku",0);
      }
      
      public function getMeichu(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_houm",0);
      }
      
      public function getKaihi(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_houk",0);
      }
      
      public function getSakuteki(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_saku",0);
      }
      
      public function getSoukou(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_souk",0);
      }
      
      public function getSlotItemCardType(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getArray(_loc2_,"api_type",[0,0,0,0])[1];
      }
      
      public function getSlotItemEquipType(param1:int) : int
      {
         var _loc3_:Object = _getItemData(param1);
         var _loc2_:Array = Util.getArray(_loc3_,"api_type");
         if(_loc2_ != null && _loc2_.length > 2)
         {
            return _loc2_[2];
         }
         return 0;
      }
      
      public function getSlotItemIconType(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getArray(_loc2_,"api_type",[0,0,0,0])[3];
      }
      
      public function getSlotItemPlaneIconType(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getArray(_loc2_,"api_type",[0,0,0,0])[4];
      }
      
      public function getCost(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_cost",-1);
      }
      
      public function getDistance(param1:int) : int
      {
         var _loc2_:Object = _getItemData(param1);
         return Util.getInt(_loc2_,"api_distance",0);
      }
      
      public function getEquipTypeIDs() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _equipTypeDic;
         for(var _loc2_ in _equipTypeDic)
         {
            _loc1_.push(parseInt(_loc2_));
         }
         return _loc1_;
      }
      
      public function getEquipTypeObject(param1:int) : EquipTypeObject
      {
         if(_equipTypeDic.hasOwnProperty(param1))
         {
            return _equipTypeDic[param1];
         }
         return null;
      }
      
      private function _getItemData(param1:int) : Object
      {
         if(_dic.hasOwnProperty(param1))
         {
            return _dic[param1];
         }
         return {};
      }
   }
}
