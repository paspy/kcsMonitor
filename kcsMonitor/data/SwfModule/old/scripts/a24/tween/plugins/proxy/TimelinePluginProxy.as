package a24.tween.plugins.proxy
{
   import a24.tween.plugins.TimelinePlugin;
   import flash.display.MovieClip;
   
   public class TimelinePluginProxy
   {
       
      
      public function TimelinePluginProxy()
      {
         super();
      }
      
      public function tweenFrame(param1:MovieClip, param2:int, param3:int = 0, param4:int = 0, param5:Function = null) : TimelinePlugin
      {
         return TimelinePlugin.tweenFrame(param1,param2,param3,param4,param5);
      }
      
      public function play(... rest) : TimelinePlugin
      {
         return TimelinePlugin.play.apply(this,rest);
      }
      
      public function stop(... rest) : TimelinePlugin
      {
         return TimelinePlugin.stop.apply(this,rest);
      }
      
      public function gotoAndPlay(param1:*, ... rest) : TimelinePlugin
      {
         rest.unshift(param1);
         return TimelinePlugin.gotoAndPlay.apply(this,rest);
      }
      
      public function gotoAndStop(param1:*, ... rest) : TimelinePlugin
      {
         rest.unshift(param1);
         return TimelinePlugin.gotoAndStop.apply(this,rest);
      }
      
      public function gotoPrevFrame(... rest) : TimelinePlugin
      {
         return TimelinePlugin.gotoPrevFrame.apply(this,rest);
      }
      
      public function gotoNextFrame(... rest) : TimelinePlugin
      {
         return TimelinePlugin.gotoNextFrame.apply(this,rest);
      }
      
      public function gotoLastFrame(... rest) : TimelinePlugin
      {
         return TimelinePlugin.gotoLastFrame.apply(this,rest);
      }
      
      public function gotoRandomAndPlay(... rest) : TimelinePlugin
      {
         return TimelinePlugin.gotoRandomAndPlay.apply(this,rest);
      }
      
      public function gotoRandomAndStop(... rest) : TimelinePlugin
      {
         return TimelinePlugin.gotoRandomAndStop.apply(this,rest);
      }
   }
}
