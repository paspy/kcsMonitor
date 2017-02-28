package a24.tween.core.updaters.filters
{
   import a24.tween.core.updaters.abstracts.AbstractBitmapFilterUpdater;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   
   public final class SaturationUpdater extends AbstractBitmapFilterUpdater
   {
       
      
      private var _filter:ColorMatrixFilter;
      
      private var _saturation:Number;
      
      private var _startSaturate:Number;
      
      private var _progSaturate:Number;
      
      private var _deltaSaturate:Number;
      
      public function SaturationUpdater()
      {
         super();
      }
      
      public function setProp(param1:Number) : void
      {
         if(!isNaN(param1))
         {
            this.saturation = param1;
         }
      }
      
      override public function init(param1:Object, param2:BitmapFilter) : AbstractUpdater
      {
         super.init(param1,param2);
         _target = param1;
         _filter = param2 as ColorMatrixFilter;
         _startSaturate = (_filter.matrix[0] - 0.333333333333333) / 0.666666666666667;
         _progSaturate = _startSaturate;
         _deltaSaturate = _saturation - _startSaturate;
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         var _loc5_:* = NaN;
         var _loc2_:* = NaN;
         var _loc6_:* = NaN;
         var _loc9_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:Number = NaN;
         if(_tweenFlag & 1)
         {
            _progSaturate = _startSaturate + _deltaSaturate * param1;
            _loc5_ = 0.333333333333333;
            _loc2_ = 0.333333333333333;
            _loc6_ = 0.333333333333333;
            _loc9_ = _progSaturate;
            _loc7_ = 1 - _loc9_;
            _loc3_ = _loc5_ * _loc7_;
            _loc8_ = _loc2_ * _loc7_;
            _loc4_ = _loc6_ * _loc7_;
            _filter.matrix = [_loc3_ + _loc9_,_loc8_,_loc4_,0,0,_loc3_,_loc8_ + _loc9_,_loc4_,0,0,_loc3_,_loc8_,_loc4_ + _loc9_,0,0,0,0,0,1,0];
            setFilter(_filter,ColorMatrixFilter);
         }
         return this;
      }
      
      override public function clone() : AbstractBitmapFilterUpdater
      {
         var _loc1_:SaturationUpdater = new SaturationUpdater();
         _loc1_.setProp(_saturation);
         _loc1_._updateFlag = _updateFlag;
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return formatToString("saturation",_saturation);
      }
      
      public function get saturation() : Number
      {
         return _saturation;
      }
      
      public function set saturation(param1:Number) : void
      {
         _saturation = param1;
         _updateFlag = _updateFlag | 1;
      }
   }
}
