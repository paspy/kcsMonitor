package a24.tween.plugins.proxy
{
   import a24.tween.plugins.SoundMixerPlugin;
   
   public class SoundMixerPluginProxy
   {
       
      
      public function SoundMixerPluginProxy()
      {
         super();
      }
      
      public function tween(param1:Number, param2:Function = null) : SoundMixerPlugin
      {
         return SoundMixerPlugin.tween(param1,param2);
      }
      
      public function prop() : SoundMixerPlugin
      {
         return SoundMixerPlugin.prop();
      }
      
      public function allStop() : SoundMixerPlugin
      {
         return SoundMixerPlugin.allStop();
      }
   }
}
