package a24.tween.plugins.proxy
{
   import a24.tween.plugins.SoundPlugin;
   import flash.media.Sound;
   import flash.media.SoundTransform;
   
   public class SoundPulginProxy
   {
       
      
      public function SoundPulginProxy()
      {
         super();
      }
      
      public function addSound(param1:String, param2:Sound, param3:Number = 1) : void
      {
         return SoundPlugin.addSound(param1,param2,param3);
      }
      
      public function removeSound(param1:String) : void
      {
         return SoundPlugin.removeSound(param1);
      }
      
      public function tween(param1:String, param2:Number, param3:Function = null) : SoundPlugin
      {
         return SoundPlugin.tween(param1,param2,param3);
      }
      
      public function prop(param1:String) : SoundPlugin
      {
         return SoundPlugin.prop(param1);
      }
      
      public function playSound(param1:String, param2:Number = 0, param3:int = 0, param4:SoundTransform = null) : SoundPlugin
      {
         return SoundPlugin.playSound(param1,param2,param3,param4);
      }
      
      public function stopSound(param1:String) : SoundPlugin
      {
         return SoundPlugin.stopSound(param1);
      }
   }
}
