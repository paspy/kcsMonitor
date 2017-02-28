package a24.tween.core.updaters.filters
{
   import a24.tween.core.updaters.abstracts.AbstractBitmapFilterUpdater;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import a24.tween.core.updaters.colors.RGBUpdater;
   import flash.filters.BitmapFilter;
   import flash.filters.GlowFilter;
   
   public final class GlowFilterUpdater extends AbstractBitmapFilterUpdater
   {
       
      
      private var _color:Number;
      
      private var _alpha:Number;
      
      private var _blurX:Number;
      
      private var _blurY:Number;
      
      private var _strength:Number;
      
      private var _quality:Number;
      
      private var _inner:Boolean;
      
      private var _knockout:Boolean;
      
      private var _startAlpha:Number;
      
      private var _startBlurX:Number;
      
      private var _startBlurY:Number;
      
      private var _startStrength:Number;
      
      private var _startQuality:Number;
      
      private var _deltaAlpha:Number;
      
      private var _deltaBlurX:Number;
      
      private var _deltaBlurY:Number;
      
      private var _deltaStrength:Number;
      
      private var _deltaQuality:Number;
      
      private var _filter:GlowFilter;
      
      private var _rgb:RGBUpdater;
      
      public function GlowFilterUpdater()
      {
         super();
      }
      
      public function setProp(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         if(!_rgb)
         {
            _rgb = new RGBUpdater();
         }
         if(!isNaN(param1))
         {
            this.color = param1;
         }
         if(!isNaN(param2))
         {
            this.alpha = param2;
         }
         if(!isNaN(param3))
         {
            this.blurX = param3;
         }
         if(!isNaN(param4))
         {
            this.blurY = param4;
         }
         if(!isNaN(param5))
         {
            this.strength = param5;
         }
         if(!isNaN(param6))
         {
            this.quality = param6;
         }
      }
      
      override public function init(param1:Object, param2:BitmapFilter) : AbstractUpdater
      {
         super.init(param1,param2);
         _target = param1;
         _filter = param2 as GlowFilter;
         if(_tweenFlag & 1)
         {
            _rgb.setProp(_filter.color,_color);
         }
         if(_tweenFlag & 2)
         {
            _startAlpha = _filter.alpha;
            _deltaAlpha = _alpha - _startAlpha;
         }
         if(_tweenFlag & 4)
         {
            _startBlurX = _filter.blurX;
            _deltaBlurX = _blurX - _startBlurX;
         }
         if(_tweenFlag & 8)
         {
            _startBlurY = _filter.blurY;
            _deltaBlurY = _blurY - _startBlurY;
         }
         if(_tweenFlag & 16)
         {
            _startStrength = _filter.strength;
            _deltaStrength = _strength - _startStrength;
         }
         if(_tweenFlag & 32)
         {
            _startQuality = _filter.quality;
            _deltaQuality = _quality - _startQuality;
         }
         if(_tweenFlag & 64)
         {
            _filter.inner = _inner;
         }
         if(_tweenFlag & 128)
         {
            _filter.knockout = _knockout;
         }
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         _filter = getFilter(GlowFilter) as GlowFilter || _filter;
         if(_tweenFlag & 1)
         {
            _filter.color = RGBUpdater(_rgb.update(param1)).getColor();
         }
         if(_tweenFlag & 2)
         {
            _filter.alpha = _startAlpha + _deltaAlpha * param1;
         }
         if(_tweenFlag & 4)
         {
            _filter.blurX = _startBlurX + _deltaBlurX * param1;
         }
         if(_tweenFlag & 8)
         {
            _filter.blurY = _startBlurY + _deltaBlurY * param1;
         }
         if(_tweenFlag & 16)
         {
            _filter.strength = _startStrength + _deltaStrength * param1;
         }
         if(_tweenFlag & 32)
         {
            _filter.quality = _startQuality + _deltaQuality * param1;
         }
         setFilter(_filter,GlowFilter);
         return this;
      }
      
      override public function clone() : AbstractBitmapFilterUpdater
      {
         var _loc1_:GlowFilterUpdater = new GlowFilterUpdater();
         _loc1_.setProp(_color,_alpha,_blurX,_blurY,_strength,_quality);
         _loc1_._inner = _inner;
         _loc1_._knockout = _knockout;
         _loc1_._updateFlag = _updateFlag;
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return formatToString("glow",RGBUpdater.getInt16(_color),_alpha,_blurX,_blurY,_strength,_quality);
      }
      
      public function get color() : Number
      {
         return _color;
      }
      
      public function set color(param1:Number) : void
      {
         _color = param1;
         _updateFlag = _updateFlag | 1;
      }
      
      public function get alpha() : Number
      {
         return _alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         _alpha = param1;
         _updateFlag = _updateFlag | 2;
      }
      
      public function get blurX() : Number
      {
         return _blurX;
      }
      
      public function set blurX(param1:Number) : void
      {
         _blurX = param1;
         _updateFlag = _updateFlag | 4;
      }
      
      public function get blurY() : Number
      {
         return _blurY;
      }
      
      public function set blurY(param1:Number) : void
      {
         _blurY = param1;
         _updateFlag = _updateFlag | 8;
      }
      
      public function get strength() : Number
      {
         return _strength;
      }
      
      public function set strength(param1:Number) : void
      {
         _strength = param1;
         _updateFlag = _updateFlag | 16;
      }
      
      public function get quality() : Number
      {
         return _quality;
      }
      
      public function set quality(param1:Number) : void
      {
         _quality = param1;
         _updateFlag = _updateFlag | 32;
      }
      
      public function get inner() : Boolean
      {
         return _inner;
      }
      
      public function set inner(param1:Boolean) : void
      {
         _inner = param1;
         _updateFlag = _updateFlag | 64;
      }
      
      public function get knockout() : Boolean
      {
         return _knockout;
      }
      
      public function set knockout(param1:Boolean) : void
      {
         _knockout = param1;
         _updateFlag = _updateFlag | 128;
      }
   }
}
