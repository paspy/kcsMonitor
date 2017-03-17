package a24.tween.core.updaters.display
{
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import a24.util.Align24;
   import a24.util.Util24;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public final class DisplayObjectUpdater extends AbstractUpdater
   {
       
      
      private var _target:Object;
      
      private var _targetDisplayObject:DisplayObject;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _z:Number;
      
      private var _alpha:Number;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _scaleX:Number;
      
      private var _scaleY:Number;
      
      private var _scaleZ:Number;
      
      private var _rotation:Number;
      
      private var _rotationX:Number;
      
      private var _rotationY:Number;
      
      private var _rotationZ:Number;
      
      private var _startX:Number;
      
      private var _startY:Number;
      
      private var _startZ:Number;
      
      private var _startAlpha:Number;
      
      private var _startWidth:Number;
      
      private var _startHeight:Number;
      
      private var _startScaleX:Number;
      
      private var _startScaleY:Number;
      
      private var _startScaleZ:Number;
      
      private var _startRotation:Number;
      
      private var _startRotationX:Number;
      
      private var _startRotationY:Number;
      
      private var _startRotationZ:Number;
      
      private var _deltaX:Number;
      
      private var _deltaY:Number;
      
      private var _deltaZ:Number;
      
      private var _deltaAlpha:Number;
      
      private var _deltaWidth:Number;
      
      private var _deltaHeight:Number;
      
      private var _deltaScaleX:Number;
      
      private var _deltaScaleY:Number;
      
      private var _deltaScaleZ:Number;
      
      private var _deltaRotation:Number;
      
      private var _deltaRotationX:Number;
      
      private var _deltaRotationY:Number;
      
      private var _deltaRotationZ:Number;
      
      private var _$x:Number;
      
      private var _$y:Number;
      
      private var _$z:Number;
      
      private var _$alpha:Number;
      
      private var _$width:Number;
      
      private var _$height:Number;
      
      private var _$scaleX:Number;
      
      private var _$scaleY:Number;
      
      private var _$scaleZ:Number;
      
      private var _$rotation:Number;
      
      private var _$rotationX:Number;
      
      private var _$rotationY:Number;
      
      private var _$rotationZ:Number;
      
      private var _$$x:Number;
      
      private var _$$y:Number;
      
      private var _$$z:Number;
      
      private var _$$alpha:Number;
      
      private var _$$width:Number;
      
      private var _$$height:Number;
      
      private var _$$scaleX:Number;
      
      private var _$$scaleY:Number;
      
      private var _$$scaleZ:Number;
      
      private var _$$rotation:Number;
      
      private var _$$rotationX:Number;
      
      private var _$$rotationY:Number;
      
      private var _$$rotationZ:Number;
      
      private var _globalX:Number;
      
      private var _globalY:Number;
      
      private var _bezierX:Array;
      
      private var _bezierY:Array;
      
      private var _$$bezierX:Array;
      
      private var _$$bezierY:Array;
      
      private var _localX:Number;
      
      private var _localY:Number;
      
      private var _localXTarget:DisplayObject;
      
      private var _localYTarget:DisplayObject;
      
      private var _align:uint;
      
      private var _alignX:Number;
      
      private var _alignY:Number;
      
      private var _alignScaleX:Number;
      
      private var _alignScaleY:Number;
      
      private var _alignOffsetByScaleX:Number;
      
      private var _alignOffsetByScaleY:Number;
      
      private var _startRect:Rectangle;
      
      private var _rotX:Number;
      
      private var _rotY:Number;
      
      private var _fadeIn:Boolean;
      
      private var _fadeOut:Boolean;
      
      private var _useLayerBlend:Boolean;
      
      private var _mouseEnabled:Boolean;
      
      private var _mouseChildren:Boolean;
      
      private var _beforeBlend:String;
      
      private var _blendMode:String;
      
      private var _randomMinX:Number;
      
      private var _randomMaxX:Number;
      
      private var _randomMinY:Number;
      
      private var _randomMaxY:Number;
      
      private var _randomMinZ:Number;
      
      private var _randomMaxZ:Number;
      
      private var _randomRound:Boolean;
      
      private var _useSize:Boolean;
      
      private var _useScale:Boolean;
      
      private var _useRotation:Boolean;
      
      private var _useRandom:Boolean;
      
      private var _useGlobalLocal:Boolean;
      
      public function DisplayObjectUpdater(param1:Object)
      {
         super();
         _target = param1;
         if(param1 is DisplayObject)
         {
            _targetDisplayObject = param1 as DisplayObject;
         }
      }
      
      public function bezier(param1:Number, param2:Number) : void
      {
         if(!_bezierX)
         {
            _bezierX = [];
         }
         if(!_bezierY)
         {
            _bezierY = [];
         }
         _bezierX.push(param1);
         _bezierY.push(param2);
      }
      
      public function $$bezier(param1:Number, param2:Number) : void
      {
         if(!_$$bezierX)
         {
            _$$bezierX = [];
         }
         if(!_$$bezierY)
         {
            _$$bezierY = [];
         }
         _$$bezierX.push(param1);
         _$$bezierY.push(param2);
      }
      
      public function set$x(param1:Number) : void
      {
         this.$x = param1;
         initAlign();
         init$XY(true,false);
      }
      
      public function set$y(param1:Number) : void
      {
         this.$y = param1;
         initAlign();
         init$XY(false,true);
      }
      
      public function update$xy() : void
      {
         initAlign();
         if(!isNaN($x))
         {
            init$XY(true,false);
         }
         if(!isNaN($y))
         {
            init$XY(false,true);
         }
      }
      
      private function initAlign() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_align && _targetDisplayObject)
         {
            if(_align == 100)
            {
               _loc2_ = _target.getBounds(_targetDisplayObject);
               if(!isNaN(_alignScaleX))
               {
                  _alignX = (_loc2_.left + _loc2_.width) * _alignScaleX;
               }
               if(!isNaN(_alignScaleY))
               {
                  _alignY = (_loc2_.top + _loc2_.height) * _alignScaleY;
               }
            }
            else
            {
               _loc1_ = Align24.getAlignPoint(_targetDisplayObject as DisplayObject,_align);
               _alignX = _loc1_.x;
               _alignY = _loc1_.y;
            }
         }
         else
         {
            _alignY = 0;
            _alignX = 0;
            _alignOffsetByScaleY = 0;
            _alignOffsetByScaleX = 0;
         }
      }
      
      private function init$XY(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(_align && _targetDisplayObject)
         {
            _loc3_ = _targetDisplayObject.localToGlobal(new Point(0,0));
            _loc4_ = _targetDisplayObject.localToGlobal(new Point(_alignX,_alignY));
            if(param1)
            {
               x = _targetDisplayObject.x + $x + (_loc4_.x - _loc3_.x);
            }
            if(param2)
            {
               y = _targetDisplayObject.y + $y + (_loc4_.y - _loc3_.y);
            }
         }
         else
         {
            if(param1)
            {
               x = _target.x + $x;
            }
            if(param2)
            {
               y = _target.y + $y;
            }
         }
      }
      
      public function setProp(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number) : void
      {
         _x = param1;
         _y = param2;
         _z = param3;
         _alpha = param4;
         _width = param5;
         _height = param6;
         _scaleX = param7;
         _scaleY = param8;
         _scaleZ = param9;
         _rotation = param10;
         _rotationX = param11;
         _rotationY = param12;
         _rotationZ = param13;
      }
      
      public function init() : void
      {
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc6_:* = null;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc1_:Number = NaN;
         _tweenFlag = _updateFlag | _$$updateFlag;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc2_:* = 0;
         if(_useRandom)
         {
            if(!isNaN(_randomMinX))
            {
               if(isNaN(_x))
               {
                  _x = _target.x;
               }
               _loc8_ = Number(Util24.math.randomInRange(_randomMinX,_randomMaxX,NaN,NaN,_randomRound));
            }
            if(!isNaN(_randomMinY))
            {
               if(isNaN(_y))
               {
                  _y = _target.y;
               }
               _loc9_ = Number(Util24.math.randomInRange(_randomMinY,_randomMaxY,NaN,NaN,_randomRound));
            }
            if(!isNaN(_randomMinZ))
            {
               if(isNaN(_z))
               {
                  _z = _target.z;
               }
               _loc2_ = Number(Util24.math.randomInRange(_randomMinZ,_randomMaxZ,NaN,NaN,_randomRound));
            }
         }
         if(_targetDisplayObject)
         {
            if(_align)
            {
               _loc6_ = _targetDisplayObject.localToGlobal(new Point(_alignX,_alignY));
            }
            else
            {
               _loc6_ = new Point(_targetDisplayObject.x,_targetDisplayObject.y);
            }
            if(_useGlobalLocal)
            {
               if(!isNaN(_globalX))
               {
                  _x = Util24.display.getLocalX(_targetDisplayObject,_globalX);
               }
               if(!isNaN(_globalY))
               {
                  _y = Util24.display.getLocalY(_targetDisplayObject,_globalY);
               }
               if(!isNaN(_localX))
               {
                  _loc5_ = Util24.display.getGlobalX(_targetDisplayObject,_targetDisplayObject.x);
                  _loc4_ = Util24.display.getGlobalX(_localXTarget,_localXTarget.x + _localX);
                  _x = _targetDisplayObject.x + (_loc4_ - _loc5_);
               }
               if(!isNaN(_localY))
               {
                  _loc3_ = Util24.display.getGlobalY(_targetDisplayObject,_targetDisplayObject.y);
                  _loc1_ = Util24.display.getGlobalY(_localYTarget,_localYTarget.y + _localY);
                  _y = _targetDisplayObject.y + (_loc1_ - _loc3_);
               }
            }
            if(_$$updateFlag)
            {
               if(_$$updateFlag & 1)
               {
                  _x = _loc6_.x + _$$x;
               }
               if(_$$updateFlag & 2)
               {
                  _y = _loc6_.y + _$$y;
               }
               if(_$$updateFlag & 4)
               {
                  _z = _target.z + _$$z;
               }
               if(_$$updateFlag & 8)
               {
                  _alpha = _targetDisplayObject.alpha + _$$alpha;
               }
               if(_$$updateFlag & 16)
               {
                  _width = _targetDisplayObject.width + _$$width;
               }
               if(_$$updateFlag & 32)
               {
                  _height = _targetDisplayObject.height + _$$height;
               }
               if(_$$updateFlag & 64)
               {
                  _scaleX = _targetDisplayObject.scaleX + _$$scaleX;
               }
               if(_$$updateFlag & 128)
               {
                  _scaleY = _targetDisplayObject.scaleY + _$$scaleY;
               }
               if(_$$updateFlag & 256)
               {
                  _scaleZ = _target.scaleZ + _$$scaleZ;
               }
               if(_$$updateFlag & 512)
               {
                  _rotation = _targetDisplayObject.rotation + _$$rotation;
               }
               if(_$$updateFlag & 1024)
               {
                  _rotationX = _target.rotationX + _$$rotationX;
               }
               if(_$$updateFlag & 2048)
               {
                  _rotationY = _target.rotationY + _$$rotationY;
               }
               if(_$$updateFlag & 4096)
               {
                  _rotationZ = _target.rotationZ + _$$rotationZ;
               }
            }
            if(_align)
            {
               initByAlign();
               if(_tweenFlag & 1)
               {
                  _deltaX = _x + (!!_align?_alignOffsetByScaleX - _loc6_.x:Number(-_startX)) + _loc8_;
               }
               if(_tweenFlag & 2)
               {
                  _deltaY = _y + (!!_align?_alignOffsetByScaleY - _loc6_.y:Number(-_startY)) + _loc9_;
               }
            }
            else
            {
               if(_tweenFlag & 1)
               {
                  _startX = _targetDisplayObject.x;
                  _deltaX = _x - _startX + _loc8_;
               }
               if(_tweenFlag & 2)
               {
                  _startY = _targetDisplayObject.y;
                  _deltaY = _y - _startY + _loc9_;
               }
            }
            if(_tweenFlag & 4)
            {
               _startZ = _target.z;
               _deltaZ = _z - _startZ + _loc2_;
            }
            if(_tweenFlag & 8)
            {
               _startAlpha = _targetDisplayObject.alpha;
               _deltaAlpha = _alpha - _startAlpha;
            }
            if(_useSize)
            {
               if(_tweenFlag & 16)
               {
                  _startWidth = _targetDisplayObject.width;
                  _deltaWidth = _width - _startWidth;
               }
               if(_tweenFlag & 32)
               {
                  _startHeight = _targetDisplayObject.height;
                  _deltaHeight = _height - _startHeight;
               }
            }
            if(_useScale)
            {
               if(_tweenFlag & 64)
               {
                  _startScaleX = _targetDisplayObject.scaleX;
                  _deltaScaleX = _scaleX - _startScaleX;
               }
               if(_tweenFlag & 128)
               {
                  _startScaleY = _targetDisplayObject.scaleY;
                  _deltaScaleY = _scaleY - _startScaleY;
               }
               if(_tweenFlag & 256)
               {
                  _startScaleZ = _target.scaleZ;
                  _deltaScaleZ = _scaleZ - _startScaleZ;
               }
            }
            if(_useRotation)
            {
               if(_tweenFlag & 512)
               {
                  _startRotation = _targetDisplayObject.rotation;
                  _deltaRotation = _rotation - _startRotation;
               }
               if(_tweenFlag & 1024)
               {
                  _startRotationX = _target.rotationX;
                  _deltaRotationX = _rotationX - _startRotationX;
               }
               if(_tweenFlag & 2048)
               {
                  _startRotationY = _target.rotationY;
                  _deltaRotationY = _rotationY - _startRotationY;
               }
               if(_tweenFlag & 4096)
               {
                  _startRotationZ = _target.rotationZ;
                  _deltaRotationZ = _rotationZ - _startRotationZ;
               }
            }
            if(_$$bezierX)
            {
               _bezierX = [];
               _bezierY = [];
               [];
               _loc7_ = _$$bezierX.length;
               _loc10_ = 0;
               while(_loc10_ < _loc7_)
               {
                  _bezierX[_loc10_] = _loc6_.x + _$$bezierX[_loc10_];
                  _bezierY[_loc10_] = _loc6_.y + _$$bezierY[_loc10_];
                  _loc10_++;
               }
            }
            if(_bezierX || _bezierY)
            {
               if(isNaN(_x))
               {
                  _startX = _loc6_.x;
                  _x = _loc6_.x;
                  _deltaX = 0 + _loc8_;
               }
               if(isNaN(_y))
               {
                  _startY = _loc6_.y;
                  _y = _loc6_.y;
                  _deltaY = 0 + _loc9_;
               }
            }
         }
         else
         {
            if(_$$updateFlag)
            {
               if(_$$updateFlag & 1)
               {
                  _x = _target.x + _$$x;
               }
               if(_$$updateFlag & 2)
               {
                  _y = _target.y + _$$y;
               }
               if(_$$updateFlag & 4)
               {
                  _z = _target.z + _$$z;
               }
               if(_$$updateFlag & 8)
               {
                  _alpha = _target.alpha + _$$alpha;
               }
               if(_$$updateFlag & 16)
               {
                  _width = _target.width + _$$width;
               }
               if(_$$updateFlag & 32)
               {
                  _height = _target.height + _$$height;
               }
               if(_$$updateFlag & 64)
               {
                  _scaleX = _target.scaleX + _$$scaleX;
               }
               if(_$$updateFlag & 128)
               {
                  _scaleY = _target.scaleY + _$$scaleY;
               }
               if(_$$updateFlag & 256)
               {
                  _scaleZ = _target.scaleZ + _$$scaleZ;
               }
               if(_$$updateFlag & 512)
               {
                  _rotation = _target.rotation + _$$rotation;
               }
               if(_$$updateFlag & 1024)
               {
                  _rotationX = _target.rotationX + _$$rotationX;
               }
               if(_$$updateFlag & 2048)
               {
                  _rotationY = _target.rotationY + _$$rotationY;
               }
               if(_$$updateFlag & 4096)
               {
                  _rotationZ = _target.rotationZ + _$$rotationZ;
               }
            }
            if(_tweenFlag & 1)
            {
               _startX = _target.x;
               _deltaX = _x - _startX + _loc8_;
            }
            if(_tweenFlag & 2)
            {
               _startY = _target.y;
               _deltaY = _y - _startY + _loc9_;
            }
            if(_tweenFlag & 4)
            {
               _startZ = _target.z;
               _deltaZ = _z - _startZ + _loc2_;
            }
            if(_tweenFlag & 8)
            {
               _startAlpha = _target.alpha;
               _deltaAlpha = _alpha - _startAlpha;
            }
            if(_useSize)
            {
               if(_tweenFlag & 16)
               {
                  _startWidth = _target.width;
                  _deltaWidth = _width - _startWidth;
               }
               if(_tweenFlag & 32)
               {
                  _startHeight = _target.height;
                  _deltaHeight = _height - _startHeight;
               }
            }
            if(_useScale)
            {
               if(_tweenFlag & 64)
               {
                  _startScaleX = _target.scaleX;
                  _deltaScaleX = _scaleX - _startScaleX;
               }
               if(_tweenFlag & 128)
               {
                  _startScaleY = _target.scaleY;
                  _deltaScaleY = _scaleY - _startScaleY;
               }
               if(_tweenFlag & 256)
               {
                  _startScaleZ = _target.scaleZ;
                  _deltaScaleZ = _scaleZ - _startScaleZ;
               }
            }
            if(_useRotation)
            {
               if(_tweenFlag & 512)
               {
                  _startRotation = _target.rotation;
                  _deltaRotation = _rotation - _startRotation;
               }
               if(_tweenFlag & 1024)
               {
                  _startRotationX = _target.rotationX;
                  _deltaRotationX = _rotationX - _startRotationX;
               }
               if(_tweenFlag & 2048)
               {
                  _startRotationY = _target.rotationY;
                  _deltaRotationY = _rotationY - _startRotationY;
               }
               if(_tweenFlag & 4096)
               {
                  _startRotationZ = _target.rotationZ;
                  _deltaRotationZ = _rotationZ - _startRotationZ;
               }
            }
            if(_$$bezierX)
            {
               _bezierX = [];
               _bezierY = [];
               [];
               _loc7_ = _$$bezierX.length;
               _loc10_ = 0;
               while(_loc10_ < _loc7_)
               {
                  _bezierX[_loc10_] = _target.x + _$$bezierX[_loc10_];
                  _bezierY[_loc10_] = _target.y + _$$bezierY[_loc10_];
                  _loc10_++;
               }
            }
            if(_bezierX || _bezierY)
            {
               if(isNaN(_x))
               {
                  _startX = _target.x;
                  _x = _target.x;
                  _deltaX = 0 + _loc8_;
               }
               if(isNaN(_y))
               {
                  _startY = _target.y;
                  _y = _target.y;
                  _deltaY = 0 + _loc9_;
               }
            }
         }
         if(_tweenFlag & 8192 && _fadeIn)
         {
            _target.visible = true;
         }
         if(_blendMode)
         {
            _target.blendMode = _blendMode;
         }
         if(_useLayerBlend)
         {
            _beforeBlend = _target.blendMode;
            _target.blendMode = "layer";
         }
         if(_tweenFlag & 16384 && !_mouseEnabled)
         {
            _target.mouseEnabled = _mouseEnabled;
         }
         if(_tweenFlag & 32768 && !_mouseChildren)
         {
            _target.mouseChildren = _mouseChildren;
         }
      }
      
      public function initByAlign() : void
      {
         var _loc5_:* = null;
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         initAlign();
         _startX = _targetDisplayObject.x;
         _startY = _targetDisplayObject.y;
         _deltaX = 0;
         _deltaY = 0;
         if(_tweenFlag & 16 || _tweenFlag & 32)
         {
            _scaleY = 1;
            _scaleX = 1;
            _loc5_ = _targetDisplayObject.getRect(_targetDisplayObject);
            if(_tweenFlag & 16)
            {
               _scaleX = _width / _loc5_.width;
            }
            if(_tweenFlag & 32)
            {
               _scaleY = _height / _loc5_.height;
            }
         }
         if(_tweenFlag & 64 || _tweenFlag & 128 || _tweenFlag & 16 || _tweenFlag & 32)
         {
            _startScaleX = _targetDisplayObject.scaleX;
            _startScaleY = _targetDisplayObject.scaleY;
            _deltaScaleY = 0;
            _deltaScaleX = 0;
            _loc6_ = _targetDisplayObject.rotation * 3.14159265358979 / 180;
            _loc3_ = _alignX * (_startScaleX - _scaleX);
            _loc4_ = _alignY * (_startScaleY - _scaleY);
            _loc2_ = Math.sin(_loc6_);
            _loc1_ = Math.cos(_loc6_);
            _alignOffsetByScaleX = _loc3_ * _loc1_ - _loc4_ * _loc2_;
            _alignOffsetByScaleY = _loc3_ * _loc2_ + _loc4_ * _loc1_;
         }
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         var _loc4_:* = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc7_:Number = NaN;
         if(_targetDisplayObject)
         {
            _loc4_ = 0;
            var _loc2_:* = 0;
            if(_align != 0)
            {
               if(_tweenFlag & 64 || _tweenFlag & 128 || _tweenFlag & 16 || _tweenFlag & 32)
               {
                  if(!(_tweenFlag & 1))
                  {
                     _loc4_ = Number(_loc4_ + _alignOffsetByScaleX * param1);
                  }
                  if(!(_tweenFlag & 2))
                  {
                     _loc2_ = Number(_loc2_ + _alignOffsetByScaleY * param1);
                  }
               }
               if(_tweenFlag & 512)
               {
                  _loc8_ = _alignX * _targetDisplayObject.scaleX;
                  _loc9_ = _alignY * _targetDisplayObject.scaleY;
                  _loc3_ = _startRotation / 180 * 3.14159265358979;
                  _loc5_ = (_startRotation + _deltaRotation * param1) / 180 * 3.14159265358979;
                  _loc11_ = _loc8_ * Math.cos(_loc3_) - _loc9_ * Math.sin(_loc3_);
                  _loc6_ = _loc8_ * Math.sin(_loc3_) + _loc9_ * Math.cos(_loc3_);
                  _loc10_ = _loc8_ * Math.cos(_loc5_) - _loc9_ * Math.sin(_loc5_);
                  _loc7_ = _loc8_ * Math.sin(_loc5_) + _loc9_ * Math.cos(_loc5_);
                  _loc4_ = Number(_loc4_ + (_loc11_ - _loc10_));
                  _loc2_ = Number(_loc2_ + (_loc6_ - _loc7_));
               }
            }
            if(_bezierX != null)
            {
               _targetDisplayObject.x = Util24.display.getBezier(_startX,_startX + _deltaX,param1,_bezierX) + _loc4_;
               _targetDisplayObject.y = Util24.display.getBezier(_startY,_startY + _deltaY,param1,_bezierY) + _loc2_;
            }
            else
            {
               if(_tweenFlag & 1 || _align)
               {
                  _targetDisplayObject.x = _startX + _deltaX * param1 + _loc4_;
               }
               if(_tweenFlag & 2 || _align)
               {
                  _targetDisplayObject.y = _startY + _deltaY * param1 + _loc2_;
               }
            }
            if(_tweenFlag & 4)
            {
               _target.z = _startZ + _deltaZ * param1;
            }
            if(_tweenFlag & 8)
            {
               _targetDisplayObject.alpha = _startAlpha + _deltaAlpha * param1;
            }
            if(_useSize)
            {
               if(_tweenFlag & 16)
               {
                  _targetDisplayObject.width = _startWidth + _deltaWidth * param1;
               }
               if(_tweenFlag & 32)
               {
                  _targetDisplayObject.height = _startHeight + _deltaHeight * param1;
               }
            }
            if(_useScale)
            {
               if(_tweenFlag & 64)
               {
                  _targetDisplayObject.scaleX = _startScaleX + _deltaScaleX * param1;
               }
               if(_tweenFlag & 128)
               {
                  _targetDisplayObject.scaleY = _startScaleY + _deltaScaleY * param1;
               }
               if(_tweenFlag & 256)
               {
                  _target.scaleZ = _startScaleZ + _deltaScaleZ * param1;
               }
            }
            if(_useRotation)
            {
               if(_tweenFlag & 512)
               {
                  _targetDisplayObject.rotation = _startRotation + _deltaRotation * param1;
               }
               if(_tweenFlag & 1024)
               {
                  _target.rotationX = _startRotationX + _deltaRotationX * param1;
               }
               if(_tweenFlag & 2048)
               {
                  _target.rotationY = _startRotationY + _deltaRotationY * param1;
               }
               if(_tweenFlag & 4096)
               {
                  _target.rotationZ = _startRotationZ + _deltaRotationZ * param1;
               }
            }
         }
         else
         {
            if(_bezierX)
            {
               _target.x = Util24.display.getBezier(_startX,_startX + _deltaX,param1,_bezierX);
               _target.y = Util24.display.getBezier(_startY,_startY + _deltaY,param1,_bezierY);
            }
            else
            {
               if(_tweenFlag & 1)
               {
                  _target.x = _startX + _deltaX * param1;
               }
               if(_tweenFlag & 2)
               {
                  _target.y = _startY + _deltaY * param1;
               }
            }
            if(_tweenFlag & 4)
            {
               _target.z = _startZ + _deltaZ * param1;
            }
            if(_tweenFlag & 8)
            {
               _target.alpha = _startAlpha + _deltaAlpha * param1;
            }
            if(_useSize)
            {
               if(_tweenFlag & 16)
               {
                  _target.width = _startWidth + _deltaWidth * param1;
               }
               if(_tweenFlag & 32)
               {
                  _target.height = _startHeight + _deltaHeight * param1;
               }
            }
            if(_useScale)
            {
               if(_tweenFlag & 64)
               {
                  _target.scaleX = _startScaleX + _deltaScaleX * param1;
               }
               if(_tweenFlag & 128)
               {
                  _target.scaleY = _startScaleY + _deltaScaleY * param1;
               }
               if(_tweenFlag & 256)
               {
                  _target.scaleZ = _startScaleZ + _deltaScaleZ * param1;
               }
            }
            if(_useRotation)
            {
               if(_tweenFlag & 512)
               {
                  _target.rotation = _startRotation + _deltaRotation * param1;
               }
               if(_tweenFlag & 1024)
               {
                  _target.rotationX = _startRotationX + _deltaRotationX * param1;
               }
               if(_tweenFlag & 2048)
               {
                  _target.rotationY = _startRotationY + _deltaRotationY * param1;
               }
               if(_tweenFlag & 4096)
               {
                  _target.rotationZ = _startRotationZ + _deltaRotationZ * param1;
               }
            }
         }
         return this;
      }
      
      override public function complete() : void
      {
         super.complete();
         if(_tweenFlag & 8192 && _fadeOut)
         {
            _target.visible = false;
         }
         if(_useLayerBlend)
         {
            _target.blendMode = _beforeBlend;
         }
         if(_tweenFlag & 16384 && _mouseEnabled)
         {
            _target.mouseEnabled = _mouseEnabled;
         }
         if(_tweenFlag & 32768 && _mouseChildren)
         {
            _target.mouseChildren = _mouseChildren;
         }
      }
      
      public function clone() : DisplayObjectUpdater
      {
         var _loc1_:DisplayObjectUpdater = new DisplayObjectUpdater(_target);
         _loc1_.setProp(_x,_y,z,_alpha,_width,_height,_scaleX,_scaleY,_scaleZ,_rotation,_rotationX,_rotationY,_rotationZ);
         _loc1_._$x = _$x;
         _loc1_._$y = _$y;
         _loc1_._$z = _$z;
         _loc1_._$alpha = _$alpha;
         _loc1_._$width = _$width;
         _loc1_._$height = _$height;
         _loc1_._$scaleX = _$scaleX;
         _loc1_._$scaleY = _$scaleY;
         _loc1_._$scaleZ = _$scaleZ;
         _loc1_._$rotation = _$rotation;
         _loc1_._$rotationX = _$rotationX;
         _loc1_._$rotationY = _$rotationY;
         _loc1_._$rotationZ = _$rotationZ;
         _loc1_._$$x = _$$x;
         _loc1_._$$y = _$$y;
         _loc1_._$$z = _$$z;
         _loc1_._$$alpha = _$$alpha;
         _loc1_._$$width = _$$width;
         _loc1_._$$height = _$$height;
         _loc1_._$$scaleX = _$$scaleX;
         _loc1_._$$scaleY = _$$scaleY;
         _loc1_._$$scaleZ = _$$scaleZ;
         _loc1_._$$rotation = _$$rotation;
         _loc1_._$$rotationX = _$$rotationX;
         _loc1_._$$rotationY = _$$rotationY;
         _loc1_._$$rotationZ = _$$rotationZ;
         _loc1_._updateFlag = _updateFlag;
         _loc1_._$updateFlag = _$updateFlag;
         _loc1_._$$updateFlag = _$$updateFlag;
         _loc1_._globalX = _globalX;
         _loc1_._globalY = _globalY;
         _loc1_._bezierX = _bezierX;
         _loc1_._bezierY = _bezierY;
         _loc1_._$$bezierX = _$$bezierX;
         _loc1_._$$bezierY = _$$bezierY;
         _loc1_._fadeIn = _fadeIn;
         _loc1_._fadeOut = _fadeOut;
         _loc1_._useLayerBlend = _useLayerBlend;
         _loc1_._useGlobalLocal = _useGlobalLocal;
         _loc1_._useLayerBlend = _useLayerBlend;
         _loc1_._useRandom = _useRandom;
         _loc1_._useRotation = _useRotation;
         _loc1_._useScale = _useScale;
         _loc1_._useSize = _useSize;
         return _loc1_;
      }
      
      override public function toString() : String
      {
         var _loc2_:String = "";
         var _loc1_:uint = _updateFlag | _$$updateFlag;
         if(_loc1_ & 1)
         {
            _loc2_ = "x:" + _x + ", ";
         }
         if(_loc1_ & 2)
         {
            _loc2_ = "y:" + _y + ", ";
         }
         if(_loc1_ & 4)
         {
            _loc2_ = "z:" + _z + ", ";
         }
         if(_loc1_ & 8)
         {
            _loc2_ = "alpha:" + _alpha + ", ";
         }
         if(_loc1_ & 16)
         {
            _loc2_ = "width:" + _width + ", ";
         }
         if(_loc1_ & 32)
         {
            _loc2_ = "height:" + _height + ", ";
         }
         if(_loc1_ & 64)
         {
            _loc2_ = "scaleX:" + _scaleX + ", ";
         }
         if(_loc1_ & 128)
         {
            _loc2_ = "scaleY:" + _scaleY + ", ";
         }
         if(_loc1_ & 256)
         {
            _loc2_ = "scaleZ:" + _scaleZ + ", ";
         }
         if(_loc1_ & 512)
         {
            _loc2_ = "rotation:" + _rotation + ", ";
         }
         if(_loc1_ & 1024)
         {
            _loc2_ = "rotationX:" + _rotationX + ", ";
         }
         if(_loc1_ & 2048)
         {
            _loc2_ = "rotationY:" + _rotationY + ", ";
         }
         if(_loc1_ & 4096)
         {
            _loc2_ = "rotationZ:" + _rotationZ + ", ";
         }
         if(_loc1_ & 16384)
         {
            _loc2_ = "mouseEnabled:" + _mouseEnabled + ", ";
         }
         if(_loc1_ & 32768)
         {
            _loc2_ = "mouseChildren:" + _mouseChildren + ", ";
         }
         return _loc2_.slice(0,-2);
      }
      
      public function getDistance() : Number
      {
         var _loc1_:Number = !!isNaN(_deltaX)?0:Number(_deltaX);
         var _loc2_:Number = !!isNaN(_deltaY)?0:Number(_deltaY);
         var _loc3_:Number = !!isNaN(_deltaZ)?0:Number(_deltaZ);
         return Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_ + _loc3_ * _loc3_);
      }
      
      public function get target() : Object
      {
         return _target;
      }
      
      public function set target(param1:Object) : void
      {
         _target = param1;
      }
      
      public function get align() : uint
      {
         return _align;
      }
      
      public function set align(param1:uint) : void
      {
         _align = param1;
      }
      
      public function get alignX() : Number
      {
         return _alignX;
      }
      
      public function set alignX(param1:Number) : void
      {
         _alignX = param1;
         _align = 100;
      }
      
      public function get alignY() : Number
      {
         return _alignY;
      }
      
      public function set alignY(param1:Number) : void
      {
         _alignY = param1;
         _align = 100;
      }
      
      public function get alignScaleX() : Number
      {
         return _alignScaleX;
      }
      
      public function set alignScaleX(param1:Number) : void
      {
         _alignScaleX = param1;
         _align = 100;
      }
      
      public function get alignScaleY() : Number
      {
         return _alignScaleY;
      }
      
      public function set alignScaleY(param1:Number) : void
      {
         _alignScaleY = param1;
         _align = 100;
      }
      
      public function get useLayerBlend() : Boolean
      {
         return _useLayerBlend;
      }
      
      public function set useLayerBlend(param1:Boolean) : void
      {
         _useLayerBlend = param1;
      }
      
      public function get blendMode() : String
      {
         return _blendMode;
      }
      
      public function set blendMode(param1:String) : void
      {
         _blendMode = param1;
      }
      
      public function get globalX() : Number
      {
         return _globalX;
      }
      
      public function set globalX(param1:Number) : void
      {
         _globalX = param1;
         _updateFlag = _updateFlag | 1;
         _useGlobalLocal = true;
      }
      
      public function get globalY() : Number
      {
         return _globalY;
      }
      
      public function set globalY(param1:Number) : void
      {
         _globalY = param1;
         _updateFlag = _updateFlag | 2;
         _useGlobalLocal = true;
      }
      
      public function get localX() : Number
      {
         return _localX;
      }
      
      public function set localX(param1:Number) : void
      {
         _localX = param1;
         _updateFlag = _updateFlag | 1;
         _useGlobalLocal = true;
      }
      
      public function get localY() : Number
      {
         return _localY;
      }
      
      public function set localY(param1:Number) : void
      {
         _localY = param1;
         _updateFlag = _updateFlag | 2;
         _useGlobalLocal = true;
      }
      
      public function get localXTarget() : DisplayObject
      {
         return _localXTarget;
      }
      
      public function set localXTarget(param1:DisplayObject) : void
      {
         _localXTarget = param1;
      }
      
      public function get localYTarget() : DisplayObject
      {
         return _localYTarget;
      }
      
      public function set localYTarget(param1:DisplayObject) : void
      {
         _localYTarget = param1;
      }
      
      public function get randomMinX() : Number
      {
         return _randomMinX;
      }
      
      public function set randomMinX(param1:Number) : void
      {
         _randomMinX = param1;
         _updateFlag = _updateFlag | 1;
         _useRandom = true;
      }
      
      public function get randomMaxX() : Number
      {
         return _randomMaxX;
      }
      
      public function set randomMaxX(param1:Number) : void
      {
         _randomMaxX = param1;
         _useRandom = true;
      }
      
      public function get randomMinY() : Number
      {
         return _randomMinY;
      }
      
      public function set randomMinY(param1:Number) : void
      {
         _randomMinY = param1;
         _updateFlag = _updateFlag | 2;
         _useRandom = true;
      }
      
      public function get randomMaxY() : Number
      {
         return _randomMaxY;
      }
      
      public function set randomMaxY(param1:Number) : void
      {
         _randomMaxY = param1;
         _useRandom = true;
      }
      
      public function get randomMinZ() : Number
      {
         return _randomMinZ;
      }
      
      public function set randomMinZ(param1:Number) : void
      {
         _randomMinZ = param1;
         _updateFlag = _updateFlag | 4;
         _useRandom = true;
      }
      
      public function get randomMaxZ() : Number
      {
         return _randomMaxZ;
      }
      
      public function set randomMaxZ(param1:Number) : void
      {
         _randomMaxZ = param1;
         _useRandom = true;
      }
      
      public function get randomRound() : Boolean
      {
         return _randomRound;
      }
      
      public function set randomRound(param1:Boolean) : void
      {
         _randomRound = param1;
         _useRandom = true;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set x(param1:Number) : void
      {
         _x = param1;
         _updateFlag = _updateFlag | 1;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
         _updateFlag = _updateFlag | 2;
      }
      
      public function get z() : Number
      {
         return _z;
      }
      
      public function set z(param1:Number) : void
      {
         _z = param1;
         _updateFlag = _updateFlag | 4;
      }
      
      public function get alpha() : Number
      {
         return _alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         _alpha = param1;
         _updateFlag = _updateFlag | 8;
      }
      
      public function get width() : Number
      {
         return _width;
      }
      
      public function set width(param1:Number) : void
      {
         _width = param1;
         _updateFlag = _updateFlag | 16;
         _useSize = true;
      }
      
      public function get height() : Number
      {
         return _height;
      }
      
      public function set height(param1:Number) : void
      {
         _height = param1;
         _updateFlag = _updateFlag | 32;
         _useSize = true;
      }
      
      public function get scaleX() : Number
      {
         return _scaleX;
      }
      
      public function set scaleX(param1:Number) : void
      {
         _scaleX = param1;
         _updateFlag = _updateFlag | 64;
         _useScale = true;
      }
      
      public function get scaleY() : Number
      {
         return _scaleY;
      }
      
      public function set scaleY(param1:Number) : void
      {
         _scaleY = param1;
         _updateFlag = _updateFlag | 128;
         _useScale = true;
      }
      
      public function get scaleZ() : Number
      {
         return _scaleZ;
      }
      
      public function set scaleZ(param1:Number) : void
      {
         _scaleZ = param1;
         _updateFlag = _updateFlag | 256;
         _useScale = true;
      }
      
      public function get rotation() : Number
      {
         return _rotation;
      }
      
      public function set rotation(param1:Number) : void
      {
         _rotation = param1;
         _updateFlag = _updateFlag | 512;
         _useRotation = true;
      }
      
      public function get rotationX() : Number
      {
         return _rotationX;
      }
      
      public function set rotationX(param1:Number) : void
      {
         _rotationX = param1;
         _updateFlag = _updateFlag | 1024;
         _useRotation = true;
      }
      
      public function get rotationY() : Number
      {
         return _rotationY;
      }
      
      public function set rotationY(param1:Number) : void
      {
         _rotationY = param1;
         _updateFlag = _updateFlag | 2048;
         _useRotation = true;
      }
      
      public function get rotationZ() : Number
      {
         return _rotationZ;
      }
      
      public function set rotationZ(param1:Number) : void
      {
         _rotationZ = param1;
         _updateFlag = _updateFlag | 4096;
         _useRotation = true;
      }
      
      public function get fadeIn() : Boolean
      {
         return _fadeIn;
      }
      
      public function set fadeIn(param1:Boolean) : void
      {
         _fadeIn = param1;
         _updateFlag = _updateFlag | 8192;
      }
      
      public function get fadeOut() : Boolean
      {
         return _fadeOut;
      }
      
      public function set fadeOut(param1:Boolean) : void
      {
         _fadeOut = param1;
         _updateFlag = _updateFlag | 8192;
      }
      
      public function get mouseEnabled() : Boolean
      {
         return _mouseEnabled;
      }
      
      public function set mouseEnabled(param1:Boolean) : void
      {
         _mouseEnabled = param1;
         _updateFlag = _updateFlag | 16384;
      }
      
      public function get mouseChildren() : Boolean
      {
         return _mouseChildren;
      }
      
      public function set mouseChildren(param1:Boolean) : void
      {
         _mouseChildren = param1;
         _updateFlag = _updateFlag | 32768;
      }
      
      public function get $x() : Number
      {
         return _$x;
      }
      
      public function set $x(param1:Number) : void
      {
         _$x = param1;
         _$updateFlag = _$updateFlag | 1;
      }
      
      public function get $y() : Number
      {
         return _$y;
      }
      
      public function set $y(param1:Number) : void
      {
         _$y = param1;
         _$updateFlag = _$updateFlag | 2;
      }
      
      public function get $z() : Number
      {
         return _$z;
      }
      
      public function set $z(param1:Number) : void
      {
         _$z = param1;
         _$updateFlag = _$updateFlag | 4;
      }
      
      public function get $alpha() : Number
      {
         return _$alpha;
      }
      
      public function set $alpha(param1:Number) : void
      {
         _$alpha = param1;
         _$updateFlag = _$updateFlag | 8;
      }
      
      public function get $width() : Number
      {
         return _$width;
      }
      
      public function set $width(param1:Number) : void
      {
         _$width = param1;
         _$updateFlag = _$updateFlag | 16;
         _useSize = true;
      }
      
      public function get $height() : Number
      {
         return _$height;
      }
      
      public function set $height(param1:Number) : void
      {
         _$height = param1;
         _$updateFlag = _$updateFlag | 32;
         _useSize = true;
      }
      
      public function get $scaleX() : Number
      {
         return _$scaleX;
      }
      
      public function set $scaleX(param1:Number) : void
      {
         _$scaleX = param1;
         _$updateFlag = _$updateFlag | 64;
         _useScale = true;
      }
      
      public function get $scaleY() : Number
      {
         return _$scaleY;
      }
      
      public function set $scaleY(param1:Number) : void
      {
         _$scaleY = param1;
         _$updateFlag = _$updateFlag | 128;
         _useScale = true;
      }
      
      public function get $scaleZ() : Number
      {
         return _$scaleZ;
      }
      
      public function set $scaleZ(param1:Number) : void
      {
         _$scaleZ = param1;
         _$updateFlag = _$updateFlag | 256;
         _useScale = true;
      }
      
      public function get $rotation() : Number
      {
         return _$rotation;
      }
      
      public function set $rotation(param1:Number) : void
      {
         _$rotation = param1;
         _$updateFlag = _$updateFlag | 512;
         _useRotation = true;
      }
      
      public function get $rotationX() : Number
      {
         return _$rotationX;
      }
      
      public function set $rotationX(param1:Number) : void
      {
         _$rotationX = param1;
         _$updateFlag = _$updateFlag | 1024;
         _useRotation = true;
      }
      
      public function get $rotationY() : Number
      {
         return _$rotationY;
      }
      
      public function set $rotationY(param1:Number) : void
      {
         _$rotationY = param1;
         _$updateFlag = _$updateFlag | 2048;
         _useRotation = true;
      }
      
      public function get $rotationZ() : Number
      {
         return _$rotationZ;
      }
      
      public function set $rotationZ(param1:Number) : void
      {
         _$rotationZ = param1;
         _$updateFlag = _$updateFlag | 4096;
         _useRotation = true;
      }
      
      public function get $$x() : Number
      {
         return _$$x;
      }
      
      public function set $$x(param1:Number) : void
      {
         _$$x = param1;
         _$$updateFlag = _$$updateFlag | 1;
      }
      
      public function get $$y() : Number
      {
         return _$$y;
      }
      
      public function set $$y(param1:Number) : void
      {
         _$$y = param1;
         _$$updateFlag = _$$updateFlag | 2;
      }
      
      public function get $$z() : Number
      {
         return _$$z;
      }
      
      public function set $$z(param1:Number) : void
      {
         _$$z = param1;
         _$$updateFlag = _$$updateFlag | 4;
      }
      
      public function get $$alpha() : Number
      {
         return _$$alpha;
      }
      
      public function set $$alpha(param1:Number) : void
      {
         _$$alpha = param1;
         _$$updateFlag = _$$updateFlag | 8;
      }
      
      public function get $$width() : Number
      {
         return _$$width;
      }
      
      public function set $$width(param1:Number) : void
      {
         _$$width = param1;
         _$$updateFlag = _$$updateFlag | 16;
         _useSize = true;
      }
      
      public function get $$height() : Number
      {
         return _$$height;
      }
      
      public function set $$height(param1:Number) : void
      {
         _$$height = param1;
         _$$updateFlag = _$$updateFlag | 32;
         _useSize = true;
      }
      
      public function get $$scaleX() : Number
      {
         return _$$scaleX;
      }
      
      public function set $$scaleX(param1:Number) : void
      {
         _$$scaleX = param1;
         _$$updateFlag = _$$updateFlag | 64;
         _useScale = true;
      }
      
      public function get $$scaleY() : Number
      {
         return _$$scaleY;
      }
      
      public function set $$scaleY(param1:Number) : void
      {
         _$$scaleY = param1;
         _$$updateFlag = _$$updateFlag | 128;
         _useScale = true;
      }
      
      public function get $$scaleZ() : Number
      {
         return _$$scaleZ;
      }
      
      public function set $$scaleZ(param1:Number) : void
      {
         _$$scaleZ = param1;
         _$$updateFlag = _$$updateFlag | 256;
         _useScale = true;
      }
      
      public function get $$rotation() : Number
      {
         return _$$rotation;
      }
      
      public function set $$rotation(param1:Number) : void
      {
         _$$rotation = param1;
         _$$updateFlag = _$$updateFlag | 512;
         _useRotation = true;
      }
      
      public function get $$rotationX() : Number
      {
         return _$$rotationX;
      }
      
      public function set $$rotationX(param1:Number) : void
      {
         _$$rotationX = param1;
         _$$updateFlag = _$$updateFlag | 1024;
         _useRotation = true;
      }
      
      public function get $$rotationY() : Number
      {
         return _$$rotationY;
      }
      
      public function set $$rotationY(param1:Number) : void
      {
         _$$rotationY = param1;
         _$$updateFlag = _$$updateFlag | 2048;
         _useRotation = true;
      }
      
      public function get $$rotationZ() : Number
      {
         return _$$rotationZ;
      }
      
      public function set $$rotationZ(param1:Number) : void
      {
         _$$rotationZ = param1;
         _$$updateFlag = _$$updateFlag | 4096;
         _useRotation = true;
      }
   }
}
