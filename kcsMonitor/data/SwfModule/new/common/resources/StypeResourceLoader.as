package common.resources
{
   import common.debug.Debug;
   import common.events.BooleanEvent;
   import common.util.SwfVer;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class StypeResourceLoader extends EventDispatcher
   {
       
      
      private var _url:String;
      
      private var _timer:Timer;
      
      private var _uLoader:URLLoader;
      
      private var _loader:Loader;
      
      private var _nowLoading:Boolean = false;
      
      private var _timeouted:Boolean = false;
      
      public function StypeResourceLoader()
      {
         super();
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function get nowLoading() : Boolean
      {
         return _nowLoading;
      }
      
      public function load() : void
      {
         if(Assets.StypeIconMCClass != null)
         {
            dispatchEvent(new BooleanEvent("complete",true));
         }
         else
         {
            _loadStart();
         }
      }
      
      public function cancel() : void
      {
         if(_nowLoading && _uLoader != null)
         {
            _uLoader.close();
         }
      }
      
      private function _loadStart() : void
      {
         _url = SettingFacade.URLROOT_GRAPHIC + "swf/stype.swf";
         var _loc2_:String = SwfVer.STYPE_ASSET;
         if(_loc2_ != null && _loc2_ != "")
         {
            _url = _url + ("?version=" + _loc2_);
         }
         else
         {
            _url = _url + ("?version=" + new Date().getTime());
         }
         _uLoader = new URLLoader();
         _timer = new Timer(5 * 1000,1);
         _nowLoading = true;
         _timer.addEventListener("timerComplete",_handleTimeOut);
         _timer.start();
         var _loc1_:URLRequest = new URLRequest(_url);
         _uLoader.dataFormat = "binary";
         _uLoader.addEventListener("complete",_handleLoadCompleteBinary);
         _uLoader.addEventListener("ioError",_handleLoadErrorBinary);
         _uLoader.load(_loc1_);
      }
      
      private function _handleLoadCompleteBinary(param1:Event) : void
      {
         _nowLoading = false;
         if(_uLoader == null)
         {
            return;
         }
         _uLoader.removeEventListener("complete",_handleLoadCompleteBinary);
         _uLoader.removeEventListener("ioError",_handleLoadErrorBinary);
         _timer.removeEventListener("timerComplete",_handleTimeOut);
         _timer.stop();
         var _loc2_:ByteArray = _uLoader.data;
         _uLoader = null;
         _loadBinary(_loc2_);
      }
      
      private function _handleLoadErrorBinary(param1:IOErrorEvent) : void
      {
         _nowLoading = false;
         if(_uLoader == null)
         {
            return;
         }
         _uLoader.removeEventListener("complete",_handleLoadCompleteBinary);
         _uLoader.removeEventListener("ioError",_handleLoadErrorBinary);
         _timer.removeEventListener("timerComplete",_handleTimeOut);
         _timer.stop();
         dispatchEvent(new BooleanEvent("complete",false));
         _finalize();
      }
      
      private function _handleTimeOut(param1:TimerEvent) : void
      {
         _nowLoading = false;
         _timeouted = true;
         if(_uLoader == null)
         {
            return;
         }
         _uLoader.removeEventListener("complete",_handleLoadCompleteBinary);
         _uLoader.removeEventListener("ioError",_handleLoadErrorBinary);
         _timer.removeEventListener("timerComplete",_handleTimeOut);
         _timer.stop();
         Debug.log("[timeout] " + _url);
         dispatchEvent(new BooleanEvent("complete",false));
         _finalize();
      }
      
      private function _loadBinary(param1:ByteArray) : void
      {
         _loader = new Loader();
         var _loc2_:LoaderContext = new LoaderContext();
         _loc2_.applicationDomain = ApplicationDomain.currentDomain;
         _loader.contentLoaderInfo.addEventListener("complete",_handleLoadComplete);
         _loader.loadBytes(param1,_loc2_);
      }
      
      private function _handleLoadComplete(param1:Event) : void
      {
         _loader.contentLoaderInfo.removeEventListener("complete",_handleLoadComplete);
         dispatchEvent(new BooleanEvent("complete",true));
         _finalize();
      }
      
      private function _finalize() : void
      {
         _timer = null;
         _uLoader = null;
      }
   }
}
