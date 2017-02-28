package a24.tween.plugins
{
   import a24.tween.Tween24;
   import a24.tween.core.plugins.PulginTween24;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.escapeMultiByte;
   
   public final class SocialPlugin extends PulginTween24
   {
       
      
      public function SocialPlugin()
      {
         super();
      }
      
      public static function tweet(param1:String) : SocialPlugin
      {
         var _loc2_:SocialPlugin = new SocialPlugin();
         _loc2_._tween = Tween24.func(popup,"http://twitter.com/?status=" + escapeMultiByte(param1));
         return _loc2_;
      }
      
      public static function tweetShare(param1:String, param2:String, param3:String = null) : SocialPlugin
      {
         var _loc4_:String = "https://twitter.com/intent/tweet";
         _loc4_ = _loc4_ + ("?original_referer=" + escapeMultiByte(param1));
         _loc4_ = _loc4_ + ("&text=" + escapeMultiByte(param2));
         _loc4_ = _loc4_ + ("&url=" + escapeMultiByte(param1));
         if(param3)
         {
            _loc4_ = _loc4_ + ("&via=" + escapeMultiByte(param3));
         }
         var _loc5_:SocialPlugin = new SocialPlugin();
         _loc5_._tween = Tween24.func(popup,_loc4_);
         return _loc5_;
      }
      
      public static function facebokShare(param1:String) : SocialPlugin
      {
         var _loc2_:SocialPlugin = new SocialPlugin();
         _loc2_._tween = Tween24.func(popup,"http://www.facebook.com/sharer.php?u=" + escapeMultiByte(param1));
         return _loc2_;
      }
      
      public static function mixiCheck(param1:String, param2:String) : SocialPlugin
      {
         var _loc3_:SocialPlugin = new SocialPlugin();
         _loc3_._tween = Tween24.func(popup,"http://mixi.jp/share.pl?u=" + escapeMultiByte(param1) + "&k=" + escapeMultiByte(param2));
         return _loc3_;
      }
      
      private static function popup(param1:String) : void
      {
         try
         {
            ExternalInterface.call("window.open",param1,"_blank","width=640, height=360");
            return;
         }
         catch(e:Error)
         {
            navigateToURL(new URLRequest(param1),"_blank");
            return;
         }
      }
      
      public function delay(param1:Number) : SocialPlugin
      {
         _tween.delay(param1);
         return this;
      }
      
      public function onPlay(param1:Function, ... rest) : SocialPlugin
      {
         rest.unshift(param1);
         _tween.onPlay.apply(_tween,rest);
         return this;
      }
      
      public function onDelay(param1:Function, ... rest) : SocialPlugin
      {
         rest.unshift(param1);
         _tween.onDelay.apply(_tween,rest);
         return this;
      }
      
      public function onInit(param1:Function, ... rest) : SocialPlugin
      {
         rest.unshift(param1);
         _tween.onInit.apply(_tween,rest);
         return this;
      }
      
      public function onUpdate(param1:Function, ... rest) : SocialPlugin
      {
         rest.unshift(param1);
         _tween.onUpdate.apply(_tween,rest);
         return this;
      }
      
      public function onPause(param1:Function, ... rest) : SocialPlugin
      {
         rest.unshift(param1);
         _tween.onPause.apply(_tween,rest);
         return this;
      }
      
      public function onStop(param1:Function, ... rest) : SocialPlugin
      {
         rest.unshift(param1);
         _tween.onStop.apply(_tween,rest);
         return this;
      }
      
      public function onComplete(param1:Function, ... rest) : SocialPlugin
      {
         rest.unshift(param1);
         _tween.onComplete.apply(_tween,rest);
         return this;
      }
   }
}
