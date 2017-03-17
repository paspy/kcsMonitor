package scene
{
   import a24.tween.Tween24;
   import flash.display.LoaderInfo;
   import manager.DebugManager;
   import manager.JSBridgeManager;
   
   public interface IAppRoot
   {
       
      
      function get scenesRoot() : String;
      
      function get loaderInfo() : LoaderInfo;
      
      function get loadProgress() : Number;
      
      function get jsBridgeManager() : JSBridgeManager;
      
      function startApp(param1:Object) : void;
      
      function gotoPort(param1:Boolean = false) : void;
      
      function showErrorScreen(param1:String = "") : void;
      
      function getDebugManager() : DebugManager;
      
      function log(param1:String = null) : void;
      
      function isLoadedSoundBGM() : Boolean;
      
      function isLoadedSoundSE() : Boolean;
      
      function loadSoundBGMTween(param1:Boolean) : Tween24;
      
      function loadSoundSETween(param1:Boolean) : Tween24;
   }
}
