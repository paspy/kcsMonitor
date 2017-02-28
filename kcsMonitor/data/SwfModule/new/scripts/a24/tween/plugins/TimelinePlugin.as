package a24.tween.plugins
{
   import a24.tween.Ease24;
   import a24.tween.Tween24;
   import a24.tween.core.plugins.PulginTween24;
   import a24.util.Util24;
   import flash.display.MovieClip;
   
   public final class TimelinePlugin extends PulginTween24
   {
       
      
      public function TimelinePlugin()
      {
         super();
      }
      
      public static function tweenFrame(param1:MovieClip, param2:int, param3:int = 0, param4:int = 0, param5:Function = null) : TimelinePlugin
      {
         if(!param3)
         {
            param3 = param1.currentFrame;
         }
         if(!param4)
         {
            param4 = param1.totalFrames;
         }
         if(!param5)
         {
            param5 = Ease24._Linear;
         }
         var _loc6_:TimelinePlugin = new TimelinePlugin();
         _loc6_._tween = Tween24.serial(Tween24.plugin.timeline.gotoAndStop(param3,param1),Tween24.tween(param1,(param4 - param3) / param2,param5).frame(param4));
         return _loc6_;
      }
      
      public static function play(... rest) : TimelinePlugin
      {
         rest.unshift(Util24.timeline.play);
         return new TimelinePlugin().setFunc.apply(null,rest) as TimelinePlugin;
      }
      
      public static function stop(... rest) : TimelinePlugin
      {
         rest.unshift(Util24.timeline.stop);
         return new TimelinePlugin().setFunc.apply(null,rest) as TimelinePlugin;
      }
      
      public static function gotoAndPlay(param1:*, ... rest) : TimelinePlugin
      {
         rest.unshift(Util24.timeline.gotoAndPlay,param1);
         return new TimelinePlugin().setFunc.apply(null,rest) as TimelinePlugin;
      }
      
      public static function gotoAndStop(param1:*, ... rest) : TimelinePlugin
      {
         rest.unshift(Util24.timeline.gotoAndStop,param1);
         return new TimelinePlugin().setFunc.apply(null,rest) as TimelinePlugin;
      }
      
      public static function gotoPrevFrame(... rest) : TimelinePlugin
      {
         rest.unshift(Util24.timeline.gotoPrevFrame);
         return new TimelinePlugin().setFunc.apply(null,rest) as TimelinePlugin;
      }
      
      public static function gotoNextFrame(... rest) : TimelinePlugin
      {
         rest.unshift(Util24.timeline.gotoNextFrame);
         return new TimelinePlugin().setFunc.apply(null,rest) as TimelinePlugin;
      }
      
      public static function gotoLastFrame(... rest) : TimelinePlugin
      {
         rest.unshift(Util24.timeline.gotoLastFrame);
         return new TimelinePlugin().setFunc.apply(null,rest) as TimelinePlugin;
      }
      
      public static function gotoRandomAndPlay(... rest) : TimelinePlugin
      {
         rest.unshift(Util24.timeline.gotoRandomAndPlay);
         return new TimelinePlugin().setFunc.apply(null,rest) as TimelinePlugin;
      }
      
      public static function gotoRandomAndStop(... rest) : TimelinePlugin
      {
         rest.unshift(Util24.timeline.gotoRandomAndStop);
         return new TimelinePlugin().setFunc.apply(null,rest) as TimelinePlugin;
      }
      
      public function delay(param1:Number) : TimelinePlugin
      {
         add("delay",param1);
         return this;
      }
      
      public function onPlay(param1:Function, ... rest) : TimelinePlugin
      {
         add("onPlay",param1,rest);
         return this;
      }
      
      public function onDelay(param1:Function, ... rest) : TimelinePlugin
      {
         add("onDelay",param1,rest);
         return this;
      }
      
      public function onInit(param1:Function, ... rest) : TimelinePlugin
      {
         add("onInit",param1,rest);
         return this;
      }
      
      public function onUpdate(param1:Function, ... rest) : TimelinePlugin
      {
         add("onUpdate",param1,rest);
         return this;
      }
      
      public function onPause(param1:Function, ... rest) : TimelinePlugin
      {
         add("onPause",param1,rest);
         return this;
      }
      
      public function onSkip(param1:Function, ... rest) : TimelinePlugin
      {
         add("onSkip",param1,rest);
         return this;
      }
      
      public function onStop(param1:Function, ... rest) : TimelinePlugin
      {
         add("onStop",param1,rest);
         return this;
      }
      
      public function onComplete(param1:Function, ... rest) : TimelinePlugin
      {
         add("onComplete",param1,rest);
         return this;
      }
   }
}
