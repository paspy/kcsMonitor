package vo
{
   import common.debug.Debug;
   import common.util.Util;
   import dto.FurnitureDTO;
   import flash.display.Shape;
   import flash.utils.Dictionary;
   
   public class MasterFurnitureData
   {
       
      
      private var _allDic:Dictionary;
      
      private var _wallDic:Dictionary;
      
      private var _floorDic:Dictionary;
      
      private var _deskDic:Dictionary;
      
      private var _windowDic:Dictionary;
      
      private var _objectDic:Dictionary;
      
      private var _chestDic:Dictionary;
      
      public function MasterFurnitureData()
      {
         super();
         _allDic = new Dictionary();
         _wallDic = new Dictionary();
         _floorDic = new Dictionary();
         _deskDic = new Dictionary();
         _windowDic = new Dictionary();
         _objectDic = new Dictionary();
         _chestDic = new Dictionary();
      }
      
      public function setData(param1:Array) : void
      {
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < param1.length)
         {
            _loc2_ = param1[_loc8_];
            _loc3_ = _loc2_["api_type"];
            _loc7_ = _loc2_["api_id"];
            _loc6_ = selectDictionary(_loc3_);
            if(_loc6_ == _windowDic)
            {
               _loc5_ = [1,1,1,4,4,1,4,1,4,5,4,3,1,1,4,1,1,3,1,1,1,1,3,3,3,1,4,3,3,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,3,4,2,1];
               _loc4_ = _loc2_["api_no"];
               if(_loc5_.hasOwnProperty(_loc4_))
               {
                  _loc2_["window_type"] = _loc5_[_loc4_];
               }
               if(_loc4_ == 18)
               {
                  _loc2_["offset"] = [10,0];
               }
               else if(_loc4_ == 22)
               {
                  _loc2_["offset"] = [-13,0];
               }
               else if(_loc4_ == 8)
               {
                  _loc2_["offset"] = [-1,0];
               }
               else if(_loc4_ == 31)
               {
                  _loc2_["offset"] = [-19,0];
               }
            }
            _loc6_[_loc7_] = _loc2_;
            _allDic[_loc7_] = _loc2_;
            _loc8_++;
         }
      }
      
      public function getIDList(param1:int) : Array
      {
         var _loc3_:* = null;
         var _loc4_:Dictionary = selectDictionary(param1);
         if(_loc4_ == null)
         {
            return [];
         }
         _loc3_ = [];
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for(var _loc2_ in _loc4_)
         {
            _loc3_.push(_loc2_);
         }
         _loc3_.sort();
         return _loc3_;
      }
      
      private function selectDictionary(param1:int) : Dictionary
      {
         switch(int(param1))
         {
            case 0:
               return _floorDic;
            case 1:
               return _wallDic;
            case 2:
               return _windowDic;
            case 3:
               return _objectDic;
            case 4:
               return _chestDic;
            case 5:
               return _deskDic;
         }
      }
      
      public function getType(param1:int) : int
      {
         var _loc2_:* = null;
         if(_allDic.hasOwnProperty(param1))
         {
            _loc2_ = _allDic[param1];
            return Util.getInt(_loc2_,"api_type",-1);
         }
         return -1;
      }
      
      public function getNo(param1:int) : int
      {
         var _loc2_:* = null;
         if(_allDic.hasOwnProperty(param1))
         {
            _loc2_ = _allDic[param1];
            return Util.getInt(_loc2_,"api_no",-1);
         }
         return -1;
      }
      
      public function getID(param1:int, param2:int) : int
      {
         var _loc5_:int = 0;
         var _loc4_:Dictionary = selectDictionary(param1);
         var _loc7_:int = 0;
         var _loc6_:* = _loc4_;
         for(var _loc3_ in _loc4_)
         {
            _loc5_ = parseInt(_loc3_);
            if(_loc4_[_loc5_]["api_no"] == param2)
            {
               return _loc5_;
            }
         }
         return -1;
      }
      
      public function getFurnitureName(param1:int, param2:int) : String
      {
         if(selectDictionary(param1).hasOwnProperty(param2))
         {
            return selectDictionary(param1)[param2]["api_title"];
         }
         return "----";
      }
      
      public function getFurnitureDescription(param1:int, param2:int) : String
      {
         if(selectDictionary(param1).hasOwnProperty(param2))
         {
            return selectDictionary(param1)[param2]["api_description"];
         }
         return "----";
      }
      
      public function getFurniturePrice(param1:int, param2:int) : int
      {
         if(selectDictionary(param1).hasOwnProperty(param2))
         {
            return selectDictionary(param1)[param2]["api_price"];
         }
         return 0;
      }
      
      public function getFurnitureNumber(param1:int, param2:int) : int
      {
         if(selectDictionary(param1).hasOwnProperty(param2))
         {
            return selectDictionary(param1)[param2]["api_no"];
         }
         return 0;
      }
      
      public function isSale(param1:int, param2:int) : Boolean
      {
         if(selectDictionary(param1).hasOwnProperty(param2))
         {
            return selectDictionary(param1)[param2]["api_saleflg"] == 1;
         }
         return false;
      }
      
      public function getFurnitureNumberArray(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = new Array(6);
         while(_loc3_ < 6)
         {
            if(selectDictionary(_loc3_).hasOwnProperty(param1[_loc3_]))
            {
               _loc2_[_loc3_] = selectDictionary(_loc3_)[param1[_loc3_]]["api_id"];
            }
            else
            {
               _loc2_[_loc3_] = 0;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getFurnitureRarity(param1:int, param2:int) : int
      {
         if(selectDictionary(param1).hasOwnProperty(param2))
         {
            return selectDictionary(param1)[param2]["api_rarity"];
         }
         return 0;
      }
      
      public function getWindowType(param1:int) : int
      {
         var _loc2_:int = getID(2,param1);
         var _loc3_:int = 4;
         if(_windowDic.hasOwnProperty(_loc2_))
         {
            if(_windowDic[_loc2_].hasOwnProperty("window_type"))
            {
               _loc3_ = _windowDic[_loc2_]["window_type"];
            }
         }
         Debug.log("[WindowType]: " + _loc3_ + " itemID:" + _loc2_ + " windowNo:" + param1);
         return _loc3_;
      }
      
      public function getOffset(param1:int, param2:int) : Array
      {
         var _loc3_:int = getID(param1,param2);
         var _loc4_:Dictionary = selectDictionary(param1);
         if(_loc4_.hasOwnProperty(_loc3_))
         {
            return Util.getArray(_loc4_[_loc3_],"offset",[0,0]);
         }
         return [0,0];
      }
      
      public function getItem(param1:int) : FurnitureDTO
      {
         if(_allDic.hasOwnProperty(param1))
         {
            return new FurnitureDTO(_allDic[param1]);
         }
         return null;
      }
      
      public function getItemsForSale(param1:int) : Vector.<FurnitureDTO>
      {
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Array = [];
         var _loc6_:Dictionary = selectDictionary(param1);
         var _loc10_:int = 0;
         var _loc9_:* = _loc6_;
         for(var _loc5_ in _loc6_)
         {
            _loc4_ = _loc6_[_loc5_];
            if(Util.getInt(_loc4_,"api_saleflg",0) == 1)
            {
               _loc2_.push(_loc4_);
            }
         }
         _loc2_.sortOn("api_no",16);
         var _loc8_:Vector.<FurnitureDTO> = new Vector.<FurnitureDTO>();
         _loc7_ = 0;
         while(_loc7_ < _loc2_.length)
         {
            _loc3_ = new FurnitureDTO(_loc2_[_loc7_]);
            _loc8_.push(_loc3_);
            _loc7_++;
         }
         return _loc8_;
      }
      
      public function getItemsHave() : Array
      {
         var _loc10_:int = 0;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc9_:* = undefined;
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Array = new Array(6);
         _loc10_ = 0;
         while(_loc10_ < 6)
         {
            _loc6_ = selectDictionary(_loc10_);
            _loc2_ = [];
            var _loc12_:int = 0;
            var _loc11_:* = _loc6_;
            for(var _loc5_ in _loc6_)
            {
               _loc4_ = _loc6_[_loc5_];
               _loc7_ = new FurnitureDTO(_loc4_);
               if(_loc7_.hasItem())
               {
                  _loc2_.push(_loc4_);
               }
            }
            _loc2_.sortOn("api_no",16);
            _loc9_ = new Vector.<FurnitureDTO>();
            _loc8_ = 0;
            while(_loc8_ < _loc2_.length)
            {
               _loc3_ = new FurnitureDTO(_loc2_[_loc8_]);
               _loc9_.push(_loc3_);
               _loc8_++;
            }
            _loc1_[_loc10_] = _loc9_;
            _loc10_++;
         }
         return _loc1_;
      }
      
      public function getWindowBGMaskShape(param1:int) : Shape
      {
         var _loc2_:Shape = null;
         if(param1 == 5)
         {
            _loc2_ = new Shape();
            _loc2_.graphics.beginFill(0);
            _loc2_.graphics.moveTo(85,0);
            _loc2_.graphics.lineTo(85,116);
            _loc2_.graphics.lineTo(170,120);
            _loc2_.graphics.lineTo(170,0);
            _loc2_.graphics.moveTo(250,0);
            _loc2_.graphics.lineTo(250,122);
            _loc2_.graphics.lineTo(345,129);
            _loc2_.graphics.lineTo(345,0);
            _loc2_.graphics.endFill();
         }
         return _loc2_;
      }
   }
}
