package manager
{
   import a24.tween.Tween24;
   import common.util.BGMLoader;
   
   public class BGMManager
   {
      
      public static var JUKEBOX_SOUND:String = null;
      
      public static var REQUIRED_BGMID:String = null;
       
      
      public function BGMManager()
      {
         super();
      }
      
      public static function playPortBGM(param1:String, param2:int = 0, param3:Tween24 = null, param4:Tween24 = null, param5:Function = null, param6:Function = null, param7:int = 1) : void
      {
         getTweenPortBGM(param1,param2,param3,param4,param5,param6,param7).play();
      }
      
      public static function getTweenPortBGM(param1:String, param2:int = 0, param3:Tween24 = null, param4:Tween24 = null, param5:Function = null, param6:Function = null, param7:int = 1) : Tween24
      {
         bgmID = param1;
         fadeoutTime = param2;
         withLoadTween = param3;
         afterLoadTween = param4;
         onComplete = param5;
         onPlayComplete = param6;
         playCount = param7;
         REQUIRED_BGMID = bgmID;
         if(withLoadTween == null)
         {
            var withLoadTween:Tween24 = Tween24.wait(0);
         }
         if(afterLoadTween == null)
         {
            var afterLoadTween:Tween24 = Tween24.wait(0);
         }
         if(onComplete == null)
         {
            var onComplete:Function = function():void
            {
            };
         }
         var fadeoutTween:Tween24 = Tween24.wait(0);
         if(fadeoutTime > 0)
         {
            var fadeoutBGM:FadeoutBGM = new FadeoutBGM("MAIN_BGM",fadeoutTime);
            fadeoutTween = Tween24.parallel(Tween24.waitEvent(fadeoutBGM,"complete"),fadeoutBGM.start());
         }
         var bgm:BGMLoader = new BGMLoader("MAIN_BGM",0,onPlayComplete);
         return Tween24.serial(Tween24.parallel(bgm.getTween(bgmID,false,playCount),withLoadTween),fadeoutTween,afterLoadTween,Tween24.func(function():void
         {
            if(REQUIRED_BGMID == bgmID)
            {
               bgm.play();
            }
         })).onComplete(onComplete);
      }
   }
}

import a24.tween.Tween24;
import common.util.SoundUtil;
import flash.events.Event;
import flash.events.EventDispatcher;

class FadeoutBGM extends EventDispatcher
{
    
   
   private var _soundName:String = "";
   
   private var _time:int = 0;
   
   function FadeoutBGM(param1:String, param2:int)
   {
      super();
      _soundName = param1;
      _time = param2;
   }
   
   public function start() : Tween24
   {
      return Tween24.parallel(Tween24.waitEvent(this,"complete"),Tween24.func(SoundUtil.stopBGMFadeout,_soundName,_time,_complete));
   }
   
   private function _complete(param1:int) : void
   {
      dispatchEvent(new Event("complete"));
   }
}
