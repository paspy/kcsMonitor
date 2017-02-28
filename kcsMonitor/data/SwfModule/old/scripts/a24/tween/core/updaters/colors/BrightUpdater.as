package a24.tween.core.updaters.colors
{
   import a24.tween.core.updaters.abstracts.AbstractDisplayObjectUpdater;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.display.DisplayObject;
   
   public final class BrightUpdater extends AbstractDisplayObjectUpdater
   {
       
      
      private var _brightness:Number;
      
      private var _ctUpdater:ColorTransformUpdater;
      
      public function BrightUpdater()
      {
         super();
      }
      
      public function setProp(param1:Number) : void
      {
         this.brightness = param1;
      }
      
      override public function init(param1:DisplayObject) : AbstractDisplayObjectUpdater
      {
         super.init(param1);
         var _loc2_:Number = _brightness * 100;
         if(!_ctUpdater)
         {
            _ctUpdater = new ColorTransformUpdater();
         }
         _ctUpdater.setProp(_loc2_,_loc2_,_loc2_,0,1,1,1,NaN);
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
         var _loc1_:BrightUpdater = new BrightUpdater();
         _loc1_.setProp(_brightness);
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return " bright:" + _brightness;
      }
      
      public function get brightness() : Number
      {
         return _brightness;
      }
      
      public function set brightness(param1:Number) : void
      {
         _brightness = param1;
         _updateFlag = _updateFlag | 1;
      }
   }
}
