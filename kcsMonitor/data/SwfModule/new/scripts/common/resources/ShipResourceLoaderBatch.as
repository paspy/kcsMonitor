package common.resources
{
   import a24.tween.Tween24;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ShipResourceLoaderBatch extends EventDispatcher
   {
       
      
      private var _complete_with_dispose:Boolean;
      
      private var _loaders:Vector.<ShipResourceLoader2>;
      
      private var _t:Tween24 = null;
      
      private var _batch_completed:Boolean = false;
      
      public function ShipResourceLoaderBatch(param1:Boolean = true)
      {
         super();
         _complete_with_dispose = param1;
         _loaders = new Vector.<ShipResourceLoader2>();
      }
      
      public function get Loaders() : Vector.<ShipResourceLoader2>
      {
         return _loaders;
      }
      
      public function addMstID(param1:int, param2:int = 0) : ShipResourceLoader2
      {
         var _loc3_:ShipResourceLoader2 = null;
         if(_t == null && _batch_completed == false)
         {
            _loc3_ = new ShipResourceLoader2(param1,param2);
            _loaders.push(_loc3_);
         }
         return _loc3_;
      }
      
      public function startLoad() : Boolean
      {
         if(_t != null || _batch_completed == true)
         {
            return false;
         }
         _t = _createTween();
         _t.onComplete(_loadComplete);
         _t.play();
         return true;
      }
      
      public function stopLoad() : Boolean
      {
         if(_t == null)
         {
            return false;
         }
         if(_t.playing == true)
         {
            _t.stop();
         }
         return true;
      }
      
      public function dispose() : void
      {
         _loaders = null;
      }
      
      private function _loadComplete() : void
      {
         _batch_completed = true;
         if(_complete_with_dispose == true)
         {
            dispose();
         }
         dispatchEvent(new Event("complete"));
      }
      
      private function _createTween() : Tween24
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         if(_loaders.length == 0)
         {
            return Tween24.wait(0);
         }
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _loaders.length)
         {
            _loc1_ = _loaders[_loc3_];
            _loc2_.push(Tween24.parallel(Tween24.waitEvent(_loc1_,"complete"),Tween24.func(_loc1_.startLoad)));
            _loc3_++;
         }
         return Tween24.serial(_loc2_);
      }
   }
}
