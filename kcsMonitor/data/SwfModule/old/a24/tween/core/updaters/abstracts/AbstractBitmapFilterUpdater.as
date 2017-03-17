package a24.tween.core.updaters.abstracts
{
   import flash.filters.BitmapFilter;
   
   public class AbstractBitmapFilterUpdater extends AbstractUpdater
   {
       
      
      protected var _target:Object;
      
      public function AbstractBitmapFilterUpdater()
      {
         super();
      }
      
      public function init(param1:Object, param2:BitmapFilter) : AbstractUpdater
      {
         initFlag();
         return this;
      }
      
      public function clone() : AbstractBitmapFilterUpdater
      {
         return null;
      }
      
      protected function setFilter(param1:BitmapFilter, param2:Class) : void
      {
         var _loc5_:* = 0;
         var _loc4_:Array = _target.filters;
         var _loc3_:uint = _loc4_.length;
         _loc5_ = uint(0);
         while(_loc5_ < _loc3_)
         {
            if(_loc4_[_loc5_] is param2)
            {
               _loc4_[_loc5_] = param1;
               _target.filters = _loc4_;
               return;
            }
            _loc5_++;
         }
         _loc4_.push(param1);
         _target.filters = _loc4_;
      }
      
      protected function getFilter(param1:Class) : BitmapFilter
      {
         var _loc3_:Array = _target.filters;
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            if(_loc2_ is param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
