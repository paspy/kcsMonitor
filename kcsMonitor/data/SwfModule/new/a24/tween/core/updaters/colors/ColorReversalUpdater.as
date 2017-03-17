package a24.tween.core.updaters.colors
{
   import a24.tween.core.updaters.abstracts.AbstractDisplayObjectUpdater;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.display.DisplayObject;
   
   public final class ColorReversalUpdater extends AbstractDisplayObjectUpdater
   {
       
      
      private var _value:Number;
      
      private var _ctUpdater:ColorTransformUpdater;
      
      public function ColorReversalUpdater()
      {
         super();
      }
      
      public function setProp(param1:Number) : void
      {
         if(!isNaN(param1))
         {
            this.value = param1;
         }
      }
      
      override public function init(param1:DisplayObject) : AbstractDisplayObjectUpdater
      {
         super.init(param1);
         var _loc2_:Number = _value * 255;
         var _loc3_:Number = _value * -2 + 1;
         if(!_ctUpdater)
         {
            _ctUpdater = new ColorTransformUpdater();
         }
         _ctUpdater.setProp(_loc2_,_loc2_,_loc2_,0,_loc3_,_loc3_,_loc3_,1);
         _ctUpdater.init(_target.transform.colorTransform);
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         if(_tweenFlag & 1)
         {
            _ctUpdater.update(_target,param1);
         }
         return this;
      }
      
      override public function clone() : AbstractDisplayObjectUpdater
      {
         var _loc1_:ColorReversalUpdater = new ColorReversalUpdater();
         _loc1_.setProp(_value);
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return " colorReversal:[" + _value + "]";
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      public function set value(param1:Number) : void
      {
         _value = param1;
         _updateFlag = _updateFlag | 1;
      }
   }
}
