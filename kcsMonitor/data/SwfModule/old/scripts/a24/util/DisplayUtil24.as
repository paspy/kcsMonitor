package a24.util
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.Sprite;
   
   public final class DisplayUtil24
   {
       
      
      public function DisplayUtil24()
      {
         super();
      }
      
      public function addChild(param1:DisplayObjectContainer, ... rest) : void
      {
         rest = Util24.array.compressAndClean(rest);
         if(param1)
         {
            var _loc5_:int = 0;
            var _loc4_:* = rest;
            for each(var _loc3_ in rest)
            {
               param1.addChild(_loc3_);
            }
         }
      }
      
      public function addChildAt(param1:DisplayObjectContainer, param2:DisplayObject, param3:int) : void
      {
         if(param1 && param2)
         {
            param1.addChildAt(param2,param3);
         }
      }
      
      public function addChildAtFront(param1:DisplayObject, param2:DisplayObject) : void
      {
         var _loc3_:DisplayObjectContainer = param2.parent;
         if(_loc3_ && param1 && param2)
         {
            _loc3_.addChildAt(param1,_loc3_.getChildIndex(param2) + 1);
         }
      }
      
      public function addChildAtBack(param1:DisplayObject, param2:DisplayObject) : void
      {
         var _loc3_:DisplayObjectContainer = param2.parent;
         if(_loc3_ && param2 && param1)
         {
            _loc3_.addChildAt(param1,_loc3_.getChildIndex(param2));
         }
      }
      
      public function addChildAndReplace(param1:DisplayObjectContainer, param2:DisplayObject) : DisplayObjectContainer
      {
         param1.x = param2.x;
         param1.y = param2.y;
         param2.x = 0;
         param2.y = 0;
         if(param2.parent)
         {
            param2.parent.addChild(param1);
         }
         param1.addChild(param2);
         return param1;
      }
      
      public function removeChild(... rest) : void
      {
         var _loc3_:* = null;
         rest = Util24.array.compressAndClean(rest);
         var _loc5_:int = 0;
         var _loc4_:* = rest;
         for each(var _loc2_ in rest)
         {
            _loc3_ = _loc2_.parent;
            if(_loc2_.parent != null)
            {
               _loc3_.removeChild(_loc2_);
            }
         }
      }
      
      public function removeChildByName(param1:DisplayObjectContainer, ... rest) : void
      {
         var _loc3_:* = null;
         rest = Util24.array.compressAndClean(rest);
         var _loc6_:int = 0;
         var _loc5_:* = rest;
         for each(var _loc4_ in rest)
         {
            _loc3_ = param1.getChildByName(_loc4_);
            if(param1.getChildByName(_loc4_) != null)
            {
               param1.removeChild(_loc3_);
            }
         }
      }
      
      public function removeChildAt(param1:DisplayObjectContainer, ... rest) : void
      {
         var _loc3_:* = null;
         rest = Util24.array.compressAndClean(rest);
         var _loc4_:Array = [];
         var _loc9_:int = 0;
         var _loc8_:* = rest;
         for each(var _loc5_ in rest)
         {
            try
            {
               _loc3_ = param1.getChildAt(_loc5_);
               _loc4_.push(_loc3_);
            }
            catch(e:Error)
            {
               continue;
            }
         }
         var _loc11_:int = 0;
         var _loc10_:* = _loc4_;
         for each(_loc3_ in _loc4_)
         {
            param1.removeChild(_loc3_);
         }
      }
      
      public function removeAllChildren(... rest) : void
      {
         var _loc2_:* = null;
         rest = Util24.array.compressAndClean(rest);
         var _loc5_:int = 0;
         var _loc4_:* = rest;
         for each(var _loc3_ in rest)
         {
            while(_loc3_.numChildren)
            {
               _loc2_ = _loc3_.getChildAt(0);
               if(_loc2_)
               {
                  _loc3_.removeChildAt(0);
                  continue;
               }
               break;
            }
         }
      }
      
      public function removeFullChildren(... rest) : void
      {
         var _loc2_:* = null;
         rest = Util24.array.compressAndClean(rest);
         var _loc5_:int = 0;
         var _loc4_:* = rest;
         for each(var _loc3_ in rest)
         {
            if(!(_loc3_ is Loader))
            {
               while(_loc3_.numChildren)
               {
                  _loc2_ = _loc3_.getChildAt(0);
                  if(_loc2_)
                  {
                     _loc3_.removeChildAt(0);
                     if(_loc2_ is DisplayObjectContainer)
                     {
                        removeFullChildren(_loc2_);
                     }
                     continue;
                  }
                  break;
               }
               continue;
            }
         }
      }
      
      public function getChildrenAt(param1:DisplayObjectContainer, ... rest) : Array
      {
         var _loc3_:* = null;
         rest = Util24.array.compressAndClean(rest);
         var _loc5_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = rest;
         for each(var _loc4_ in rest)
         {
            _loc3_ = param1.getChildAt(_loc4_);
            if(param1.getChildAt(_loc4_) != null)
            {
               _loc5_.push(_loc3_);
            }
         }
         return _loc5_;
      }
      
      public function getChildrenByName(param1:DisplayObjectContainer, ... rest) : Array
      {
         var _loc3_:* = null;
         rest = Util24.array.compressAndClean(rest);
         var _loc5_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = rest;
         for each(var _loc4_ in rest)
         {
            _loc3_ = param1.getChildByName(_loc4_);
            if(param1.getChildByName(_loc4_) != null)
            {
               _loc5_.push(_loc3_);
            }
         }
         return _loc5_;
      }
      
      public function getChildrenSearchName(param1:DisplayObjectContainer, param2:String) : Array
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc4_:Array = [];
         var _loc5_:int = param1.numChildren;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = param1.getChildAt(_loc6_);
            if(_loc3_.name.indexOf(param2) > -1)
            {
               _loc4_.push(_loc3_);
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function getAllChildren(... rest) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         rest = Util24.array.compressAndClean(rest);
         var _loc3_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = rest;
         for each(var _loc2_ in rest)
         {
            _loc4_ = _loc2_.numChildren;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc3_.push(_loc2_.getChildAt(_loc5_));
               _loc5_++;
            }
         }
         return _loc3_;
      }
      
      public function setFrontChild(param1:DisplayObject) : void
      {
         var _loc2_:DisplayObjectContainer = param1.parent;
         if(_loc2_ && param1)
         {
            _loc2_.setChildIndex(param1,_loc2_.numChildren - 1);
         }
      }
      
      public function setChildIndex(param1:DisplayObject, param2:uint) : void
      {
         var _loc3_:DisplayObjectContainer = param1.parent;
         if(_loc3_ && param1)
         {
            _loc3_.setChildIndex(param1,param2);
         }
      }
      
      public function replaceChild(param1:DisplayObject, param2:DisplayObject) : DisplayObject
      {
         var _loc3_:DisplayObjectContainer = param1.parent;
         if(_loc3_)
         {
            param2.x = param1.x;
            param2.y = param1.y;
            _loc3_.addChildAt(param2,_loc3_.getChildIndex(param1));
            _loc3_.removeChild(param1);
         }
         return param2;
      }
      
      public function addMask(param1:DisplayObject, param2:DisplayObject) : void
      {
         var _loc3_:DisplayObjectContainer = param1.parent;
         param1.mask = param2;
         if(_loc3_ && _loc3_ != param2.parent)
         {
            _loc3_.addChild(param2);
         }
      }
      
      public function removeMask(param1:DisplayObject) : void
      {
         var _loc3_:DisplayObject = param1.mask;
         var _loc2_:DisplayObjectContainer = _loc3_.parent;
         if(_loc3_)
         {
            if(_loc2_)
            {
               _loc2_.removeChild(_loc3_);
            }
            param1.mask = null;
         }
      }
      
      public function removeFilters(... rest) : void
      {
         rest = Util24.array.compressAndClean(rest);
         var _loc4_:int = 0;
         var _loc3_:* = rest;
         for each(var _loc2_ in rest)
         {
            if(_loc2_.filters)
            {
               _loc2_.filters = null;
            }
         }
      }
      
      public function addRectHitArea(param1:Sprite, param2:DisplayObjectContainer = null, param3:Object = null, param4:Boolean = false) : Sprite
      {
         var _loc5_:Sprite = new Sprite();
         if(!param3)
         {
            param3 = param1;
         }
         if(!param2)
         {
            param2 = param1;
         }
         Util24.graphics.drawRectHitArea(_loc5_,param3,param4);
         param1.mouseChildren = false;
         param1.hitArea = _loc5_;
         if(param2 != param1 && param2.contains(param1))
         {
            _loc5_.x = param1.x;
            _loc5_.y = param1.y;
         }
         param2.addChild(_loc5_);
         return _loc5_;
      }
      
      public function addCircleHitArea(param1:Sprite, param2:Object = null, param3:Boolean = false) : Sprite
      {
         if(!param2)
         {
            param2 = param1;
         }
         var _loc4_:Sprite = new Sprite();
         Util24.graphics.drawCircleHitArea(_loc4_,param2,param3);
         param1.mouseChildren = false;
         param1.hitArea = _loc4_;
         param1.addChild(_loc4_);
         return _loc4_;
      }
      
      public function resizeRatio(param1:DisplayObject, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = param2 / (param1.width / param1.scaleX);
         var _loc5_:Number = param3 / (param1.height / param1.scaleY);
         var _loc6_:* = _loc4_ < _loc5_?_loc4_:Number(_loc5_);
         param1.scaleY = _loc6_;
         param1.scaleX = _loc6_;
      }
      
      public function getLocalX(param1:DisplayObject, param2:Number) : Number
      {
         var _loc5_:int = 0;
         var _loc4_:DisplayObject = param1.parent;
         var _loc3_:Array = [];
         while(_loc4_)
         {
            _loc3_.push(_loc4_);
            _loc4_ = _loc4_.parent;
         }
         _loc5_ = _loc3_.length - 1;
         while(_loc5_ >= 0)
         {
            _loc4_ = _loc3_[_loc5_];
            param2 = (param2 - _loc4_.x) / _loc4_.scaleX;
            _loc5_--;
         }
         return param2;
      }
      
      public function getLocalY(param1:DisplayObject, param2:Number) : Number
      {
         var _loc5_:int = 0;
         var _loc4_:DisplayObject = param1.parent;
         var _loc3_:Array = [];
         while(_loc4_)
         {
            _loc3_.push(_loc4_);
            _loc4_ = _loc4_.parent;
         }
         _loc5_ = _loc3_.length - 1;
         while(_loc5_ >= 0)
         {
            _loc4_ = _loc3_[_loc5_];
            param2 = (param2 - _loc4_.y) / _loc4_.scaleY;
            _loc5_--;
         }
         return param2;
      }
      
      public function getGlobalX(param1:DisplayObject, param2:Number) : Number
      {
         var _loc3_:DisplayObject = param1.parent;
         while(_loc3_)
         {
            param2 = param2 * _loc3_.scaleX + _loc3_.x;
            _loc3_ = _loc3_.parent;
         }
         return param2;
      }
      
      public function getGlobalY(param1:DisplayObject, param2:Number) : Number
      {
         var _loc3_:DisplayObject = param1.parent;
         while(_loc3_)
         {
            param2 = param2 * _loc3_.scaleY + _loc3_.y;
            _loc3_ = _loc3_.parent;
         }
         return param2;
      }
      
      public function getBezier(param1:Number, param2:Number, param3:Number, param4:Array) : Number
      {
         var _loc8_:* = 0;
         var _loc5_:Number = NaN;
         var _loc7_:* = NaN;
         var _loc6_:* = NaN;
         if(param3 == 1)
         {
            return param2;
         }
         if(param4.length == 1)
         {
            return param1 + param3 * (2 * (1 - param3) * (param4[0] - param1) + param3 * (param2 - param1));
         }
         _loc8_ = uint(Math.floor(param3 * param4.length));
         _loc5_ = (param3 - _loc8_ * (1 / param4.length)) * param4.length;
         if(_loc8_ == 0)
         {
            _loc7_ = param1;
            _loc6_ = Number((param4[0] + param4[1]) / 2);
         }
         else if(_loc8_ == param4.length - 1)
         {
            _loc7_ = Number((param4[_loc8_ - 1] + param4[_loc8_]) / 2);
            _loc6_ = param2;
         }
         else
         {
            _loc7_ = Number((param4[_loc8_ - 1] + param4[_loc8_]) / 2);
            _loc6_ = Number((param4[_loc8_] + param4[_loc8_ + 1]) / 2);
         }
         return _loc7_ + _loc5_ * (2 * (1 - _loc5_) * (param4[_loc8_] - _loc7_) + _loc5_ * (_loc6_ - _loc7_));
      }
   }
}
