package common.util
{
   import a24.tween.Tween24;
   import common.views.BlockerLayer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import scene.SceneLoader;
   
   public class LoaderThread extends EventDispatcher
   {
      
      public static var RETRY_COUNT_MAX:int = 3;
       
      
      private var _sceneLoader:SceneLoader;
      
      public function LoaderThread(param1:SceneLoader)
      {
         super();
         _sceneLoader = param1;
      }
      
      public function get sceneLoader() : SceneLoader
      {
         return _sceneLoader;
      }
      
      public function createTween(param1:Boolean, param2:IEventDispatcher) : Tween24
      {
         var _loc3_:BlockerLayer = new BlockerLayer();
         return Tween24.serial(Tween24.ifCase(param1,Tween24.serial(Tween24.prop(_loc3_).alpha(0),Tween24.addChild(BlockerLayer.actionBlockLayer,_loc3_),Tween24.tween(_loc3_,0.2).alpha(0.8))),Tween24.parallel(Tween24.waitEvent(this,"complete"),Tween24.func(_load)),Tween24.ifCase(param1,Tween24.serial(Tween24.tween(_loc3_,0.2).alpha(0),Tween24.removeChild(_loc3_))));
      }
      
      protected function _error() : void
      {
         var _loc1_:String = sceneLoader.url;
         _sceneLoader = null;
         AppFacade.showErrorScreen("Load failed. " + _loc1_);
      }
      
      protected function _load(param1:int = 0) : void
      {
         retryCount = param1;
         if(retryCount >= RETRY_COUNT_MAX)
         {
            _error();
         }
         else
         {
            sceneLoader.load(sceneLoader.url,function(param1:SceneLoader):void
            {
               _finalize();
            },function(param1:SceneLoader):void
            {
               _load(retryCount + 1);
            });
         }
      }
      
      protected function _finalize() : void
      {
         _sceneLoader = null;
         dispatchEvent(new Event("complete"));
      }
   }
}
