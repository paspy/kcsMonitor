package a24.tween.plugins
{
   import a24.tween.core.plugins.PulginTween24;
   import flash.media.SoundMixer;
   
   public class SoundMixerPlugin extends PulginTween24
   {
      
      private static var _property:SoundMixerTween24Property;
       
      
      public function SoundMixerPlugin()
      {
         super();
         if(!_property)
         {
            _property = new SoundMixerTween24Property();
         }
      }
      
      public static function tween(param1:Number, param2:Function = null) : SoundMixerPlugin
      {
         var _loc3_:SoundMixerPlugin = new SoundMixerPlugin();
         _loc3_.setTween(_property,param1,param2);
         return _loc3_;
      }
      
      public static function prop() : SoundMixerPlugin
      {
         var _loc1_:SoundMixerPlugin = new SoundMixerPlugin();
         _loc1_.setProp(_property);
         return _loc1_;
      }
      
      public static function allStop() : SoundMixerPlugin
      {
         var _loc1_:SoundMixerPlugin = new SoundMixerPlugin();
         _loc1_.setFunc(SoundMixer.stopAll);
         return _loc1_;
      }
      
      public function volume(param1:Number) : SoundMixerPlugin
      {
         addParam("volume",param1);
         return this;
      }
      
      public function pan(param1:Number) : SoundMixerPlugin
      {
         addParam("pan",param1);
         return this;
      }
      
      public function leftToLeft(param1:Number) : SoundMixerPlugin
      {
         addParam("leftToLeft",param1);
         return this;
      }
      
      public function leftToRight(param1:Number) : SoundMixerPlugin
      {
         addParam("leftToRight",param1);
         return this;
      }
      
      public function rightToLeft(param1:Number) : SoundMixerPlugin
      {
         addParam("rightToLeft",param1);
         return this;
      }
      
      public function rightToRight(param1:Number) : SoundMixerPlugin
      {
         addParam("rightToRight",param1);
         return this;
      }
      
      public function delay(param1:Number) : SoundMixerPlugin
      {
         _tween.delay(param1);
         return this;
      }
      
      public function onPlay(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onPlay.apply(_tween,rest);
         return this;
      }
      
      public function onDelay(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onDelay.apply(_tween,rest);
         return this;
      }
      
      public function onInit(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onInit.apply(_tween,rest);
         return this;
      }
      
      public function onUpdate(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onUpdate.apply(_tween,rest);
         return this;
      }
      
      public function onPause(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onPause.apply(_tween,rest);
         return this;
      }
      
      public function onStop(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onStop.apply(_tween,rest);
         return this;
      }
      
      public function onComplete(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onComplete.apply(_tween,rest);
         return this;
      }
   }
}

import a24.tween.core.plugins.PluginTween24Property;
import flash.media.SoundMixer;
import flash.media.SoundTransform;

class SoundMixerTween24Property extends PluginTween24Property
{
    
   
   private var _soundTransform:SoundTransform;
   
   private var _volume:Number;
   
   private var _pan:Number;
   
   private var _leftToLeft:Number;
   
   private var _leftToRight:Number;
   
   private var _rightToLeft:Number;
   
   private var _rightToRight:Number;
   
   function SoundMixerTween24Property()
   {
      super();
      _soundTransform = SoundMixer.soundTransform;
      _volume = _soundTransform.volume;
      _pan = _soundTransform.pan;
      _leftToLeft = _soundTransform.leftToLeft;
      _leftToRight = _soundTransform.leftToRight;
      _rightToLeft = _soundTransform.rightToLeft;
      _rightToRight = _soundTransform.rightToRight;
   }
   
   override public function atUpdate() : void
   {
      SoundMixer.soundTransform = _soundTransform;
   }
   
   override public function atComplete() : void
   {
      atUpdate();
   }
   
   public function get volume() : Number
   {
      return _volume;
   }
   
   public function set volume(param1:Number) : void
   {
      _volume = param1;
      _soundTransform.volume = _volume;
   }
   
   public function get pan() : Number
   {
      return _pan;
   }
   
   public function set pan(param1:Number) : void
   {
      _pan = param1;
      _soundTransform.pan = pan;
   }
   
   public function get leftToLeft() : Number
   {
      return _leftToLeft;
   }
   
   public function set leftToLeft(param1:Number) : void
   {
      _leftToLeft = param1;
      if(_soundTransform)
      {
         _soundTransform.leftToLeft = param1;
      }
   }
   
   public function get leftToRight() : Number
   {
      return _leftToRight;
   }
   
   public function set leftToRight(param1:Number) : void
   {
      _leftToRight = param1;
      if(_soundTransform)
      {
         _soundTransform.leftToRight = param1;
      }
   }
   
   public function get rightToLeft() : Number
   {
      return _rightToLeft;
   }
   
   public function set rightToLeft(param1:Number) : void
   {
      _rightToLeft = param1;
      if(_soundTransform)
      {
         _soundTransform.rightToLeft = param1;
      }
   }
   
   public function get rightToRight() : Number
   {
      return _rightToRight;
   }
   
   public function set rightToRight(param1:Number) : void
   {
      _rightToRight = param1;
      if(_soundTransform)
      {
         _soundTransform.rightToRight = param1;
      }
   }
}
