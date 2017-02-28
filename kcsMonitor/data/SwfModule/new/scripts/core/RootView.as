package core
{
   import common.debug.Debug;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   
   public class RootView extends Sprite
   {
       
      
      private var _mainLayer:Sprite;
      
      private var _errorLayer:Sprite;
      
      private var _debugLayer:Sprite;
      
      public function RootView()
      {
         _mainLayer = new Sprite();
         _errorLayer = new Sprite();
         _debugLayer = new Sprite();
         super();
         _initializeView();
      }
      
      public function get mainLayer() : Sprite
      {
         return _mainLayer;
      }
      
      public function get errorLayer() : Sprite
      {
         return _errorLayer;
      }
      
      public function get debugLayer() : Sprite
      {
         return _debugLayer;
      }
      
      private function _initializeView() : void
      {
         _errorLayer.visible = false;
         _errorLayer.addChild(new ErrorScreen());
         _debugLayer.mouseEnabled = false;
         _debugLayer.mouseChildren = false;
         _debugLayer.visible = false;
         addChild(_mainLayer);
         addChild(_errorLayer);
         addChild(_debugLayer);
      }
      
      public function showErrorScreen(param1:String = "") : void
      {
         mainLayer.visible = false;
         errorLayer.visible = true;
         if(param1 != null && param1.length > 0)
         {
            Debug.log("[ERROR] " + param1);
         }
      }
      
      public function log(param1:String = null) : void
      {
         var _loc2_:* = null;
         if(SettingFacade.DEBUG)
         {
            if(_debugLayer.numChildren)
            {
               _loc2_ = (_debugLayer.getChildAt(0) as Loader).content;
               if(_loc2_ && _loc2_.hasOwnProperty("log") && _loc2_["log"] is Function)
               {
                  _loc2_["log"](param1);
               }
            }
         }
      }
   }
}
