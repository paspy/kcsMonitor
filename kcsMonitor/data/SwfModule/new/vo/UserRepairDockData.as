package vo
{
   import dto.RepairDockDTO;
   
   public class UserRepairDockData
   {
       
      
      private var _arr:Array;
      
      private var _compTimeArr:Array;
      
      public function UserRepairDockData()
      {
         super();
         _arr = [];
      }
      
      public function get dockNum() : int
      {
         return _arr.length;
      }
      
      public function setData(param1:Array) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:Array = [];
         _compTimeArr = [];
         _loc7_ = 0;
         while(_loc7_ < dockNum)
         {
            _loc6_ = getDock(_loc7_);
            _loc5_ = _loc6_.shipID;
            _loc3_ = param1[_loc7_]["api_ship_id"];
            if(_loc5_ > 0 && _loc5_ != _loc3_)
            {
               _loc4_.push(_loc5_);
            }
            _loc7_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc4_.length)
         {
            _loc2_ = DataFacade.getUserDeckData().getShipData(_loc4_[_loc7_]);
            if(_loc2_ != null)
            {
               DataController.repair(_loc2_);
            }
            _loc7_++;
         }
         _loc4_ = [];
         _arr = param1;
         _loc7_ = 0;
         while(_loc7_ < dockNum)
         {
            _compTimeArr.push(param1[_loc7_]["api_complete_time"]);
            _loc7_++;
         }
      }
      
      public function getDock(param1:int) : RepairDockDTO
      {
         return new RepairDockDTO(_arr[param1]);
      }
      
      public function isInDock(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _arr.length)
         {
            if(getDock(_loc2_).shipID == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function get completeTime() : Array
      {
         return _compTimeArr;
      }
      
      function __setState(param1:int, param2:int) : void
      {
         var _loc3_:Object = _arr[param1];
         _loc3_["api_state"] = param2;
      }
      
      function __setShipID(param1:int, param2:int) : void
      {
         var _loc3_:Object = _arr[param1];
         _loc3_["api_ship_id"] = param2;
      }
      
      function __setCompleteTime(param1:int, param2:Number) : void
      {
         var _loc3_:Object = _arr[param1];
         _loc3_["api_complete_time"] = 0;
      }
   }
}
