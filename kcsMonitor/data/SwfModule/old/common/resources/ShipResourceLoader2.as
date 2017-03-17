package common.resources
{
   import common.events.BooleanEvent;
   import common.util.Util;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import manager.CacheManager;
   
   public class ShipResourceLoader2 extends Loader
   {
       
      
      protected var _mstId:int;
      
      protected var _preset_frameNo:int = 0;
      
      protected var _timer:Timer;
      
      protected var _urlLoader:URLLoader = null;
      
      public function ShipResourceLoader2(param1:int, param2:int = 0)
      {
         super();
         _mstId = param1;
         _preset_frameNo = param2;
      }
      
      public function get mstID() : int
      {
         return _mstId;
      }
      
      public function getFileName() : String
      {
         var _loc1_:String = DataFacade.getStartData().getShipFileName(_mstId);
         if(_loc1_ != "" && SettingFacade.IGNORE_SHIP_FILENAME == false)
         {
            return _loc1_;
         }
         return _mstId.toString();
      }
      
      public function getURLString() : String
      {
         var _loc1_:String = getFileName();
         var _loc2_:String = SettingFacade.URLROOT_SHIP + getFileName() + _getURLSuffix() + ".swf";
         var _loc3_:String = DataFacade.getStartData().getShipVersion(_mstId);
         if(_loc3_ != null && _loc3_ != "" && _loc3_ != "1")
         {
            _loc2_ = _loc2_ + ("?VERSION=" + _loc3_);
         }
         return _loc2_;
      }
      
      public function getMovieClip() : MovieClip
      {
         if(content == null)
         {
            return null;
         }
         return content as MovieClip;
      }
      
      public function startLoad() : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_urlLoader != null)
         {
            return false;
         }
         var _loc1_:ByteArray = CacheManager.getCacheShipResource(_mstId);
         if(_loc1_ != null)
         {
            _loadBytes(_loc1_);
            return true;
         }
         _urlLoader = new URLLoader();
         _timer = new Timer(5 * 1000,1);
         _timer.addEventListener("timerComplete",_handleTimeOut);
         _timer.start();
         _loc3_ = getURLString();
         _loc2_ = new URLRequest(_loc3_);
         _urlLoader.dataFormat = "binary";
         _urlLoader.addEventListener("complete",_handleLoadCompleteBinary);
         _urlLoader.addEventListener("ioError",_handleLoadErrorBinary);
         _urlLoader.load(_loc2_);
         return true;
      }
      
      public function cancel() : void
      {
      }
      
      private function _handleLoadCompleteBinary(param1:Event) : void
      {
         _timer.removeEventListener("timerComplete",_handleTimeOut);
         _timer.stop();
         _timer = null;
         _urlLoader.removeEventListener("complete",_handleLoadCompleteBinary);
         _urlLoader.removeEventListener("ioError",_handleLoadErrorBinary);
         var _loc2_:ByteArray = _urlLoader.data as ByteArray;
         _urlLoader = null;
         if(_loc2_ == null)
         {
            dispatchEvent(new BooleanEvent("complete",false));
         }
         _loadBytes(_loc2_);
      }
      
      private function _handleLoadErrorBinary(param1:IOErrorEvent) : void
      {
         _timer.removeEventListener("timerComplete",_handleTimeOut);
         _timer.stop();
         _timer = null;
         _urlLoader.removeEventListener("complete",_handleLoadCompleteBinary);
         _urlLoader.removeEventListener("ioError",_handleLoadErrorBinary);
         _urlLoader = null;
         dispatchEvent(new BooleanEvent("complete",false));
      }
      
      private function _handleTimeOut(param1:TimerEvent) : void
      {
         if(_urlLoader != null)
         {
            _handleLoadErrorBinary(null);
            return;
         }
      }
      
      protected function _loadBytes(param1:ByteArray) : void
      {
         contentLoaderInfo.addEventListener("complete",_handleLoadComplete);
         super.loadBytes(param1);
      }
      
      private function _handleLoadComplete(param1:Event) : void
      {
         contentLoaderInfo.removeEventListener("complete",_handleLoadComplete);
         CacheManager.setCacheShipResource(_mstId,this);
         var _loc2_:MovieClip = content as MovieClip;
         if(_loc2_ != null)
         {
            if(_preset_frameNo > 0)
            {
               _loc2_.gotoAndStop(_preset_frameNo);
            }
            else
            {
               _loc2_.gotoAndStop(1);
            }
            _loc2_.visible = true;
         }
         dispatchEvent(new BooleanEvent("complete",true));
      }
      
      private function _getURLSuffix() : String
      {
         var _loc1_:Object = Util.getObject(ShipResourceLoader.option,_mstId.toString());
         return Util.getString(_loc1_,"suffix");
      }
   }
}
