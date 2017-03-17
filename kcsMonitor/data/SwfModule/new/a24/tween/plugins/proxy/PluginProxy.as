package a24.tween.plugins.proxy
{
   public class PluginProxy
   {
       
      
      private var _matrix:MatrixPluginProxy;
      
      private var _social:SocialPulginProxy;
      
      private var _soundMixer:SoundMixerPluginProxy;
      
      private var _sound:SoundPulginProxy;
      
      private var _text:TextPulginProxy;
      
      private var _timeline:TimelinePluginProxy;
      
      public function PluginProxy()
      {
         super();
         _matrix = new MatrixPluginProxy();
         _social = new SocialPulginProxy();
         _soundMixer = new SoundMixerPluginProxy();
         _sound = new SoundPulginProxy();
         _timeline = new TimelinePluginProxy();
         _text = new TextPulginProxy();
      }
      
      public function get matrix() : MatrixPluginProxy
      {
         return _matrix;
      }
      
      public function get social() : SocialPulginProxy
      {
         return _social;
      }
      
      public function get soundMixer() : SoundMixerPluginProxy
      {
         return _soundMixer;
      }
      
      public function get sound() : SoundPulginProxy
      {
         return _sound;
      }
      
      public function get text() : TextPulginProxy
      {
         return _text;
      }
      
      public function get timeline() : TimelinePluginProxy
      {
         return _timeline;
      }
   }
}
