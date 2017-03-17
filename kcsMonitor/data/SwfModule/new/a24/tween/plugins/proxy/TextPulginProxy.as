package a24.tween.plugins.proxy
{
   import a24.tween.plugins.TextPlugin;
   import flash.text.TextField;
   
   public class TextPulginProxy
   {
       
      
      public function TextPulginProxy()
      {
         super();
      }
      
      public function typingTween(param1:TextField, param2:String, param3:Number, param4:Boolean = false) : TextPlugin
      {
         return TextPlugin.typingTween(param1,param2,param3,param4);
      }
   }
}
