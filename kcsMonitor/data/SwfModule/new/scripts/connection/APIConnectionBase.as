package connection
{
   import common.debug.Debug;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.setTimeout;
   
   public class APIConnectionBase
   {
      
      public static var waitTime:Number = 0;
      
      private static var _COMPLETE:String = "APIConnectionBase::COMPLETE";
       
      
      protected var _API_NAME:String = "";
      
      private var _isSuccess:Boolean = false;
      
      private var _token:String = "";
      
      private var _verno:int = 1;
      
      protected var _url:String = "";
      
      protected var _urlLoader:URLLoader = null;
      
      protected var _urlVariables:URLVariables = null;
      
      private var _eventDispatchTarget:IEventDispatcher = null;
      
      protected var resultObj:Object;
      
      public var resultData:Object;
      
      var recieveFunc:Function;
      
      public function APIConnectionBase(param1:String = "")
      {
         super();
         _token = param1;
         recieveFunc = _handleLoadComplete;
      }
      
      public static function get COMPLETE() : String
      {
         return _COMPLETE;
      }
      
      public function get API_NAME() : String
      {
         return _API_NAME;
      }
      
      public function get isSuccess() : Boolean
      {
         return _isSuccess;
      }
      
      public function load(param1:IEventDispatcher = null) : void
      {
         _eventDispatchTarget = param1;
         if(_token == "")
         {
            _token = SettingFacade.API_TOKEN;
         }
         var _loc3_:String = SettingFacade.getURLROOT_API_Dummy(_url);
         if(_loc3_.length > 0)
         {
            _loc3_ = _loc3_ + _url;
         }
         else
         {
            _loc3_ = SettingFacade.URLROOT_API + _url;
         }
         var _loc2_:URLRequest = new URLRequest(_loc3_);
         _loc2_.method = "POST";
         _urlVariables = new URLVariables();
         _urlVariables.api_token = _token;
         _urlVariables.api_verno = _verno;
         _urlLoader = new URLLoader();
         _urlLoader.addEventListener("complete",__handleLoadComplete);
         _urlLoader.addEventListener("ioError",_handleIOErrorEvent);
         _urlLoader.addEventListener("securityError",_handleSecurityError);
         _preLoad();
         _loc2_.data = _urlVariables;
         _urlLoader.load(_loc2_);
         Debug.log("<-> " + API_NAME + " " + _loc3_);
      }
      
      protected function _preLoad() : void
      {
      }
      
      protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
      }
      
      protected function _getURLLoaderData(param1:URLLoader) : String
      {
         return param1.data;
      }
      
      private function __handleLoadComplete(param1:Event, param2:Boolean = false) : void
      {
         if(param2 == false && waitTime > 0)
         {
            return;
            §§push(setTimeout(__handleLoadComplete,waitTime,param1,true));
         }
         else
         {
            _urlLoader.removeEventListener("complete",__handleLoadComplete);
            _urlLoader.removeEventListener("ioError",_handleIOErrorEvent);
            _urlLoader.removeEventListener("securityError",_handleSecurityError);
            var _loc4_:String = _getURLLoaderData(_urlLoader);
            var _loc3_:Array = _loc4_.match(/svdata=(.*)/);
            var _loc5_:* = "";
            if(_loc3_ && _loc3_.length > 1)
            {
               _loc5_ = _loc3_[1];
            }
            else if(!_loc3_)
            {
               _loc5_ = _loc4_;
            }
            else
            {
               AppFacade.showErrorScreen(API_NAME + " : API result parse error.");
               return;
            }
            _result(_loc5_,param1);
            return;
         }
      }
      
      private function _handleIOErrorEvent(param1:IOErrorEvent) : void
      {
         Debug.log(param1);
         _eventDispatchTarget = null;
         _urlLoader.removeEventListener("complete",__handleLoadComplete);
         _urlLoader.removeEventListener("ioError",_handleIOErrorEvent);
         _urlLoader.removeEventListener("securityError",_handleSecurityError);
         AppFacade.showErrorScreen(API_NAME + " : IOError : " + _url);
      }
      
      private function _handleSecurityError(param1:SecurityErrorEvent) : void
      {
         Debug.log(param1);
         _eventDispatchTarget = null;
         _urlLoader.removeEventListener("complete",__handleLoadComplete);
         _urlLoader.removeEventListener("ioError",_handleIOErrorEvent);
         _urlLoader.removeEventListener("securityError",_handleSecurityError);
         AppFacade.showErrorScreen(API_NAME + " : SecurityError");
      }
      
      private function _result(param1:String, param2:Event = null) : void
      {
         var _loc3_:* = null;
         Debug.log("<-> " + API_NAME + (param2 == null?"[debug]":""));
         resultObj = null;
         try
         {
            resultObj = JSON.parse(param1);
         }
         catch(error:Error)
         {
            AppFacade.showErrorScreen(API_NAME + " : JSON parse error. " + error.message);
            return;
         }
         if(resultObj.api_result != 1)
         {
            AppFacade.showErrorScreen(API_NAME + "[" + resultObj.api_result_msg + "] : API returned failed.");
            return;
         }
         if(_url == "api_start")
         {
            resultObj["api_data"] = {};
            resultObj["api_data"]["api_mst_shipgraph"] = resultObj.api_data_mst_shipgraph;
            delete resultObj["api_data_mst_shipgraph"];
            resultObj["api_mst_slotitemgraph"] = resultObj.api_data_mst_slotitemgraph;
            delete resultObj["api_data_mst_slotitemgraph"];
            resultObj["api_mst_furnituregraph"] = resultObj.api_data_mst_furnituregraph;
            delete resultObj["api_data_mst_furnituregraph"];
         }
         else if(_url == "api_get_member/ship2")
         {
            _loc3_ = resultObj["api_data"];
            resultObj["api_data"] = {};
            resultObj["api_data"]["api_ship"] = _loc3_;
            resultObj["api_data"]["api_deck"] = resultObj["api_data_deck"];
            delete resultObj["api_data_deck"];
         }
         resultData = resultObj.api_data;
         _handleLoadComplete(param2,resultData);
         _isSuccess = true;
         _dispatchCompleteEvent();
      }
      
      protected function _dispatchCompleteEvent() : void
      {
         if(_eventDispatchTarget)
         {
            _eventDispatchTarget.dispatchEvent(new Event(COMPLETE));
            _eventDispatchTarget = null;
         }
      }
   }
}
