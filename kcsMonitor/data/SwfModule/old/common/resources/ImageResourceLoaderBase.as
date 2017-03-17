package common.resources
{
   import common.debug.Debug;
   import common.events.BooleanEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class ImageResourceLoaderBase extends EventDispatcher
   {
       
      
      protected var _mstId:int;
      
      protected var _type:String;
      
      protected var _parent:DisplayObjectContainer;
      
      protected var _errorImgCls:Class;
      
      private var _url:String;
      
      private var _timer:Timer;
      
      private var _uLoader:URLLoader;
      
      private var _nowLoading:Boolean = false;
      
      private var _timeouted:Boolean = false;
      
      public function ImageResourceLoaderBase(param1:int, param2:String, param3:DisplayObjectContainer, param4:Class)
      {
         super();
         _mstId = param1;
         _type = param2;
         _parent = param3;
         _errorImgCls = param4;
         _url = _createURLString();
         _uLoader = new URLLoader();
         _timer = new Timer(5 * 1000,1);
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
         _nowLoading = true;
         _timer.addEventListener("timerComplete",_handleTimeOut);
         _timer.start();
         var _loc1_:URLRequest = new URLRequest(_url);
         _uLoader.dataFormat = "binary";
         _uLoader.addEventListener("complete",_handleLoadCompleteBinary);
         _uLoader.addEventListener("ioError",_handleLoadErrorBinary);
         _uLoader.load(_loc1_);
      }
      
      public function cancel() : void
      {
         if(_nowLoading && _uLoader != null)
         {
            _uLoader.close();
         }
      }
      
      protected function _finalize() : void
      {
         _parent = null;
         _errorImgCls = null;
         _timer = null;
         _uLoader = null;
      }
      
      protected function _createURLString() : String
      {
         return "";
      }
      
      protected function _preShow(param1:Loader) : void
      {
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
         _load(_loc2_);
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
         if(_parent && _errorImgCls)
         {
            _parent.addChild(new Bitmap(new _errorImgCls()));
         }
         dispatchEvent(new BooleanEvent("complete",false));
         _finalize();
      }
      
      private function _handleTimeOut(param1:TimerEvent) : void
      {
         var _loc2_:* = null;
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
         if(_parent && _errorImgCls)
         {
            _loc2_ = new Bitmap(new _errorImgCls());
            _loc2_.smoothing = true;
            _parent.addChild(_loc2_);
         }
         dispatchEvent(new BooleanEvent("complete",false));
         _finalize();
      }
      
      protected function _load(param1:ByteArray) : void
      {
         var _loc2_:Loader = new Loader();
         _loc2_.contentLoaderInfo.addEventListener("complete",_handleLoadComplete);
         _loc2_.loadBytes(param1);
      }
      
      private function _handleLoadComplete(param1:Event) : void
      {
         var _loc2_:Loader = (param1.target as LoaderInfo).loader;
         _loc2_.contentLoaderInfo.removeEventListener("complete",_handleLoadComplete);
         _preShow(_loc2_);
         if(_parent)
         {
            _parent.addChild(_loc2_);
         }
         dispatchEvent(new BooleanEvent("complete",true));
         _finalize();
      }
   }
}
