package common.display
{
   import common.util.Util;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Rectangle;
   
   public class DisplayUtil
   {
       
      
      public function DisplayUtil()
      {
         super();
      }
      
      public static function setButtonMode(param1:MovieClip, param2:Function = null) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         param1.buttonMode = true;
         param1.gotoAndStop(4);
         if(param1.numChildren)
         {
            _loc3_ = param1.getChildAt(0);
            _loc4_ = new HitArea();
            _loc4_.graphics.beginFill(0,0);
            _loc5_ = _loc3_.getRect(param1);
            _loc4_.graphics.drawRect(_loc5_.x,_loc5_.y,_loc5_.width,_loc5_.height);
            _loc4_.graphics.endFill();
            param1.addChild(_loc4_);
            param1.hitArea = _loc4_;
         }
         param1.gotoAndStop(1);
         param1.addEventListener("rollOver",_handleRollOver);
         param1.addEventListener("rollOut",_handleRollOut);
         param1.addEventListener("mouseDown",_handleMouseDown);
         param1.addEventListener("mouseUp",_handleMouseUp);
         if(param2 != null)
         {
            param1.addEventListener("click",param2);
         }
      }
      
      public static function unsetButtonMode(param1:MovieClip, param2:Function = null) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         param1.buttonMode = false;
         param1.gotoAndStop(4);
         _loc4_ = 0;
         while(_loc4_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc4_);
            if(_loc3_ is HitArea)
            {
               param1.removeChild(_loc3_);
            }
            _loc4_++;
         }
         param1.gotoAndStop(1);
         param1.removeEventListener("rollOver",_handleRollOver);
         param1.removeEventListener("rollOut",_handleRollOut);
         param1.removeEventListener("mouseDown",_handleMouseDown);
         param1.removeEventListener("mouseUp",_handleMouseUp);
         if(param2 != null)
         {
            param1.removeEventListener("click",param2);
         }
      }
      
      public static function _handleRollOver(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(2);
      }
      
      public static function _handleRollOut(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(1);
      }
      
      public static function _handleMouseDown(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(3);
      }
      
      public static function _handleMouseUp(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(2);
      }
      
      public static function getNameColor(param1:int) : int
      {
         var _loc2_:int = 0;
         if(Util.isMarriaged(param1))
         {
            _loc2_ = 16766947;
         }
         else
         {
            _loc2_ = 16774898;
         }
         return _loc2_;
      }
      
      public static function setEnabled(param1:MovieClip, param2:Boolean) : void
      {
         var _loc3_:* = null;
         param1.enabled = param2;
         param1.mouseEnabled = param2;
         param1.mouseChildren = false;
         if(!param2)
         {
            if(param1.filters && param1.filters.length > 0)
            {
               throw new Error("Error DisplayUtil::setEnabled(false) - " + param1.name);
            }
            _loc3_ = [];
            _loc3_ = _loc3_.concat([0.333333333333333,0.333333333333333,0.333333333333333,0,0]);
            _loc3_ = _loc3_.concat([0.333333333333333,0.333333333333333,0.333333333333333,0,0]);
            _loc3_ = _loc3_.concat([0.333333333333333,0.333333333333333,0.333333333333333,0,0]);
            _loc3_ = _loc3_.concat([0,0,0,1,0]);
            param1.filters = [new ColorMatrixFilter(_loc3_)];
         }
         else if(!param1.filters || param1.filters.length == 1 && param1.filters[0] is ColorMatrixFilter)
         {
            param1.filters = null;
         }
         else
         {
            throw new Error("Error DisplayUtil::setEnabled(true) - " + param1.name);
         }
      }
   }
}

import flash.display.Sprite;

class HitArea extends Sprite
{
    
   
   function HitArea()
   {
      super();
   }
}
