package vo
{
   import flash.utils.Dictionary;
   
   public class UserFurnitureData
   {
       
      
      private var _userWallDic:Dictionary;
      
      private var _userFloorDic:Dictionary;
      
      private var _userDeskDic:Dictionary;
      
      private var _userWindowDic:Dictionary;
      
      private var _userObjectDic:Dictionary;
      
      private var _userChestDic:Dictionary;
      
      private var _furnitureArr:Array;
      
      private var _furnitureCount:int;
      
      public function UserFurnitureData()
      {
         var _loc1_:int = 0;
         _furnitureArr = [Array,Array,Array,Array,Array,Array];
         super();
         _userWallDic = new Dictionary();
         _userFloorDic = new Dictionary();
         _userDeskDic = new Dictionary();
         _userWindowDic = new Dictionary();
         _userObjectDic = new Dictionary();
         _userChestDic = new Dictionary();
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _furnitureArr[_loc1_] = [];
            _loc1_++;
         }
      }
      
      public function get furnitureCount() : int
      {
         return _furnitureCount;
      }
      
      public function setData(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _furnitureCount = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _furnitureCount)
         {
            _loc2_ = {};
            _loc2_ = param1[_loc5_];
            _loc4_ = _loc2_.api_id;
            _loc3_ = _loc2_.api_furniture_no;
            _furnitureArr[_loc2_["api_furniture_type"]].push(_loc4_);
            selectDictionary(_loc2_["api_furniture_type"])[_loc2_["api_id"]] = _loc2_;
            _loc5_++;
         }
      }
      
      public function getFurnitureArr(param1:int) : Array
      {
         return _furnitureArr[param1];
      }
      
      public function selectDictionary(param1:int) : Dictionary
      {
         switch(int(param1))
         {
            case 0:
               return _userFloorDic;
            case 1:
               return _userWallDic;
            case 2:
               return _userWindowDic;
            case 3:
               return _userObjectDic;
            case 4:
               return _userChestDic;
            case 5:
               return _userDeskDic;
         }
      }
      
      public function getFurnitureNo(param1:int, param2:int) : int
      {
         if(selectDictionary(param1) && selectDictionary(param1).hasOwnProperty(param2))
         {
            return selectDictionary(param1)[param2]["api_furniture_no"] + 1;
         }
         return 1;
      }
      
      public function getUserFloorNo(param1:UserData) : int
      {
         var _loc2_:int = param1.getFurnitureFloorID();
         return getFurnitureNo(0,_loc2_);
      }
      
      public function getUserWallNo(param1:UserData) : int
      {
         var _loc2_:int = param1.getFurnitureWallID();
         return getFurnitureNo(1,_loc2_);
      }
      
      public function getUserWindowNo(param1:UserData) : int
      {
         var _loc2_:int = param1.getFurnitureWindowID();
         return getFurnitureNo(2,_loc2_);
      }
      
      public function getUserObjectNo(param1:UserData) : int
      {
         var _loc2_:int = param1.getFurnitureObjectID();
         return getFurnitureNo(3,_loc2_);
      }
      
      public function getUserChestNo(param1:UserData) : int
      {
         var _loc2_:int = param1.getFurnitureChestID();
         return getFurnitureNo(4,_loc2_);
      }
      
      public function getUserDeskNo(param1:UserData) : int
      {
         var _loc2_:int = param1.getFurnitureDeskID();
         return getFurnitureNo(5,_loc2_);
      }
      
      public function hasItem(param1:int, param2:int) : Boolean
      {
         var _loc3_:Dictionary = selectDictionary(param1);
         return _loc3_ && _loc3_.hasOwnProperty(param2);
      }
      
      function __addData(param1:int, param2:int, param3:int) : void
      {
         _furnitureArr[param1].push(param2);
         selectDictionary(param1)[param2] = {"api_furniture_no":param3};
      }
   }
}
