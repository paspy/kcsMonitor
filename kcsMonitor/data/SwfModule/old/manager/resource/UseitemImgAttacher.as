package manager.resource
{
   import common.debug.Debug;
   import common.events.BooleanEvent;
   import common.resources.UseitemResourceLoader;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class UseitemImgAttacher extends EventDispatcher implements IUseitemAttacher
   {
       
      
      private var _stackList:Vector.<UseitemResourceLoader> = null;
      
      public function UseitemImgAttacher()
      {
         super();
         _stackList = new Vector.<UseitemResourceLoader>();
      }
      
      public function get nowLoading() : Boolean
      {
         return _stackList.length > 0 && _stackList[0].nowLoading;
      }
      
      public function stackCard(param1:int, param2:DisplayObjectContainer) : void
      {
         _stack(param1,"card",param2);
      }
      
      public function stackIcon(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:IconResourceImageLoader = new IconResourceImageLoader(param1,param2,Assets.UseitemIconMC);
         _stackList.push(_loc3_);
      }
      
      public function stackPayItemIcon(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:IconResourceImageLoader = new IconResourceImageLoader(param1,param2,Assets.PaymentitemIconMC);
         _stackList.push(_loc3_);
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
         _stackList = new Vector.<UseitemResourceLoader>();
      }
      
      private function _stack(param1:int, param2:String, param3:DisplayObjectContainer, param4:Class = null) : void
      {
         var _loc5_:UseitemResourceLoader = new UseitemResourceLoader(param1,param2,param3,param4);
         _stackList.push(_loc5_);
      }
      
      private function _nextLoad() : void
      {
         if(nowLoading || !_stackList.length)
         {
            return;
         }
         var _loc1_:UseitemResourceLoader = _stackList[0];
         _loc1_.addEventListener("complete",_handleLoadEnd);
         _loc1_.load();
      }
      
      private function _handleLoadEnd(param1:BooleanEvent) : void
      {
         if(nowLoading)
         {
            return;
         }
         var _loc3_:UseitemResourceLoader = param1.target as UseitemResourceLoader;
         if(_loc3_ != _stackList.shift())
         {
            return;
         }
         _loc3_.removeEventListener("complete",_handleLoadEnd);
         var _loc2_:String = !!param1.data?"Complete":"Error";
         _loc2_ = "[UseitemResourceLoader] Load " + _loc2_ + "(残り" + _stackList.length + ")";
         Debug.log(_loc2_ + " " + _loc3_.url);
         if(_stackList.length > 0)
         {
            _nextLoad();
         }
         else
         {
            Debug.log("[UseitemResourceLoader] Load Complete ALL.");
            dispatchEvent(new Event("complete"));
         }
      }
   }
}

import common.events.BooleanEvent;
import common.resources.UseitemResourceLoader;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;

class IconResourceImageLoader extends UseitemResourceLoader
{
    
   
   private var _cls:Class;
   
   function IconResourceImageLoader(param1:int, param2:DisplayObjectContainer, param3:Class)
   {
      super(param1,"icon",param2,null);
      _cls = param3;
   }
   
   override public function load() : void
   {
      var _loc1_:MovieClip = new _cls();
      _loc1_.gotoAndStop(_mstId);
      if(_parent != null)
      {
         _parent.addChild(_loc1_);
      }
      dispatchEvent(new BooleanEvent("complete",true));
      _finalize();
   }
   
   override public function cancel() : void
   {
   }
}
