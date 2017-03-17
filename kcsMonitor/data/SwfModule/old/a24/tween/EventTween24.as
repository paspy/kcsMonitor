package a24.tween
{
   import a24.tween.events.Tween24Event;
   import a24.util.Util24;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class EventTween24
   {
      
      public static const TYPE_NORMAL:String = "normal";
      
      public static const TYPE_STOP:String = "stop";
      
      public static const TYPE_SERIAL:String = "serial";
      
      public static const TYPE_JUMP:String = "jump";
      
      private static const _MOUSE_IN:String = "mouseIn";
      
      private static const _MOUSE_OUTSIDE:String = "mouseOutside";
      
      private static var _eventTween24ByTarget:Dictionary;
       
      
      private var _target;
      
      private var _stage:Stage;
      
      private var _rollOverTween:Tween24;
      
      private var _rollOutTween:Tween24;
      
      private var _mouseOverTween:Tween24;
      
      private var _mouseOutTween:Tween24;
      
      private var _mouseDownTween:Tween24;
      
      private var _mouseUpTween:Tween24;
      
      private var _clickTween:Tween24;
      
      private var _addedToStageTween:Tween24;
      
      private var _removeFromStageTween:Tween24;
      
      private var _syncAddChildTween:Tween24;
      
      private var _syncRemoveChildTween:Tween24;
      
      private var _mouseInTween:Tween24;
      
      private var _mouseOutsideTween:Tween24;
      
      private var _eventTweens:Array;
      
      private var _isRollOver:Boolean;
      
      private var _isMouseOver:Boolean;
      
      private var _isMouseDown:Boolean;
      
      private var _isMouseIn:Boolean;
      
      private var _isMouseOutside:Boolean;
      
      private var _enabled:Boolean;
      
      private var _mouseEventTweenType:String;
      
      private var _duplicateMouseTween:Boolean;
      
      public function EventTween24(param1:*)
      {
         super();
         if(!_eventTween24ByTarget)
         {
            _eventTween24ByTarget = new Dictionary();
         }
         _target = param1;
         _eventTween24ByTarget[_target] = this;
         _enabled = true;
         _mouseEventTweenType = "normal";
         _duplicateMouseTween = true;
         if(_target is DisplayObject)
         {
            if(!_target.stage)
            {
               _target.addEventListener("addedToStage",_onAdded);
            }
            else
            {
               _target.addEventListener("removedFromStage",_onRemoved);
            }
         }
      }
      
      public static function onRollOver(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,"rollOver");
         return _loc3_;
      }
      
      public static function onRollOut(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,"rollOut");
         return _loc3_;
      }
      
      public static function onMouseOver(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,"mouseOver");
         return _loc3_;
      }
      
      public static function onMouseOut(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,"mouseOut");
         return _loc3_;
      }
      
      public static function onMouseDown(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,"mouseDown");
         return _loc3_;
      }
      
      public static function onMouseUp(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,"mouseUp");
         return _loc3_;
      }
      
      public static function onClick(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,"click");
         return _loc3_;
      }
      
      public static function onClickAndGetURL(param1:InteractiveObject, param2:String, param3:String = "_self") : Tween24
      {
         var _loc4_:Tween24 = Tween24.getURL(param2,param3);
         getInstance(param1).setMouseEvent(_loc4_,"click");
         return _loc4_;
      }
      
      public static function onAddedToStage(param1:DisplayObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1)._addedToStageTween = _loc3_;
         return _loc3_;
      }
      
      public static function onRemoveFromStage(param1:DisplayObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1)._removeFromStageTween = _loc3_;
         return _loc3_;
      }
      
      public static function syncAddChild(param1:DisplayObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1)._syncAddChildTween = _loc3_;
         return _loc3_;
      }
      
      public static function syncRemoveChild(param1:DisplayObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1)._syncRemoveChildTween = _loc3_;
         return _loc3_;
      }
      
      public static function onMouseIn(param1:DisplayObject, ... rest) : Tween24
      {
         return getInstance(param1).setMouseEvent(Tween24.serial(rest),"mouseIn");
      }
      
      public static function onMouseOutside(param1:DisplayObject, ... rest) : Tween24
      {
         return getInstance(param1).setMouseEvent(Tween24.serial(rest),"mouseOutside");
      }
      
      public static function onEvent(param1:Object, param2:String, ... rest) : Tween24
      {
         var _loc4_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setEvent(param2,_loc4_);
         return _loc4_;
      }
      
      public static function onEventOnce(param1:Object, param2:String, ... rest) : Tween24
      {
         var _loc4_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setEvent(param2,_loc4_,true);
         return _loc4_;
      }
      
      public static function removeRollOverTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent("rollOver");
      }
      
      public static function removeRollOutTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent("rollOut");
      }
      
      public static function removeMouseOverTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent("mouseOver");
      }
      
      public static function removeMouseOutTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent("mouseOut");
      }
      
      public static function removeMouseDownTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent("mouseDown");
      }
      
      public static function removeMouseUpTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent("mouseUp");
      }
      
      public static function removeClickTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent("click");
      }
      
      public static function removeEventTween(param1:Object, param2:String) : void
      {
         getInstance(param1).setEvent(param2);
      }
      
      public static function enabled(param1:Boolean, ... rest) : void
      {
         var _loc4_:* = null;
         rest = Util24.array.compressAndClean(rest);
         var _loc6_:int = 0;
         var _loc5_:* = rest;
         for each(var _loc3_ in rest)
         {
            _loc4_ = getInstance(_loc3_) || new EventTween24(_loc3_);
            _loc4_.enabled = param1;
            _loc3_.buttonMode = param1;
         }
      }
      
      public static function setMouseEventTweenType(param1:String, ... rest) : void
      {
         var _loc4_:* = null;
         rest = Util24.array.compressAndClean(rest);
         var _loc6_:int = 0;
         var _loc5_:* = rest;
         for each(var _loc3_ in rest)
         {
            _loc4_ = getInstance(_loc3_) || new EventTween24(_loc3_);
            _loc4_._mouseEventTweenType = param1;
         }
      }
      
      public static function dispose(... rest) : void
      {
         var _loc3_:* = null;
         if(!_eventTween24ByTarget)
         {
            return;
         }
         rest = Util24.array.compressAndClean(rest);
         var _loc5_:int = 0;
         var _loc4_:* = rest;
         for each(var _loc2_ in rest)
         {
            _loc3_ = _eventTween24ByTarget[_loc2_];
            if(_loc3_)
            {
               _loc3_.dispose();
            }
         }
      }
      
      public static function disposeFullChildren(... rest) : void
      {
         var _loc4_:* = null;
         if(!_eventTween24ByTarget)
         {
            return;
         }
         rest = Util24.array.compressAndClean(rest);
         var _loc8_:int = 0;
         var _loc7_:* = _eventTween24ByTarget;
         for(var _loc3_ in _eventTween24ByTarget)
         {
            var _loc6_:int = 0;
            var _loc5_:* = rest;
            for each(var _loc2_ in rest)
            {
               if(_loc3_ is DisplayObject)
               {
                  if(_loc2_.contains(DisplayObject(_loc3_)))
                  {
                     _loc4_ = _eventTween24ByTarget[_loc3_];
                     if(_loc4_)
                     {
                        _loc4_.dispose();
                     }
                  }
               }
               _loc4_ = _eventTween24ByTarget[_loc2_];
               if(_loc4_)
               {
                  _loc4_.dispose();
               }
            }
         }
      }
      
      public static function getInstance(param1:Object) : EventTween24
      {
         return !!_eventTween24ByTarget?_eventTween24ByTarget[param1] || new EventTween24(param1):new EventTween24(param1);
      }
      
      public static function hasInstance(param1:Object) : EventTween24
      {
         return !!_eventTween24ByTarget?_eventTween24ByTarget[param1]:null;
      }
      
      private function _onAdded(param1:Event) : void
      {
         _target.removeEventListener("addedToStage",_onAdded);
         _target.addEventListener("removedFromStage",_onRemoved);
         if(_rollOverTween)
         {
            _target.addEventListener("rollOver",onInMouseEvent);
         }
         if(_rollOutTween)
         {
            _target.addEventListener("rollOut",onOutMouseEvent);
         }
         if(_mouseOverTween)
         {
            _target.addEventListener("mouseOver",onInMouseEvent);
         }
         if(_mouseOutTween)
         {
            _target.addEventListener("mouseOut",onOutMouseEvent);
         }
         if(_mouseDownTween)
         {
            _target.addEventListener("mouseDown",onInMouseEvent);
         }
         if(_mouseUpTween)
         {
            _target.addEventListener("mouseUp",onOutMouseEvent);
         }
         if(_clickTween)
         {
            _target.addEventListener("click",_onClick);
         }
         if(_mouseInTween || _mouseOutsideTween)
         {
            _stage = _target.stage;
            _stage.addEventListener("mouseMove",onMouseMove);
         }
         if(_addedToStageTween && _enabled)
         {
            _addedToStageTween.play();
         }
      }
      
      private function _onRemoved(param1:Event) : void
      {
         _target.addEventListener("addedToStage",_onAdded);
         _target.removeEventListener("removedFromStage",_onRemoved);
         _target.removeEventListener("rollOver",onInMouseEvent);
         _target.removeEventListener("rollOut",onOutMouseEvent);
         _target.removeEventListener("mouseOver",onInMouseEvent);
         _target.removeEventListener("mouseOut",onOutMouseEvent);
         _target.removeEventListener("mouseDown",onInMouseEvent);
         _target.removeEventListener("mouseUp",onOutMouseEvent);
         _target.removeEventListener("click",_onClick);
         if(_stage)
         {
            _stage.removeEventListener("mouseMove",onMouseMove);
         }
         if(_addedToStageTween && _enabled)
         {
            _removeFromStageTween.play();
         }
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _eventTweens;
         for(var _loc1_ in _eventTweens)
         {
            _target.removeEventListener(_loc1_,_onEvent);
            _target.removeEventListener(_loc1_,_onEventOnce);
            delete _eventTweens[_loc1_];
         }
         delete _eventTween24ByTarget[_target];
         if(_target is DisplayObject)
         {
            _target.removeEventListener("addedToStage",_onAdded);
            _target.removeEventListener("removedFromStage",_onRemoved);
            _target.removeEventListener("rollOver",onInMouseEvent);
            _target.removeEventListener("rollOut",onOutMouseEvent);
            _target.removeEventListener("mouseOver",onInMouseEvent);
            _target.removeEventListener("mouseOut",onOutMouseEvent);
            _target.removeEventListener("mouseDown",onInMouseEvent);
            _target.removeEventListener("mouseUp",onOutMouseEvent);
            _target.removeEventListener("click",_onClick);
            if(_stage)
            {
               _stage.removeEventListener("mouseMove",onMouseMove);
            }
            _target.buttonMode = false;
         }
         _enabled = false;
         _isRollOver = false;
         _isMouseOver = false;
         _isMouseDown = false;
         _isMouseIn = false;
         _isMouseOutside = false;
         _addedToStageTween = null;
         _removeFromStageTween = null;
         _rollOverTween = null;
         _rollOutTween = null;
         _mouseOverTween = null;
         _mouseOutTween = null;
         _mouseDownTween = null;
         _mouseUpTween = null;
         _mouseInTween = null;
         _mouseOutsideTween = null;
         _clickTween = null;
         _eventTweens = null;
         _mouseEventTweenType = null;
         _stage = null;
         _target = null;
      }
      
      public function setMouseEvent(param1:Tween24, param2:String) : Tween24
      {
         var _loc3_:* = null;
         _target.buttonMode = _enabled;
         if(param2 == "mouseIn" || param2 == "mouseOutside")
         {
            if(param2 == "mouseIn")
            {
               _mouseInTween = param1;
            }
            else
            {
               _mouseOutsideTween = param1;
            }
            if(_target.stage)
            {
               if(!_stage)
               {
                  _stage = _target.stage;
                  _stage.addEventListener("mouseMove",onMouseMove);
               }
            }
         }
         else
         {
            var _loc4_:* = param2;
            if("rollOver" !== _loc4_)
            {
               if("rollOut" !== _loc4_)
               {
                  if("mouseOver" !== _loc4_)
                  {
                     if("mouseOut" !== _loc4_)
                     {
                        if("mouseDown" !== _loc4_)
                        {
                           if("mouseUp" !== _loc4_)
                           {
                              if("click" === _loc4_)
                              {
                                 _clickTween = param1;
                                 _loc3_ = _onClick;
                              }
                           }
                           else
                           {
                              _mouseUpTween = param1;
                              _loc3_ = onOutMouseEvent;
                           }
                        }
                        else
                        {
                           _mouseDownTween = param1;
                           _loc3_ = onInMouseEvent;
                        }
                     }
                     else
                     {
                        _mouseOutTween = param1;
                        _loc3_ = onOutMouseEvent;
                     }
                  }
                  else
                  {
                     _mouseOverTween = param1;
                     _loc3_ = onInMouseEvent;
                  }
               }
               else
               {
                  _rollOutTween = param1;
                  _loc3_ = onOutMouseEvent;
               }
            }
            else
            {
               _rollOverTween = param1;
               _loc3_ = onInMouseEvent;
            }
            if(_target.stage)
            {
               _target.addEventListener(param2,_loc3_);
            }
         }
         return param1;
      }
      
      public function removeMouseEvent(param1:String) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = param1;
         if("rollOver" !== _loc3_)
         {
            if("rollOut" !== _loc3_)
            {
               if("mouseOver" !== _loc3_)
               {
                  if("mouseOut" !== _loc3_)
                  {
                     if("mouseDown" !== _loc3_)
                     {
                        if("mouseUp" !== _loc3_)
                        {
                           if("click" === _loc3_)
                           {
                              _clickTween = null;
                              _loc2_ = _onClick;
                           }
                        }
                        else
                        {
                           _mouseUpTween = null;
                           _loc2_ = onOutMouseEvent;
                        }
                     }
                     else
                     {
                        _mouseDownTween = null;
                        _loc2_ = onInMouseEvent;
                     }
                  }
                  else
                  {
                     _mouseOutTween = null;
                     _loc2_ = onOutMouseEvent;
                  }
               }
               else
               {
                  _mouseOverTween = null;
                  _loc2_ = onInMouseEvent;
               }
            }
            else
            {
               _rollOutTween = null;
               _loc2_ = onOutMouseEvent;
            }
         }
         else
         {
            _rollOverTween = null;
            _loc2_ = onInMouseEvent;
         }
         if(!_rollOverTween && !_rollOutTween && !_mouseOverTween && !_mouseOutTween && !_mouseDownTween && !_mouseUpTween && !_clickTween)
         {
            _target.buttonMode = false;
         }
         if(_target.stage)
         {
            _target.removeEventListener(param1,_loc2_);
         }
      }
      
      private function onInMouseEvent(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(!_enabled)
         {
            return;
         }
         var _loc4_:* = param1.type;
         if("rollOver" !== _loc4_)
         {
            if("mouseOver" !== _loc4_)
            {
               if("mouseDown" === _loc4_)
               {
                  _loc3_ = _mouseDownTween;
                  _loc2_ = _mouseUpTween;
                  _isMouseDown = true;
               }
            }
            else
            {
               _loc3_ = _mouseOverTween;
               _loc2_ = _mouseOutTween;
               _isMouseOver = true;
            }
         }
         else
         {
            _loc3_ = _rollOverTween;
            _loc2_ = _rollOutTween;
            _isRollOver = true;
         }
         if(!_duplicateMouseTween && _loc3_.playing)
         {
            return;
         }
         if((_mouseEventTweenType == "stop" || _mouseEventTweenType == "serial") && _loc2_)
         {
            _loc2_.stop();
         }
         if(_loc3_.playing)
         {
            _loc3_.stop();
            _loc3_.removeEventListener("complete",onInTweenComplete);
         }
         _loc3_.play();
      }
      
      private function onOutMouseEvent(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(!_enabled)
         {
            return;
         }
         var _loc4_:* = param1.type;
         if("rollOut" !== _loc4_)
         {
            if("mouseOut" !== _loc4_)
            {
               if("mouseUp" === _loc4_)
               {
                  _loc3_ = _mouseDownTween;
                  _loc2_ = _mouseUpTween;
                  _isMouseDown = false;
               }
            }
            else
            {
               _loc3_ = _mouseOverTween;
               _loc2_ = _mouseOutTween;
               _isMouseOver = false;
            }
         }
         else
         {
            _loc3_ = _rollOverTween;
            _loc2_ = _rollOutTween;
            _isRollOver = false;
         }
         if(_mouseEventTweenType == "stop" && _loc3_)
         {
            _loc3_.stop();
            _loc2_.play();
         }
         else if(_mouseEventTweenType == "serial" && _loc3_ && _loc3_.playing)
         {
            _loc3_.addEventListener("complete",onInTweenComplete);
         }
         else if(_mouseEventTweenType == "jump" && _loc3_ && _loc3_.playing)
         {
            _loc3_.addEventListener("complete",onInTweenComplete);
            _loc3_.skip();
         }
         else
         {
            if(_loc2_.playing)
            {
               _loc2_.stop();
            }
            _loc2_.play();
         }
      }
      
      private function onInTweenComplete(param1:Tween24Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = param1.tween;
         if(_rollOverTween !== _loc4_)
         {
            if(_mouseOverTween !== _loc4_)
            {
               if(_mouseDownTween === _loc4_)
               {
                  _loc3_ = _mouseDownTween;
                  _loc2_ = _mouseUpTween;
               }
            }
            else
            {
               _loc3_ = _mouseOverTween;
               _loc2_ = _mouseOutTween;
            }
         }
         else
         {
            _loc3_ = _rollOverTween;
            _loc2_ = _rollOutTween;
         }
         if(_loc3_)
         {
            _loc3_.removeEventListener("complete",onInTweenComplete);
         }
         if(_loc2_)
         {
            if(_loc2_.playing)
            {
               _loc2_.stop();
            }
            _loc2_.play();
         }
      }
      
      private function _onClick(param1:MouseEvent) : void
      {
         if(!_enabled)
         {
            return;
         }
         if(_clickTween.playing)
         {
            _clickTween.stop();
         }
         _clickTween.play();
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = _target as DisplayObject;
         var _loc3_:Rectangle = _loc2_.getBounds(_loc2_);
         if(_loc3_.contains(_loc2_.mouseX,_loc2_.mouseY))
         {
            _isMouseOutside = false;
            if(!_isMouseIn)
            {
               _isMouseIn = true;
               if(_mouseInTween)
               {
                  _mouseInTween.play();
               }
            }
         }
         else
         {
            if(_isMouseIn && !_isMouseOutside)
            {
               _isMouseOutside = true;
               if(_mouseOutsideTween)
               {
                  _mouseOutsideTween.play();
               }
            }
            _isMouseIn = false;
         }
      }
      
      public function setEvent(param1:String, param2:Tween24 = null, param3:Boolean = false) : void
      {
         if(!_eventTweens)
         {
            _eventTweens = [];
         }
         _eventTweens[param1] = param2;
         if(param2)
         {
            _target.addEventListener(param1,!!param3?_onEventOnce:_onEvent);
         }
         else
         {
            _target.removeEventListener(param1,!!param3?_onEventOnce:_onEvent);
         }
      }
      
      private function _onEvent(param1:*) : void
      {
         if(!_enabled)
         {
            return;
         }
         var _loc2_:Tween24 = _eventTweens[param1.type];
         if(_loc2_.playing)
         {
            _loc2_.stop();
         }
         _loc2_.play();
      }
      
      private function _onEventOnce(param1:*) : void
      {
         if(!_enabled)
         {
            return;
         }
         _target.removeEventListener(param1.type,_onEventOnce);
         var _loc2_:Tween24 = _eventTweens[param1.type];
         if(_loc2_.playing)
         {
            _loc2_.stop();
         }
         _loc2_.play();
      }
      
      public function get target() : Object
      {
         return _target;
      }
      
      public function get rollOverTween() : Tween24
      {
         return _rollOverTween;
      }
      
      public function get rollOutTween() : Tween24
      {
         return _rollOutTween;
      }
      
      public function get mouseOverTween() : Tween24
      {
         return _mouseOverTween;
      }
      
      public function get mouseOutTween() : Tween24
      {
         return _mouseOutTween;
      }
      
      public function get mouseDownTween() : Tween24
      {
         return _mouseDownTween;
      }
      
      public function get mouseUpTween() : Tween24
      {
         return _mouseUpTween;
      }
      
      public function get clickTween() : Tween24
      {
         return _clickTween;
      }
      
      public function get addedToStageTween() : Tween24
      {
         return _addedToStageTween;
      }
      
      public function get removeFromStageTween() : Tween24
      {
         return _removeFromStageTween;
      }
      
      public function get addChildSyncTween() : Tween24
      {
         return _syncAddChildTween;
      }
      
      public function get removeChildSyncTween() : Tween24
      {
         return _syncRemoveChildTween;
      }
      
      public function get isRollOver() : Boolean
      {
         return _isRollOver;
      }
      
      public function get isMouseOver() : Boolean
      {
         return _isMouseOver;
      }
      
      public function get isMouseDown() : Boolean
      {
         return _isMouseDown;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         _enabled = param1;
      }
      
      public function get mouseEventTweenType() : String
      {
         return _mouseEventTweenType;
      }
      
      public function set mouseEventTweenType(param1:String) : void
      {
         _mouseEventTweenType = param1;
      }
      
      public function get duplicateMouseTween() : Boolean
      {
         return _duplicateMouseTween;
      }
      
      public function set duplicateMouseTween(param1:Boolean) : void
      {
         _duplicateMouseTween = param1;
      }
   }
}
