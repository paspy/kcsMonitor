package manager.resource
{
   import common.debug.Debug;
   import common.events.BooleanEvent;
   import common.resources.FurnitureResourceLoader;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import vo.StartData;
   
   public class FurnitureImgAttacher extends EventDispatcher implements IFurnitureAttacher
   {
       
      
      private var _stackList:Vector.<FurnitureResourceLoader> = null;
      
      public function FurnitureImgAttacher()
      {
         super();
         _stackList = new Vector.<FurnitureResourceLoader>();
      }
      
      public function get nowLoading() : Boolean
      {
         return _stackList.length > 0 && _stackList[0].nowLoading;
      }
      
      public function stack(param1:int, param2:int, param3:DisplayObjectContainer) : void
      {
         var _loc4_:int = 0;
         switch(int(param1))
         {
            case 0:
               stackFloor(param2,param3,_loc4_);
               break;
            case 1:
               stackWall(param2,param3,_loc4_);
               break;
            case 2:
               stackWindow(param2,param3,_loc4_);
               break;
            case 3:
               stackObject(param2,param3,_loc4_);
               break;
            case 4:
               stackChest(param2,param3,_loc4_);
               break;
            case 5:
               stackDesk(param2,param3,_loc4_);
         }
      }
      
      public function stackThumbnail(param1:int, param2:int, param3:DisplayObjectContainer) : void
      {
         var _loc4_:int = 1;
         switch(int(param1))
         {
            case 0:
               stackFloor(param2,param3,_loc4_);
               break;
            case 1:
               stackWall(param2,param3,_loc4_);
               break;
            case 2:
               stackWindow(param2,param3,_loc4_);
               break;
            case 3:
               stackObject(param2,param3,_loc4_);
               break;
            case 4:
               stackChest(param2,param3,_loc4_);
               break;
            case 5:
               stackDesk(param2,param3,_loc4_);
         }
      }
      
      public function stackCard(param1:int, param2:int, param3:DisplayObjectContainer) : void
      {
         var _loc4_:int = 2;
         switch(int(param1))
         {
            case 0:
               stackFloor(param2,param3,_loc4_);
               break;
            case 1:
               stackWall(param2,param3,_loc4_);
               break;
            case 2:
               stackWindow(param2,param3,_loc4_);
               break;
            case 3:
               stackObject(param2,param3,_loc4_);
               break;
            case 4:
               stackChest(param2,param3,_loc4_);
               break;
            case 5:
               stackDesk(param2,param3,_loc4_);
         }
      }
      
      public function stackFloor(param1:int, param2:DisplayObjectContainer, param3:int = 0) : void
      {
         param1--;
         _stack("floor",0,param1,param2,param3,null);
      }
      
      public function stackWall(param1:int, param2:DisplayObjectContainer, param3:int = 0) : void
      {
         param1--;
         _stack("wall",1,param1,param2,param3,null);
      }
      
      public function stackWindow(param1:int, param2:DisplayObjectContainer, param3:int = 0) : void
      {
         param1--;
         _stack("window",2,param1,param2,param3,null);
      }
      
      public function stackObject(param1:int, param2:DisplayObjectContainer, param3:int = 0) : void
      {
         param1--;
         _stack("object",3,param1,param2,param3,null);
      }
      
      public function stackChest(param1:int, param2:DisplayObjectContainer, param3:int = 0) : void
      {
         param1--;
         _stack("chest",4,param1,param2,param3,null);
      }
      
      public function stackDesk(param1:int, param2:DisplayObjectContainer, param3:int = 0) : void
      {
         param1--;
         _stack("desk",5,param1,param2,param3,null);
      }
      
      public function load() : void
      {
         if(_stackList.length == 0)
         {
            dispatchEvent(new Event("complete"));
         }
         else
         {
            _nextLoad();
         }
      }
      
      public function cancel() : void
      {
         if(_stackList.length)
         {
            Debug.log("[ResourceImageManager] cancel.");
         }
         if(nowLoading)
         {
            _stackList[0].cancel();
         }
         _stackList = new Vector.<FurnitureResourceLoader>();
      }
      
      private function _stack(param1:String, param2:int, param3:int, param4:DisplayObjectContainer, param5:int, param6:Class) : void
      {
         var _loc9_:StartData = DataFacade.getStartData();
         var _loc7_:int = DataFacade.getMasterFurnitureData().getID(param2,param3);
         var _loc8_:FurnitureResourceLoader = new FurnitureResourceLoader(_loc7_,param1,param4,param5,param6);
         _stackList.push(_loc8_);
      }
      
      private function _nextLoad() : void
      {
         if(nowLoading || !_stackList.length)
         {
            return;
         }
         var _loc1_:FurnitureResourceLoader = _stackList[0];
         _loc1_.addEventListener("complete",_handleLoadEnd);
         _loc1_.load();
      }
      
      private function _handleLoadEnd(param1:BooleanEvent) : void
      {
         if(nowLoading)
         {
            return;
         }
         var _loc3_:FurnitureResourceLoader = param1.target as FurnitureResourceLoader;
         if(_loc3_ != _stackList.shift())
         {
            return;
         }
         _loc3_.removeEventListener("complete",_handleLoadEnd);
         var _loc2_:String = !!param1.data?"Complete":"Error";
         _loc2_ = "[FurnitureResourceLoader] Load " + _loc2_ + "(残り" + _stackList.length + ")";
         Debug.log(_loc2_ + " " + _loc3_.url);
         if(_stackList.length > 0)
         {
            _nextLoad();
         }
         else
         {
            Debug.log("[FurnitureResourceLoader] Load Complete ALL.");
            dispatchEvent(new Event("complete"));
         }
      }
   }
}
