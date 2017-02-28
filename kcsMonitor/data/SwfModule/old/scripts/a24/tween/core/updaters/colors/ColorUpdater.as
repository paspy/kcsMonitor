package a24.tween.core.updaters.colors
{
   import a24.tween.core.updaters.abstracts.AbstractDisplayObjectUpdater;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   
   public final class ColorUpdater extends AbstractDisplayObjectUpdater
   {
       
      
      private var _color:Number;
      
      private var _alpha:Number;
      
      private var _ctUpdater:ColorTransformUpdater;
      
      public function ColorUpdater()
      {
         super();
      }
      
      public function setProp(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         if(!isNaN(param1))
         {
            this.color = param1;
         }
         var _loc4_:Number = !!param3?0:Number(!!param2?param2:0.0588235294117647);
         this.alpha = param2 >= 0.99?1:Number(_loc4_);
      }
      
      override public function init(param1:DisplayObject) : AbstractDisplayObjectUpdater
      {
         super.init(param1);
         var _loc6_:ColorTransform = _target.transform.colorTransform;
         var _loc3_:Number = 1 - _alpha;
         var _loc5_:Number = !!isNaN(_color)?_loc6_.redOffset / (1 - _loc6_.redMultiplier) * _alpha:Number((_color >> 16 & 255) * _alpha);
         var _loc2_:Number = !!isNaN(_color)?_loc6_.greenOffset / (1 - _loc6_.greenMultiplier) * _alpha:Number((_color >> 8 & 255) * _alpha);
         var _loc4_:Number = !!isNaN(_color)?_loc6_.blueOffset / (1 - _loc6_.blueMultiplier) * _alpha:Number((_color & 255) * _alpha);
         if(!_ctUpdater)
         {
            _ctUpdater = new ColorTransformUpdater();
         }
         _ctUpdater.setProp(_loc5_,_loc2_,_loc4_,0,_loc3_,_loc3_,_loc3_,_target.alpha);
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
      
      override public function complete() : void
      {
         super.complete();
      }
      
      override public function clone() : AbstractDisplayObjectUpdater
      {
         var _loc1_:ColorUpdater = new ColorUpdater();
         _loc1_.setProp(_color,_alpha);
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return " color:[" + RGBUpdater.getInt16(_color) + " " + _alpha + "]";
      }
      
      public function get color() : int
      {
         return _color;
      }
      
      public function set color(param1:int) : void
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
         _updateFlag = _updateFlag | 1;
      }
   }
}
