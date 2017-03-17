package connection
{
   import a24.tween.Tween24;
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   
   public class Connector
   {
      
      public static var actionBlockLayer:Sprite = null;
       
      
      public function Connector()
      {
         super();
      }
      
      public static function createTween(param1:Boolean, param2:IEventDispatcher, ... rest) : Tween24
      {
         blockMouseAction = param1;
         eventDispatcher = param2;
         apiConnections = rest;
         var connectionTweens:Array = [];
         var i:int = 0;
         while(i < apiConnections.length)
         {
            if(apiConnections[i] != null)
            {
               if(apiConnections[i] is Class)
               {
                  var api:APIConnectionBase = new apiConnections[i]() as APIConnectionBase;
               }
               else
               {
                  api = apiConnections[i] as APIConnectionBase;
               }
               if(api != null)
               {
                  var t:Tween24 = Tween24.parallel(Tween24.waitEvent(eventDispatcher,APIConnectionBase.COMPLETE),Tween24.func(api.load,eventDispatcher));
                  connectionTweens.push(t);
               }
            }
            i = Number(i) + 1;
         }
         var box:BloackerBox = new BloackerBox#319();
         return Tween24.serial(Tween24.ifCase(blockMouseAction,Tween24.serial(Tween24.prop(box).alpha(0),Tween24.func(function():void
         {
            actionBlockLayer.addChild(box);
         }),Tween24.tween(box,0.2).alpha(0.8))),connectionTweens,Tween24.ifCase(blockMouseAction,Tween24.serial(Tween24.tween(box,0.2).alpha(0),Tween24.func(function():void
         {
            if(box.parent != null)
            {
               box.parent.removeChild(box);
            }
            connectionTweens = null;
         }))));
      }
   }
}

import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

class BloackerBox#319 extends Sprite
{
    
   
   private var _bg:Shape;
   
   private var _arc:Shape;
   
   function BloackerBox#319()
   {
      var _loc4_:int = 0;
      var _loc2_:Number = NaN;
      _bg = new Shape();
      _arc = new Shape();
      super();
      _bg.graphics.beginFill(0,0);
      _bg.graphics.drawRect(0,0,800,480);
      _bg.graphics.endFill();
      var _loc3_:uint = 20;
      var _loc1_:* = 2;
      _loc4_ = 0;
      while(_loc4_ < _loc3_)
      {
         _loc2_ = 90 / _loc3_ * _loc4_;
         _bg.graphics.beginFill(0,Math.cos(_loc2_ * 3.14159265358979 / 180));
         _bg.graphics.drawRect(0,480 - _loc1_ * _loc4_,800,_loc1_);
         _bg.graphics.endFill();
         _loc4_++;
      }
      addChild(_bg);
      _arc.graphics.beginFill(16777215);
      drawPie(_arc.graphics,0,0,3,0,5.49778714378214,false);
      drawPie(_arc.graphics,0,0,9,5.49778714378214,0,true);
      _arc.graphics.endFill();
      _arc.x = 800 - 15;
      _arc.y = 480 - 15;
      addChild(_arc);
   }
   
   override public function addChild(param1:DisplayObject) : DisplayObject
   {
      var _loc2_:DisplayObject = super.addChild(param1);
      addEventListener("enterFrame",_handleEnterFrame);
      return _loc2_;
   }
   
   override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
   {
      var _loc3_:DisplayObject = super.addChildAt(param1,param2);
      addEventListener("enterFrame",_handleEnterFrame);
      return _loc3_;
   }
   
   public function _handleEnterFrame(param1:Event) : void
   {
      if(parent)
      {
         _arc.rotation = _arc.rotation + 10;
      }
      else
      {
         removeEventListener("enterFrame",_handleEnterFrame);
      }
   }
   
   public function drawPie(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean = false) : void
   {
      var _loc14_:* = NaN;
      var _loc12_:* = NaN;
      var _loc11_:* = NaN;
      var _loc15_:int = 0;
      var _loc13_:Number = NaN;
      var _loc10_:Number = NaN;
      var _loc9_:Number = NaN;
      var _loc16_:* = null;
      var _loc8_:int = Math.max(1,Math.floor(Math.abs(param5 - param6) / 0.4));
      _loc15_ = 0;
      while(_loc15_ <= _loc8_)
      {
         _loc13_ = param5 + (param6 - param5) * _loc15_ / _loc8_;
         _loc10_ = Math.cos(_loc13_) * param4 + param2;
         _loc9_ = Math.sin(_loc13_) * param4 + param3;
         if(_loc15_ == 0)
         {
            if(param7)
            {
               param1.lineTo(_loc10_,_loc9_);
            }
            else
            {
               param1.moveTo(_loc10_,_loc9_);
            }
         }
         else
         {
            _loc16_ = getControlPoint(_loc14_,_loc12_,_loc11_ + 3.14159265358979 / 2,_loc10_,_loc9_,_loc13_ + 3.14159265358979 / 2);
            param1.curveTo(_loc16_.x,_loc16_.y,_loc10_,_loc9_);
         }
         _loc14_ = _loc10_;
         _loc12_ = _loc9_;
         _loc11_ = _loc13_;
         _loc15_++;
      }
   }
   
   public function getControlPoint(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Point
   {
      var _loc13_:Number = param4 - param1;
      var _loc11_:Number = param5 - param2;
      var _loc12_:Number = Math.sqrt(_loc13_ * _loc13_ + _loc11_ * _loc11_);
      var _loc7_:Number = Math.atan2(_loc11_,_loc13_);
      var _loc10_:Number = _loc12_ * Math.sin(param6 - _loc7_) / Math.sin(param6 - param3);
      var _loc9_:Number = param1 + _loc10_ * Math.cos(param3);
      var _loc8_:Number = param2 + _loc10_ * Math.sin(param3);
      return new Point(_loc9_,_loc8_);
   }
}
