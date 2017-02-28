package a24.tween.core.updaters.colors
{
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   
   public class ColorTransformUpdater
   {
       
      
      private var _redOffset:Number;
      
      private var _greenOffset:Number;
      
      private var _blueOffset:Number;
      
      private var _alphaOffset:Number;
      
      private var _redMultiplier:Number;
      
      private var _greenMultiplier:Number;
      
      private var _blueMultiplier:Number;
      
      private var _alphaMultiplier:Number;
      
      private var _startRedOffset:Number;
      
      private var _startGreenOffset:Number;
      
      private var _startBlueOffset:Number;
      
      private var _startAlphaOffset:Number;
      
      private var _startRedMultiplier:Number;
      
      private var _startGreenMultiplier:Number;
      
      private var _startBlueMultiplier:Number;
      
      private var _startAlphaMultiplier:Number;
      
      private var _deltaRedOffset:Number;
      
      private var _deltaGreenOffset:Number;
      
      private var _deltaBlueOffset:Number;
      
      private var _deltaAlphaOffset:Number;
      
      private var _deltaRedMultiplier:Number;
      
      private var _deltaGreenMultiplier:Number;
      
      private var _deltaBlueMultiplier:Number;
      
      private var _deltaAlphaMultiplier:Number;
      
      private var _compRedOffset:Number;
      
      private var _compGreenOffset:Number;
      
      private var _compBlueOffset:Number;
      
      private var _compAlphaOffset:Number;
      
      private var _compRedMultiplier:Number;
      
      private var _compGreenMultiplier:Number;
      
      private var _compBlueMultiplier:Number;
      
      private var _compAlphaMultiplier:Number;
      
      public function ColorTransformUpdater()
      {
         super();
      }
      
      public function setProp(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void
      {
         _compRedOffset = param1;
         _compGreenOffset = param2;
         _compBlueOffset = param3;
         _compAlphaOffset = param4;
         _compRedMultiplier = param5;
         _compGreenMultiplier = param6;
         _compBlueMultiplier = param7;
         _compAlphaMultiplier = param8;
      }
      
      public function init(param1:ColorTransform) : void
      {
         _startRedOffset = param1.redOffset;
         _startGreenOffset = param1.greenOffset;
         _startBlueOffset = param1.blueOffset;
         _startAlphaOffset = param1.alphaOffset;
         _startRedMultiplier = param1.redMultiplier;
         _startGreenMultiplier = param1.greenMultiplier;
         _startBlueMultiplier = param1.blueMultiplier;
         _startAlphaMultiplier = param1.alphaMultiplier;
         if(!isNaN(_compRedOffset))
         {
            _deltaRedOffset = _compRedOffset - _startRedOffset;
         }
         if(!isNaN(_compGreenOffset))
         {
            _deltaGreenOffset = _compGreenOffset - _startGreenOffset;
         }
         if(!isNaN(_compBlueOffset))
         {
            _deltaBlueOffset = _compBlueOffset - _startBlueOffset;
         }
         if(!isNaN(_compAlphaOffset))
         {
            _deltaAlphaOffset = _compAlphaOffset - _startAlphaOffset;
         }
         if(!isNaN(_compRedMultiplier))
         {
            _deltaRedMultiplier = _compRedMultiplier - _startRedMultiplier;
         }
         if(!isNaN(_compGreenMultiplier))
         {
            _deltaGreenMultiplier = _compGreenMultiplier - _startGreenMultiplier;
         }
         if(!isNaN(_compBlueMultiplier))
         {
            _deltaBlueMultiplier = _compBlueMultiplier - _startBlueMultiplier;
         }
         if(!isNaN(_compAlphaMultiplier))
         {
            _deltaAlphaMultiplier = _compAlphaMultiplier - _startAlphaMultiplier;
         }
      }
      
      public function update(param1:DisplayObject, param2:Number) : void
      {
         var _loc3_:ColorTransform = param1.transform.colorTransform;
         if(!isNaN(_compRedOffset))
         {
            _redOffset = _startRedOffset + _deltaRedOffset * param2;
            _loc3_.redOffset = _startRedOffset + _deltaRedOffset * param2;
         }
         if(!isNaN(_compGreenOffset))
         {
            _greenOffset = _startGreenOffset + _deltaGreenOffset * param2;
            _loc3_.greenOffset = _startGreenOffset + _deltaGreenOffset * param2;
         }
         if(!isNaN(_compBlueOffset))
         {
            _blueOffset = _startBlueOffset + _deltaBlueOffset * param2;
            _loc3_.blueOffset = _startBlueOffset + _deltaBlueOffset * param2;
         }
         if(!isNaN(_compAlphaOffset))
         {
            _alphaOffset = _startAlphaOffset + _deltaAlphaOffset * param2;
            _loc3_.alphaOffset = _startAlphaOffset + _deltaAlphaOffset * param2;
         }
         if(!isNaN(_compRedMultiplier))
         {
            _redMultiplier = _startRedMultiplier + _deltaRedMultiplier * param2;
            _loc3_.redMultiplier = _startRedMultiplier + _deltaRedMultiplier * param2;
         }
         if(!isNaN(_compGreenMultiplier))
         {
            _greenMultiplier = _startGreenMultiplier + _deltaGreenMultiplier * param2;
            _loc3_.greenMultiplier = _startGreenMultiplier + _deltaGreenMultiplier * param2;
         }
         if(!isNaN(_compBlueMultiplier))
         {
            _blueMultiplier = _startBlueMultiplier + _deltaBlueMultiplier * param2;
            _loc3_.blueMultiplier = _startBlueMultiplier + _deltaBlueMultiplier * param2;
         }
         if(!isNaN(_compAlphaMultiplier))
         {
            _alphaMultiplier = _startAlphaMultiplier + _deltaAlphaMultiplier * param2;
            _loc3_.alphaMultiplier = _startAlphaMultiplier + _deltaAlphaMultiplier * param2;
         }
         param1.transform.colorTransform = _loc3_;
      }
      
      public function complete() : void
      {
         if(!isNaN(_compRedOffset))
         {
            _redOffset = _compRedOffset;
         }
         if(!isNaN(_compGreenOffset))
         {
            _greenOffset = _compGreenOffset;
         }
         if(!isNaN(_compBlueOffset))
         {
            _blueOffset = _compBlueOffset;
         }
         if(!isNaN(_compAlphaOffset))
         {
            _alphaOffset = _compAlphaOffset;
         }
         if(!isNaN(_compRedMultiplier))
         {
            _redMultiplier = _compRedMultiplier;
         }
         if(!isNaN(_compGreenMultiplier))
         {
            _greenMultiplier = _compGreenMultiplier;
         }
         if(!isNaN(_compBlueMultiplier))
         {
            _blueMultiplier = _compBlueMultiplier;
         }
         if(!isNaN(_compAlphaMultiplier))
         {
            _alphaMultiplier = _compAlphaMultiplier;
         }
      }
      
      public function get redOffset() : Number
      {
         return _redOffset;
      }
      
      public function get greenOffset() : Number
      {
         return _greenOffset;
      }
      
      public function get blueOffset() : Number
      {
         return _blueOffset;
      }
      
      public function get alphaOffset() : Number
      {
         return _alphaOffset;
      }
      
      public function get redMultiplier() : Number
      {
         return _redMultiplier;
      }
      
      public function get greenMultiplier() : Number
      {
         return _greenMultiplier;
      }
      
      public function get blueMultiplier() : Number
      {
         return _blueMultiplier;
      }
      
      public function get alphaMultiplier() : Number
      {
         return _alphaMultiplier;
      }
   }
}
