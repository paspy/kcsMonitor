package vo
{
   import dto.BuildDockDTO;
   
   public class UserBuildDockData
   {
       
      
      private var _a:Array;
      
      private var _nextOpenDockID:int = -1;
      
      public function UserBuildDockData()
      {
         super();
      }
      
      public function get nextOpenDockID() : int
      {
         return _nextOpenDockID;
      }
      
      public function setData(param1:Array) : void
      {
         _a = param1;
         updateNextOpenDockID();
      }
      
      public function getDataFromIndex(param1:int) : BuildDockDTO
      {
         if(param1 < _a.length)
         {
            return new BuildDockDTO(_a[param1]);
         }
         return null;
      }
      
      public function getDataFromID(param1:int) : BuildDockDTO
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _a.length)
         {
            _loc2_ = new BuildDockDTO(_a[_loc3_]);
            if(_loc2_.dockID == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getDockCount() : int
      {
         return _a.length;
      }
      
      public function getOpenedDockCount() : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _a.length)
         {
            _loc2_ = new BuildDockDTO(_a[_loc3_]);
            if(_loc2_.isOpened())
            {
               _loc1_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function updateNextOpenDockID() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _a.length)
         {
            _loc1_ = new BuildDockDTO(_a[_loc2_]);
            if(_loc1_.state == -1)
            {
               _nextOpenDockID = _loc1_.dockID;
               return;
            }
            _loc2_++;
         }
         _nextOpenDockID = -1;
      }
   }
}
