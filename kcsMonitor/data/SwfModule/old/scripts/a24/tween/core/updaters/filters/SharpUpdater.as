package a24.tween.core.updaters.filters
{
   import a24.tween.core.updaters.abstracts.AbstractBitmapFilterUpdater;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.filters.BitmapFilter;
   import flash.filters.ConvolutionFilter;
   
   public final class SharpUpdater extends AbstractBitmapFilterUpdater
   {
       
      
      private var _filter:ConvolutionFilter;
      
      private var _sharpness:Number;
      
      private var _matrix:Array;
      
      private var _startSharpness:Number;
      
      private var _progSharpness:Number;
      
      private var _deltaSharpness:Number;
      
      public function SharpUpdater()
      {
         super();
      }
      
      public function setProp(param1:Number) : void
      {
         if(!isNaN(param1))
         {
            this.sharpness = param1;
         }
      }
      
      override public function init(param1:Object, param2:BitmapFilter) : AbstractUpdater
      {
         super.init(param1,param2);
         _target = param1;
         _filter = param2 as ConvolutionFilter;
         if(!_filter.matrix.length)
         {
            var _loc3_:int = 3;
            _filter.matrixY = _loc3_;
            _filter.matrixX = _loc3_;
            _filter.matrix = [0,0,0,0,1,0,0,0,0];
         }
         _matrix = _filter.matrix;
         _startSharpness = (_filter.matrix[4] - 1) * 0.25;
         _progSharpness = _startSharpness;
         _deltaSharpness = _sharpness - _startSharpness;
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         var _loc2_:Number = NaN;
         if(_tweenFlag & 1)
         {
            _progSharpness = _startSharpness + _deltaSharpness * param1;
            _loc2_ = _startSharpness + _deltaSharpness * param1;
            _matrix[4] = 1 + _loc2_ * 4;
            var _loc3_:* = -_loc2_;
            _matrix[7] = _loc3_;
            _loc3_ = _loc3_;
            _matrix[5] = _loc3_;
            _loc3_ = _loc3_;
            _matrix[3] = _loc3_;
            _matrix[1] = _loc3_;
            _filter.matrix = _matrix;
            setFilter(_filter,ConvolutionFilter);
         }
         return this;
      }
      
      override public function clone() : AbstractBitmapFilterUpdater
      {
         var _loc1_:SharpUpdater = new SharpUpdater();
         _loc1_.setProp(_sharpness);
         _loc1_._updateFlag = _updateFlag;
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return formatToString("sharp",_sharpness);
      }
      
      public function get sharpness() : Number
      {
         return _sharpness;
      }
      
      public function set sharpness(param1:Number) : void
      {
         _sharpness = param1;
         _updateFlag = _updateFlag | 1;
      }
   }
}
