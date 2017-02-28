package a24.tween.plugins
{
   import a24.tween.Tween24;
   import a24.tween.core.plugins.PulginTween24;
   import flash.text.TextField;
   
   public class TextPlugin extends PulginTween24
   {
       
      
      public function TextPlugin()
      {
         super();
      }
      
      public static function typingTween(param1:TextField, param2:String, param3:Number, param4:Boolean = false) : TextPlugin
      {
         textField = param1;
         text = param2;
         delay = param3;
         reset = param4;
         var plugin:TextPlugin = new TextPlugin();
         plugin._tween = Tween24.serial(Tween24.ifCase(reset,Tween24.prop(textField,{"text":""})),Tween24.loop(text.length,Tween24.wait(delay),Tween24.func(function():void
         {
            textField.appendText(text.charAt(i));
            i = Number(i) + 1;
         })));
         return plugin;
      }
      
      public function delay(param1:Number) : TextPlugin
      {
         _tween.delay(param1);
         return this;
      }
      
      public function onPlay(param1:Function, ... rest) : TextPlugin
      {
         rest.unshift(param1);
         _tween.onPlay.apply(_tween,rest);
         return this;
      }
      
      public function onDelay(param1:Function, ... rest) : TextPlugin
      {
         rest.unshift(param1);
         _tween.onDelay.apply(_tween,rest);
         return this;
      }
      
      public function onInit(param1:Function, ... rest) : TextPlugin
      {
         rest.unshift(param1);
         _tween.onInit.apply(_tween,rest);
         return this;
      }
      
      public function onUpdate(param1:Function, ... rest) : TextPlugin
      {
         rest.unshift(param1);
         _tween.onUpdate.apply(_tween,rest);
         return this;
      }
      
      public function onPause(param1:Function, ... rest) : TextPlugin
      {
         rest.unshift(param1);
         _tween.onPause.apply(_tween,rest);
         return this;
      }
      
      public function onStop(param1:Function, ... rest) : TextPlugin
      {
         rest.unshift(param1);
         _tween.onStop.apply(_tween,rest);
         return this;
      }
      
      public function onComplete(param1:Function, ... rest) : TextPlugin
      {
         rest.unshift(param1);
         _tween.onComplete.apply(_tween,rest);
         return this;
      }
   }
}
