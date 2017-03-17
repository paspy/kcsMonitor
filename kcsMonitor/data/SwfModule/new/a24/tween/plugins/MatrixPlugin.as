package a24.tween.plugins
{
   import a24.tween.core.plugins.PulginTween24;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   
   public class MatrixPlugin extends PulginTween24
   {
      
      private static var _properties:Dictionary;
       
      
      private var _property:MatrixTween24Property;
      
      public function MatrixPlugin(param1:MatrixTween24Property)
      {
         super();
         _property = param1;
      }
      
      public static function tween(param1:DisplayObject, param2:Number, param3:Function = null) : MatrixPlugin
      {
         if(!_properties)
         {
            _properties = new Dictionary();
         }
         var _loc5_:* = param1;
         _properties[_loc5_] = _properties[_loc5_] || new MatrixTween24Property(param1);
         var _loc4_:MatrixPlugin = new MatrixPlugin(_properties[param1]);
         _loc4_.setTween(_loc4_._property,param2,param3);
         return _loc4_;
      }
      
      public static function prop(param1:DisplayObject) : MatrixPlugin
      {
         if(!_properties)
         {
            _properties = new Dictionary();
         }
         var _loc3_:* = param1;
         _properties[_loc3_] = _properties[_loc3_] || new MatrixTween24Property(param1);
         var _loc2_:MatrixPlugin = new MatrixPlugin(_properties[param1]);
         _loc2_.setProp(_loc2_._property);
         return _loc2_;
      }
      
      public function a(param1:Number) : MatrixPlugin
      {
         addParam("a",param1);
         return this;
      }
      
      public function b(param1:Number) : MatrixPlugin
      {
         addParam("b",param1);
         return this;
      }
      
      public function c(param1:Number) : MatrixPlugin
      {
         addParam("c",param1);
         return this;
      }
      
      public function d(param1:Number) : MatrixPlugin
      {
         addParam("d",param1);
         return this;
      }
      
      public function tx(param1:Number) : MatrixPlugin
      {
         addParam("tx",param1);
         return this;
      }
      
      public function ty(param1:Number) : MatrixPlugin
      {
         addParam("ty",param1);
         return this;
      }
      
      public function skewX(param1:Number) : MatrixPlugin
      {
         addParam("c",param1);
         return this;
      }
      
      public function skewY(param1:Number) : MatrixPlugin
      {
         addParam("b",param1);
         return this;
      }
      
      public function scaleX(param1:Number) : MatrixPlugin
      {
         addParam("a",param1);
         return this;
      }
      
      public function scaleY(param1:Number) : MatrixPlugin
      {
         addParam("d",param1);
         return this;
      }
      
      public function $a(param1:Number) : MatrixPlugin
      {
         addParam("$a",param1);
         return this;
      }
      
      public function $b(param1:Number) : MatrixPlugin
      {
         addParam("$b",param1);
         return this;
      }
      
      public function $c(param1:Number) : MatrixPlugin
      {
         addParam("$c",param1);
         return this;
      }
      
      public function $d(param1:Number) : MatrixPlugin
      {
         addParam("$d",param1);
         return this;
      }
      
      public function $tx(param1:Number) : MatrixPlugin
      {
         addParam("$tx",param1);
         return this;
      }
      
      public function $ty(param1:Number) : MatrixPlugin
      {
         addParam("$ty",param1);
         return this;
      }
      
      public function $skewX(param1:Number) : MatrixPlugin
      {
         addParam("$c",param1);
         return this;
      }
      
      public function $skewY(param1:Number) : MatrixPlugin
      {
         addParam("$b",param1);
         return this;
      }
      
      public function $scaleX(param1:Number) : MatrixPlugin
      {
         addParam("$a",param1);
         return this;
      }
      
      public function $scaleY(param1:Number) : MatrixPlugin
      {
         addParam("$d",param1);
         return this;
      }
      
      public function $$a(param1:Number) : MatrixPlugin
      {
         addParam("$$a",param1);
         return this;
      }
      
      public function $$b(param1:Number) : MatrixPlugin
      {
         addParam("$$b",param1);
         return this;
      }
      
      public function $$c(param1:Number) : MatrixPlugin
      {
         addParam("$$c",param1);
         return this;
      }
      
      public function $$d(param1:Number) : MatrixPlugin
      {
         addParam("$$d",param1);
         return this;
      }
      
      public function $$tx(param1:Number) : MatrixPlugin
      {
         addParam("$$tx",param1);
         return this;
      }
      
      public function $$ty(param1:Number) : MatrixPlugin
      {
         addParam("$$ty",param1);
         return this;
      }
      
      public function $$skewX(param1:Number) : MatrixPlugin
      {
         addParam("$$c",param1);
         return this;
      }
      
      public function $$skewY(param1:Number) : MatrixPlugin
      {
         addParam("$$b",param1);
         return this;
      }
      
      public function $$scaleX(param1:Number) : MatrixPlugin
      {
         addParam("$$a",param1);
         return this;
      }
      
      public function $$scaleY(param1:Number) : MatrixPlugin
      {
         addParam("$$d",param1);
         return this;
      }
      
      public function delay(param1:Number) : MatrixPlugin
      {
         _tween.delay(param1);
         return this;
      }
      
      public function onPlay(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onPlay.apply(_tween,rest);
         return this;
      }
      
      public function onDelay(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onDelay.apply(_tween,rest);
         return this;
      }
      
      public function onInit(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onInit.apply(_tween,rest);
         return this;
      }
      
      public function onUpdate(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onUpdate.apply(_tween,rest);
         return this;
      }
      
      public function onPause(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onPause.apply(_tween,rest);
         return this;
      }
      
      public function onStop(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onStop.apply(_tween,rest);
         return this;
      }
      
      public function onComplete(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onComplete.apply(_tween,rest);
         return this;
      }
   }
}

