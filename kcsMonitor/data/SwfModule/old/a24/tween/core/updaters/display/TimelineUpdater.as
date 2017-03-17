package a24.tween.core.updaters.display
{
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.display.MovieClip;
   
   public final class TimelineUpdater extends AbstractUpdater
   {
       
      
      private var _target:MovieClip;
      
      private var _frame:int;
      
      private var _startFrame:int;
      
      private var _deltaFrame:int;
      
      public function TimelineUpdater()
      {
         super();
      }
      
      public function setProp(param1:int) : void
      {
         if(!isNaN(param1))
         {
            this.frame = param1;
         }
      }
      
      public function init(param1:MovieClip) : AbstractUpdater
      {
         initFlag();
         _target = param1;
         _startFrame = _target.currentFrame;
         _deltaFrame = _frame - _startFrame;
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         if(_tweenFlag & 1)
         {
            _target.gotoAndStop(int(_startFrame + _deltaFrame * param1));
         }
         return this;
      }
      
      public function clone() : TimelineUpdater
      {
         var _loc1_:TimelineUpdater = new TimelineUpdater();
         _loc1_.setProp(_frame);
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return " frame:" + _frame;
      }
      
      public function get frame() : int
      {
         return _frame;
      }
      
      public function set frame(param1:int) : void
      {
         _frame = param1;
         _updateFlag = _updateFlag | 1;
      }
   }
}
