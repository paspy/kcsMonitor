package a24.tween.core.updaters.filters
{
   import a24.tween.core.updaters.abstracts.AbstractBitmapFilterUpdater;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.filters.BitmapFilter;
   import flash.filters.BlurFilter;
   
   public final class BlurFilterUpdater extends AbstractBitmapFilterUpdater
   {
       
      
      private var _blurX:Number;
      
      private var _blurY:Number;
      
      private var _quality:Number;
      
      private var _startBlurX:Number;
      
      private var _startBlurY:Number;
      
      private var _startQuality:Number;
      
      private var _deltaBlurX:Number;
      
      private var _deltaBlurY:Number;
      
      private var _deltaQuality:Number;
      
      private var _filter:BlurFilter;
      
      public function BlurFilterUpdater()
      {
         super();
      }
      
      public function setProp(param1:Number = NaN, param2:Number = NaN, param3:Number = NaN) : void
      {
         if(!isNaN(param1))
         {
            this.blurX = param1;
         }
         if(!isNaN(param2))
         {
            this.blurY = param2;
         }
         if(!isNaN(param3))
         {
            this.quality = param3;
         }
      }
      
      override public function init(param1:Object, param2:BitmapFilter) : AbstractUpdater
      {
         super.init(param1,param2);
         _target = param1;
         _filter = param2 as BlurFilter;
         if(_tweenFlag & 1)
         {
            _startBlurX = _filter.blurX;
            _deltaBlurX = _blurX - _startBlurX;
         }
         if(_tweenFlag & 2)
         {
            _startBlurY = _filter.blurY;
            _deltaBlurY = _blurY - _startBlurY;
         }
         if(_tweenFlag & 4)
         {
            _startQuality = _filter.quality;
            _deltaQuality = _quality - _startQuality;
         }
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         _filter = getFilter(BlurFilter) as BlurFilter || _filter;
         if(_tweenFlag & 1)
         {
            _filter.blurX = _startBlurX + _deltaBlurX * param1;
         }
         if(_tweenFlag & 2)
         {
            _filter.blurY = _startBlurY + _deltaBlurY * param1;
         }
         if(_tweenFlag & 4)
         {
            _filter.quality = _startQuality + _deltaQuality * param1;
         }
         setFilter(_filter,BlurFilter);
         return this;
      }
      
      override public function clone() : AbstractBitmapFilterUpdater
      {
         var _loc1_:BlurFilterUpdater = new BlurFilterUpdater();
         _loc1_.setProp(_blurX,_blurY,_quality);
         _loc1_._updateFlag = _updateFlag;
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return formatToString("blur",_blurX,_blurY,_quality);
      }
      
      public function get blurX() : Number
      {
         return _blurX;
      }
      
      public function set blurX(param1:Number) : void
      {
         _blurX = param1;
         _updateFlag = _updateFlag | 1;
      }
      
      public function get blurY() : Number
      {
         return _blurY;
      }
      
      public function set blurY(param1:Number) : void
      {
         _blurY = param1;
         _updateFlag = _updateFlag | 2;
      }
      
      public function get quality() : Number
      {
         return _quality;
      }
      
      public function set quality(param1:Number) : void
      {
         _quality = param1;
         _updateFlag = _updateFlag | 4;
      }
   }
}
