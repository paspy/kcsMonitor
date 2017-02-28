package manager.resource
{
   import common.debug.Debug;
   import common.events.BooleanEvent;
   import common.resources.SlotitemResourceLoader;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class SlotitemImgAttacher extends EventDispatcher implements ISlotitemAttacher
   {
       
      
      private var _stackList:Vector.<SlotitemResourceLoader> = null;
      
      public function SlotitemImgAttacher()
      {
         super();
         _stackList = new Vector.<SlotitemResourceLoader>();
      }
      
      public function get nowLoading() : Boolean
      {
         return _stackList.length > 0 && _stackList[0].nowLoading;
      }
      
      public function stackCard(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = "card";
         _stack(param1,_loc3_,param2);
      }
      
      public function stackItemOn(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = "item_on";
         _stack(param1,_loc3_,param2);
      }
      
      public function stackItemCharacter(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = "item_character";
         _stack(param1,_loc3_,param2);
      }
      
      public function stackItemUp(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = "item_up";
         _stack(param1,_loc3_,param2);
      }
      
      public function stackStatusTop(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = "statustop_item";
         _stack(param1,_loc3_,param2);
      }
      
      public function stackRemodel(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = "remodal";
         _stack(param1,_loc3_,param2);
      }
      
      public function stackBtxt(param1:int, param2:DisplayObjectContainer, param3:Boolean = true) : void
      {
         var _loc4_:String = !!param3?"btxt_flat":"btxt_tilt";
         _stack(param1,_loc4_,param2);
      }
      
      public function stackAirUnitName(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = "airunit_name";
         _stack(param1,_loc3_,param2);
      }
      
      public function stackAirUnitBanner(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = "airunit_banner";
         _stack(param1,_loc3_,param2);
      }
      
      public function stackAirUnitFairy(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = "airunit_fairy";
         _stack(param1,_loc3_,param2);
      }
      
      public function load() : void
      {
         if(_stackList.length == 0)
         {
            dispatchEvent(new Event("complete"));
         }
         else
         {
            Debug.log("[SlotitemImgAttacher] Load Start");
            _nextLoad();
         }
      }
      
      public function cancel() : void
      {
         if(_stackList.length)
         {
            Debug.log("[SlotitemImgAttacher] cancel.");
         }
         if(nowLoading)
         {
            _stackList[0].cancel();
         }
         _stackList = new Vector.<SlotitemResourceLoader>();
      }
      
      private function _stack(param1:int, param2:String, param3:DisplayObjectContainer, param4:Class = null) : void
      {
         var _loc5_:SlotitemResourceLoader = new SlotitemResourceLoader(param1,param2,param3,param4);
         _stackList.push(_loc5_);
      }
      
      private function _nextLoad() : void
      {
         if(nowLoading || !_stackList.length)
         {
            return;
         }
         var _loc1_:SlotitemResourceLoader = _stackList[0];
         _loc1_.addEventListener("complete",_handleLoadEnd);
         _loc1_.load();
      }
      
      private function _handleLoadEnd(param1:BooleanEvent) : void
      {
         if(nowLoading)
         {
            return;
         }
         var _loc3_:SlotitemResourceLoader = param1.target as SlotitemResourceLoader;
         if(_loc3_ != _stackList.shift())
         {
            return;
         }
         _loc3_.removeEventListener("complete",_handleLoadEnd);
         var _loc2_:String = !!param1.data?"Complete":"Error";
         _loc2_ = "[SlotitemResourceLoader] Load " + _loc2_ + "(残り" + _stackList.length + ")";
         Debug.log(_loc2_ + " " + _loc3_.url);
         if(_stackList.length > 0)
         {
            _nextLoad();
         }
         else
         {
            Debug.log("[SlotitemImgAttacher] Load Complete ALL.");
            dispatchEvent(new Event("complete"));
         }
      }
   }
}
