package a24.tween.plugins
{
   import a24.tween.Tween24;
   import a24.tween.core.plugins.PulginTween24;
   import flash.media.Sound;
   import flash.media.SoundTransform;
   
   public class SoundPlugin extends PulginTween24
   {
      
      private static var _properties:Array;
       
      
      private var _property:SoundTween24Property;
      
      public function SoundPlugin(param1:SoundTween24Property)
      {
         super();
         _property = param1;
      }
      
      public static function addSound(param1:String, param2:Sound, param3:Number = 1) : void
      {
         if(!_properties)
         {
            _properties = [];
         }
         _properties[param1] = new SoundTween24Property(param1,param2,param3);
      }
      
      public static function removeSound(param1:String) : void
      {
         var _loc2_:* = null;
         if(_properties)
         {
            _loc2_ = _properties[param1];
            if(_loc2_)
            {
               _loc2_.dispose();
            }
            delete _properties[param1];
         }
      }
      
      public static function tween(param1:String, param2:Number, param3:Function = null) : SoundPlugin
      {
         var _loc4_:SoundPlugin = new SoundPlugin(_properties[param1]);
         _loc4_.setTween(_loc4_._property,param2,param3);
         return _loc4_;
      }
      
      public static function prop(param1:String) : SoundPlugin
      {
         var _loc2_:SoundPlugin = new SoundPlugin(_properties[param1]);
         _loc2_.setProp(_loc2_._property);
         return _loc2_;
      }
      
      public static function playSound(param1:String, param2:Number = 0, param3:int = 0, param4:SoundTransform = null) : SoundPlugin
      {
         var _loc5_:SoundPlugin = new SoundPlugin(_properties[param1]);
         _loc5_._tween = Tween24.func(_loc5_._property.play,param2,param3,param4);
         return _loc5_;
      }
      
      public static function stopSound(param1:String) : SoundPlugin
      {
         var _loc2_:SoundPlugin = new SoundPlugin(_properties[param1]);
         _loc2_._tween = Tween24.func(_loc2_._property.stop);
         return _loc2_;
      }
      
      public function volume(param1:Number) : SoundPlugin
      {
         addParam("volume",param1);
         return this;
      }
      
      public function pan(param1:Number) : SoundPlugin
      {
         addParam("pan",param1);
         return this;
      }
      
      public function leftToLeft(param1:Number) : SoundPlugin
      {
         addParam("leftToLeft",param1);
         return this;
      }
      
      public function leftToRight(param1:Number) : SoundPlugin
      {
         addParam("leftToRight",param1);
         return this;
      }
      
      public function rightToLeft(param1:Number) : SoundPlugin
      {
         addParam("rightToLeft",param1);
         return this;
      }
      
      public function rightToRight(param1:Number) : SoundPlugin
      {
         addParam("rightToRight",param1);
         return this;
      }
      
      public function delay(param1:Number) : SoundPlugin
      {
         _tween.delay(param1);
         return this;
      }
      
      public function onPlay(param1:Function, ... rest) : SoundPlugin
      {
         rest.unshift(param1);
         _tween.onPlay.apply(_tween,rest);
         return this;
      }
      
      public function onDelay(param1:Function, ... rest) : SoundPlugin
      {
         rest.unshift(param1);
         _tween.onDelay.apply(_tween,rest);
         return this;
      }
      
      public function onInit(param1:Function, ... rest) : SoundPlugin
      {
         rest.unshift(param1);
         _tween.onInit.apply(_tween,rest);
         return this;
      }
      
      public function onUpdate(param1:Function, ... rest) : SoundPlugin
      {
         rest.unshift(param1);
         _tween.onUpdate.apply(_tween,rest);
         return this;
      }
      
      public function onPause(param1:Function, ... rest) : SoundPlugin
      {
         rest.unshift(param1);
         _tween.onPause.apply(_tween,rest);
         return this;
      }
      
      public function onStop(param1:Function, ... rest) : SoundPlugin
      {
         rest.unshift(param1);
         _tween.onStop.apply(_tween,rest);
         return this;
      }
      
      public function onComplete(param1:Function, ... rest) : SoundPlugin
      {
         rest.unshift(param1);
         _tween.onComplete.apply(_tween,rest);
         return this;
      }
   }
}

import a24.tween.core.plugins.PluginTween24Property;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

class SoundTween24Property extends PluginTween24Property
{
    
   
   private var _id:String;
   
   private var _sound:Sound;
   
   private var _soundChannel:SoundChannel;
   
   private var _soundTransform:SoundTransform;
   
   private var _defaultVolume:Number;
   
   private var _volume:Number;
   
   private var _pan:Number;
   
   private var _leftToLeft:Number;
   
   private var _leftToRight:Number;
   
   private var _rightToLeft:Number;
   
   private var _rightToRight:Number;
   
   function SoundTween24Property(param1:String, param2:Sound, param3:Number = 1)
   {
      super();
      _id = param1;
      _sound = param2;
      _defaultVolume = param3;
   }
   
   public function play(param1:Number = 0, param2:int = 0, param3:SoundTransform = null) : void
   {
      if(_soundChannel)
      {
         _soundChannel.stop();
      }
      _soundChannel = _sound.play(param1,param2,param3);
      if(!_soundTransform)
      {
         _soundTransform = _soundChannel.soundTransform;
      }
      if(isNaN(_volume))
      {
         _volume = _soundTransform.volume;
      }
      if(isNaN(_pan))
      {
         _pan = _soundTransform.pan;
      }
      if(isNaN(_leftToLeft))
      {
         _leftToLeft = _soundTransform.leftToLeft;
      }
      if(isNaN(_leftToRight))
      {
         _leftToRight = _soundTransform.leftToRight;
      }
      if(isNaN(_rightToLeft))
      {
         _rightToLeft = _soundTransform.rightToLeft;
      }
      if(isNaN(_rightToRight))
      {
         _rightToRight = _soundTransform.rightToRight;
      }
      _soundTransform.volume = _volume * _defaultVolume;
      _soundChannel.soundTransform = _soundTransform;
   }
   
   public function stop() : void
   {
      if(_soundChannel)
      {
         _soundChannel.stop();
      }
   }
   
   public function dispose() : void
   {
      _id = null;
      _sound = null;
      _soundChannel = null;
      _soundTransform = null;
      _defaultVolume = NaN;
      _volume = NaN;
      _pan = NaN;
      _leftToLeft = NaN;
      _leftToRight = NaN;
      _rightToLeft = NaN;
      _rightToRight = NaN;
   }
   
   override public function atUpdate() : void
   {
      if(_soundChannel)
      {
         _soundChannel.soundTransform = _soundTransform;
      }
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
      if(_soundTransform)
      {
         _soundTransform.volume = param1 * _defaultVolume;
      }
   }
   
   public function get pan() : Number
   {
      return _pan;
   }
   
   public function set pan(param1:Number) : void
   {
      _pan = param1;
      if(_soundTransform)
      {
         _soundTransform.pan = param1;
      }
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
