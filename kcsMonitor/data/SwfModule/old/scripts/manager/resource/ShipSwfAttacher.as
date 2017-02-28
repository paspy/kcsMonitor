package manager.resource
{
   import common.Consts;
   import common.debug.Debug;
   import common.events.BooleanEvent;
   import common.resources.ShipResourceLoader;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ShipSwfAttacher extends EventDispatcher implements IShipAttacher
   {
       
      
      private var _stackList:Vector.<ShipResourceLoader> = null;
      
      public function ShipSwfAttacher()
      {
         super();
         _stackList = new Vector.<ShipResourceLoader>();
      }
      
      public function get nowLoading() : Boolean
      {
         return _stackList.length > 0 && _stackList[0].nowLoading;
      }
      
      public function stackCardS(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && Consts.existTaihaImage(param1);
         _stack(param1,!_loc4_?"4":"5",param2);
      }
      
      public function stackCardSS(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && Consts.existTaihaImage(param1);
         _stack(param1,!_loc4_?"2":"3",param2);
      }
      
      public function stackCharaLevel(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && Consts.existTaihaImage(param1);
         _stack(param1,!_loc4_?"12":"13",param2);
      }
      
      public function stackCharacterFull(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && Consts.existTaihaImage(param1);
         _stack(param1,!_loc4_?"8":"9",param2);
      }
      
      public function stackCharacterUp(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && Consts.existTaihaImage(param1);
         _stack(param1,!_loc4_?"6":"7",param2);
      }
      
      public function stackFull(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && Consts.existTaihaImage(param1);
         _stack(param1,!_loc4_?"10":"11",param2);
      }
      
      public function stackSupplyCharacter(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && Consts.existTaihaImage(param1);
         _stack(param1,!_loc4_?"15":"16",param2);
      }
      
      public function stackStatusTopCharacter(param1:int, param2:DisplayObjectContainer) : void
      {
         _stack(param1,"14",param2);
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
         _stackList = new Vector.<ShipResourceLoader>();
      }
      
      private function _stack(param1:int, param2:String, param3:DisplayObjectContainer) : void
      {
         var _loc4_:ShipResourceLoader = new ShipResourceLoader(param1,param2,param3);
         _stackList.push(_loc4_);
      }
      
      private function _nextLoad() : void
      {
         if(nowLoading || !_stackList.length)
         {
            return;
         }
         var _loc1_:ShipResourceLoader = _stackList[0];
         _loc1_.addEventListener("complete",_handleLoadEnd);
         _loc1_.load();
      }
      
      private function _handleLoadEnd(param1:BooleanEvent) : void
      {
         if(nowLoading)
         {
            return;
         }
         var _loc3_:ShipResourceLoader = param1.target as ShipResourceLoader;
         if(_loc3_ != _stackList.shift())
         {
            return;
         }
         _loc3_.removeEventListener("complete",_handleLoadEnd);
         var _loc2_:String = !!param1.data?"Complete":"Error";
         _loc2_ = "[ShipResourceLoader] Load " + _loc2_ + "(残り" + _stackList.length + ")";
         Debug.log(_loc2_ + " " + _loc3_.url);
         if(_stackList.length > 0)
         {
            _nextLoad();
         }
         else
         {
            Debug.log("[ShipSwfAttacher] Load Complete ALL.");
            dispatchEvent(new Event("complete"));
         }
      }
   }
}
