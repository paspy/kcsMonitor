package
{
   import common.debug.Debug;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import manager.resource.FurnitureImgAttacher;
   import manager.resource.IFurnitureAttacher;
   import manager.resource.IShipAttacher;
   import manager.resource.ISlotitemAttacher;
   import manager.resource.IUseitemAttacher;
   import manager.resource.ShipSwfAttacher;
   import manager.resource.SlotitemImgAttacher;
   import manager.resource.UseitemImgAttacher;
   import scene.IAppRoot;
   import scene.IPortMain;
   
   public final class AppFacade
   {
      
      private static var _START_TIME_:Number = new Date().getTime();
      
      private static var _root:IAppRoot = null;
      
      private static var _portMain:IPortMain = null;
      
      private static var _sceneHolder:Dictionary = new Dictionary();
      
      private static var _globalErrorHandleFunction:Function = null;
       
      
      public function AppFacade()
      {
         super();
      }
      
      public static function get START_TIME() : Number
      {
         return _START_TIME_;
      }
      
      public static function set root(param1:IAppRoot) : void
      {
         _root = param1;
      }
      
      public static function get root() : IAppRoot
      {
         return _root;
      }
      
      public static function set portMain(param1:IPortMain) : void
      {
         _portMain = param1;
      }
      
      public static function get portMain() : IPortMain
      {
         return _portMain;
      }
      
      private static function _setSceneClass(param1:String, param2:Class) : void
      {
         _sceneHolder[param1] = param2;
      }
      
      public static function setSceneClass(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc2_:String = getQualifiedClassName(param1);
         if(param1 is Class)
         {
            _setSceneClass(_loc2_,param1);
         }
         else
         {
            _loc3_ = getDefinitionByName(_loc2_) as Class;
            _setSceneClass(_loc2_,_loc3_);
         }
      }
      
      public static function getSceneClass(param1:String) : Class
      {
         return _sceneHolder[param1];
      }
      
      public static function set globalErrorHandleFunction(param1:Function) : void
      {
         _globalErrorHandleFunction = param1;
      }
      
      public static function get globalErrorHandleFunction() : Function
      {
         return _globalErrorHandleFunction;
      }
      
      public static function createShipAttacher() : IShipAttacher
      {
         return new ShipSwfAttacher();
      }
      
      public static function createSlotitemAttacher() : ISlotitemAttacher
      {
         return new SlotitemImgAttacher();
      }
      
      public static function createFurnitureAttacher() : IFurnitureAttacher
      {
         return new FurnitureImgAttacher();
      }
      
      public static function createUseitemAttacher() : IUseitemAttacher
      {
         return new UseitemImgAttacher();
      }
      
      public static function gotoPort(param1:Boolean = false) : void
      {
         if(_root && _root is IAppRoot)
         {
            _root.gotoPort(param1);
         }
         else
         {
            Debug.log("AppFacade has not root. (gotoPort)");
         }
      }
      
      public static function showErrorScreen(param1:String = null, param2:String = "") : void
      {
         if(_root && _root is IAppRoot)
         {
            var _loc3_:* = param2;
            _root.showErrorScreen(param1);
         }
         else
         {
            Debug.log("AppFacade has not root. (showErrorScreen)");
         }
      }
      
      public static function debugMessage(... rest) : void
      {
         if(_root && _root is IAppRoot)
         {
            _root.log(rest.join(","));
         }
      }
   }
}