import a24.tween.core.plugins.PluginTween24Property;
import flash.display.DisplayObject;
import flash.geom.Matrix;

class MatrixTween24Property extends PluginTween24Property
{
    
   
   private var _target:DisplayObject;
   
   private var _matrix:Matrix;
   
   private var _a:Number;
   
   private var _b:Number;
   
   private var _c:Number;
   
   private var _d:Number;
   
   private var _tx:Number;
   
   private var _ty:Number;
   
   function MatrixTween24Property(param1:DisplayObject)
   {
      super();
      _target = param1;
      _name = _target.name;
   }
   
   override public function atInit() : void
   {
      _matrix = _target.transform.matrix;
      _a = _matrix.a;
      _b = _matrix.b;
      _c = _matrix.c;
      _d = _matrix.d;
      _tx = _matrix.tx;
      _ty = _matrix.ty;
   }
   
   override public function atUpdate() : void
   {
      _target.transform.matrix = _matrix;
   }
   
   override public function atComplete() : void
   {
      atUpdate();
   }
   
   public function get a() : Number
   {
      return _a;
   }
   
   public function set a(param1:Number) : void
   {
      var _loc2_:* = param1;
      _matrix.a = _loc2_;
      _a = _loc2_;
   }
   
   public function get b() : Number
   {
      return _b;
   }
   
   public function set b(param1:Number) : void
   {
      var _loc2_:* = param1;
      _matrix.b = _loc2_;
      _b = _loc2_;
   }
   
   public function get c() : Number
   {
      return _c;
   }
   
   public function set c(param1:Number) : void
   {
      var _loc2_:* = param1;
      _matrix.c = _loc2_;
      _c = _loc2_;
   }
   
   public function get d() : Number
   {
      return _d;
   }
   
   public function set d(param1:Number) : void
   {
      var _loc2_:* = param1;
      _matrix.d = _loc2_;
      _d = _loc2_;
   }
   
   public function get tx() : Number
   {
      return _tx;
   }
   
   public function set tx(param1:Number) : void
   {
      var _loc2_:* = param1;
      _matrix.tx = _loc2_;
      _tx = _loc2_;
   }
   
   public function get ty() : Number
   {
      return _ty;
   }
   
   public function set ty(param1:Number) : void
   {
      var _loc2_:* = param1;
      _matrix.ty = _loc2_;
      _ty = _loc2_;
   }
}
