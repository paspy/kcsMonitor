package common.resources
{
   import common.debug.Debug;
   import common.util.MathUtil;
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
   
   public class MapResourceLoader extends EventDispatcher
   {
       
      
      private var _areaID:int;
      
      private var _mapNo:int;
      
      private var _keyStr:String;
      
      private var _url:String;
      
      private var _uLoader:URLLoader;
      
      private var _loader:Loader;
      
      private var _timer:Timer;
      
      private var _nowLoading:Boolean = false;
      
      private const RND:Array = [3367,28012,6269,26478,24442,27255,28017,3366,6779,7677,7179,28011,24421,27502,3366,7779,24439,27762,6474,7463,28515,5164,6672,28006,27999,27254,7363,6868,13420,6464,7376,28268,6968,7276,29806,28778,27511,7163,25964,7870,29549,31084,7063,7163,7969,6674,7934,6774,6768,27769,7476,7272,28279,30572,6763,27759,7768,27768,7864,28535,27235,7968,7373,27769,27751,3479,27497,6769,28272,7264,7773,6878,6178,7673,6671,6673,26476,6367,7162,28021,7773,6573,27251,27188,7778,27255,27750,7268,6763,27500,6664,7369,25199,31353,25455,7875,7369,7464,7262,6376,7370,27245,3474,7469,28535,28536,6276,30827,31349,7071,30059,26991,6771,6266,6572,7570,6469,27752,28258,7573,7334,6666,6573,27768,7575,28261,25199,6366,6268,7975,7268,7176,27509,6164,7662,6470,6368,7075,30062,3461,27234,26479,7977,6962,28015,27747,27766,28270,28017,27495,28016,6379,28015,29550,25964,27755,28522,7651,6466,29293,26221,24426,7673,6368,6835,31329,26475,7473,6169,6478,27999,6161,27491,6765,7579,6468,26463,31336,6562,7564,6773,3564,7473,7564,30570,6274,6363,6663,7670,7173,27249,7278,28259,7974,6670,7578,6463,7835,26207,25466,6173,27495,6664,6268,7272,24441,29039,26734,6262,7979,24938,6768,27493,7574,3579,6673,27508,28274,6261,26988,6463,6362,6166,26475,6663,27241,7876,28270,6475,6766,31286,28278,28270,28520,27498,31086,7077,27242,6966,26219,7069,28514,27760,6971,27256,7363,27244,3677,6669,6270,7362,6879,6971,27503,6778,7879,7376,6375,27756,6965,7163,7367,6579,7236,7873,30829,6975,6367,28521,26733,7972,30317,6977,6376,27501,27239,30063,28262,6870,6773,3669,6361,7973,27769,6777,28518,27757,27252,6677,27242,6471,6566,27235,31346,7270,6364,6536,7566,6471,6371,28025,29039,30315,29546,27495,6763,7576,6979,31087,27760,7167,7673,6662,3770,6477,6369,25966,6472,31333,7378,27240,6968,7273,28277,7769,6863,27002,7573,7279,6337,30059,28002,6968,6568,28269,6578,28263,7570,26987,7865,6478,7870,29562,24942,7872,6967,3779,25962,6467,29549,7365,7378,7272,6273,28260,7361,6573,28005,7772,30571,25978,6667,27473,6466,29293,26221,24426,7673,6368,6800];
      
      public function MapResourceLoader(param1:int, param2:int, param3:Loader)
      {
         super();
         _areaID = param1;
         _mapNo = param2;
         _keyStr = MathUtil.digit2(_areaID) + "_" + MathUtil.digit2(_mapNo);
         _url = _createURLString();
         _loader = param3;
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function get nowLoading() : Boolean
      {
         return _nowLoading;
      }
      
      public function get loader() : Loader
      {
         return _loader;
      }
      
      public function load() : Boolean
      {
         if(_nowLoading)
         {
            return false;
         }
         _nowLoading = true;
         _timer = new Timer(30000,1);
         _uLoader = new URLLoader();
         _uLoader.dataFormat = "binary";
         _uLoader.addEventListener("complete",_handleLoadCompleteBinary);
         _uLoader.addEventListener("ioError",_handleIOErrorBinary);
         var _loc1_:URLRequest = new URLRequest(_url);
         _timer.addEventListener("timerComplete",_handleTimeOut);
         _timer.start();
         _uLoader.load(_loc1_);
         return true;
      }
      
      public function cancel() : void
      {
         if(_uLoader != null)
         {
            _uLoader.removeEventListener("complete",_handleLoadCompleteBinary);
            _uLoader.removeEventListener("ioError",_handleIOErrorBinary);
            _timer.removeEventListener("timerComplete",_handleTimeOut);
            _timer.stop();
            _nowLoading = false;
            _uLoader = null;
            _timer = null;
            _loader = null;
         }
      }
      
      private function _createURLString() : String
      {
         var _loc2_:String = "";
         if(SwfVer.MAP.hasOwnProperty(_keyStr))
         {
            _loc2_ = "?version=" + SwfVer.MAP[_keyStr];
         }
         var _loc1_:String = _convertName(_areaID,_mapNo);
         if(_loc1_ == null)
         {
            return SettingFacade.URLROOT_GRAPHIC + "swf/map/" + _keyStr + ".swf" + _loc2_;
         }
         return SettingFacade.URLROOT_GRAPHIC + "swf/map/" + _loc1_ + ".swf" + _loc2_;
      }
      
      private function _handleLoadCompleteBinary(param1:Event) : void
      {
         _uLoader.removeEventListener("complete",_handleLoadCompleteBinary);
         _uLoader.removeEventListener("ioError",_handleIOErrorBinary);
         _timer.removeEventListener("timerComplete",_handleTimeOut);
         _timer.stop();
         var _loc2_:ByteArray = _uLoader.data as ByteArray;
         _uLoader = null;
         _timer = null;
         _loadFromBinary(_loc2_);
      }
      
      private function _handleIOErrorBinary(param1:IOErrorEvent) : void
      {
         _uLoader.removeEventListener("complete",_handleLoadCompleteBinary);
         _uLoader.removeEventListener("ioError",_handleIOErrorBinary);
         _timer.removeEventListener("timerComplete",_handleTimeOut);
         _timer.stop();
         _nowLoading = false;
         _uLoader = null;
         _timer = null;
         _loader = null;
         Debug.log("[LoadError]: " + _url);
         dispatchEvent(new Event("complete"));
      }
      
      private function _handleTimeOut(param1:TimerEvent) : void
      {
         _uLoader.removeEventListener("complete",_handleLoadCompleteBinary);
         _uLoader.removeEventListener("ioError",_handleIOErrorBinary);
         _timer.removeEventListener("timerComplete",_handleTimeOut);
         _timer.stop();
         _nowLoading = false;
         _uLoader = null;
         _timer = null;
         _loader = null;
         Debug.log("[LoadError(timeout)]: " + _url);
         dispatchEvent(new Event("complete"));
      }
      
      private function _loadFromBinary(param1:ByteArray) : void
      {
         var _loc2_:LoaderContext = new LoaderContext();
         _loc2_.applicationDomain = ApplicationDomain.currentDomain;
         _loc2_.allowCodeImport = true;
         _loader.contentLoaderInfo.addEventListener("complete",_handleLoadComplete);
         _loader.loadBytes(param1,_loc2_);
      }
      
      private function _handleLoadComplete(param1:Event = null) : void
      {
         _loader.contentLoaderInfo.removeEventListener("complete",_handleLoadComplete);
         dispatchEvent(new Event("complete"));
      }
      
      private function _convertName(param1:int, param2:int) : String
      {
         var _loc4_:* = null;
         var _loc11_:int = 0;
         var _loc8_:* = 0;
         var _loc3_:int = 0;
         var _loc10_:String = /./(/..$/(/./[/./(/.. /({})) + /.$/(/../({})) + /./(/./([])) + /./(/..$/(!{})) + /.../(!!{}) + /../(/.. /({})) + /.$/(/../({})) + /.$/(/../(!!{}))])) + /./(/..$/(!!{})) + /./(/..$/(!{})) + (/./(~(~[][{}] << ~[][{}])) << /./(/....$/(~(~[][{}] << ~[][{}]))) | ~[][{}] >>> ~[][{}])[/./(!!{}) + /.$/(/../({})) + /....../(/.......$/(""[/.$/(/....../({})) + /.$/(/../({})) + /.$/(/../([][{}])) + /./(/..$/(!{})) + /.../(!!{}) + /.$/(/....../({})) + /.$/(/......./({})) + /.$/(/../({})) + /.$/(/../(!!{}))]))]((/./(/..$/(~(~[][{}] << ~[][{}]))) | ~[][{}] >>> ~[][{}]) << /./(~(~[][{}] << ~[][{}])));
         var _loc7_:Array = [];
         var _loc9_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:String = "";
         _loc11_ = 0;
         while(_loc11_ < RND.length)
         {
            _loc5_ = RND[_loc11_] > 10000?RND[_loc11_].toString(16):RND[_loc11_].toString();
            _loc7_[_loc10_](_loc5_.substr(0,2));
            _loc7_[_loc10_](_loc5_.substr(2,2));
            _loc11_++;
         }
         _loc5_ = "";
         _loc11_ = 0;
         while(_loc11_ < _loc7_.length)
         {
            _loc3_ = parseInt(_loc7_[_loc11_],16);
            if(_loc3_ < 90)
            {
               if(_loc5_ != "")
               {
                  _loc9_[_loc10_]([parseInt(_loc8_.toString(16)),_loc5_]);
                  _loc5_ = "";
               }
               _loc8_ = _loc3_;
            }
            else
            {
               _loc5_ = _loc5_ + String.fromCharCode(_loc3_);
            }
            _loc11_++;
         }
         _loc9_[_loc10_]([_loc8_,_loc5_]);
         _loc11_ = 0;
         while(_loc11_ < _loc9_.length)
         {
            if(_loc9_[_loc11_][0] == param1)
            {
               _loc6_++;
               if(_loc6_ == param2)
               {
                  _loc4_ = _loc9_[_loc11_][1];
                  break;
               }
            }
            _loc11_++;
         }
         return _loc4_;
      }
   }
}
