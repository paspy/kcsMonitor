package
{
   import common.debug.DebugSettingLoader;
   import common.models.SettingModel;
   import common.util.Util;
   import flash.display.LoaderInfo;
   import flash.events.EventDispatcher;
   
   public final class SettingFacade extends EventDispatcher
   {
      
      private static var _settingData:Object;
      
      private static var _settingModel:SettingModel;
       
      
      public function SettingFacade()
      {
         super();
         _settingData = {};
         _settingModel = new SettingModel();
      }
      
      static function get settingData() : Object
      {
         return _settingData;
      }
      
      public static function get settingModel() : SettingModel
      {
         return _settingModel;
      }
      
      public static function toString() : String
      {
         return JSON.stringify(_settingData);
      }
      
      public static function get DEBUG() : Boolean
      {
         return Util.getBooleanFromInt(_settingData,"debug",false);
      }
      
      public static function set DEBUG(param1:Boolean) : void
      {
         _settingData["debug"] = param1;
      }
      
      public static function get EX_SETTING() : String
      {
         return Util.getString(_settingData,"exSetting");
      }
      
      public static function get IGNORE_SHIP_FILENAME() : Boolean
      {
         return Util.getInt(_settingData,"ignore_ship_filename") == 1;
      }
      
      public static function get IGNORE_JSBRIDGE() : Boolean
      {
         return Util.getInt(_settingData,"ignore_jsbridge") == 1;
      }
      
      public static function get API_TOKEN() : String
      {
         return Util.getString(_settingData,"api_token");
      }
      
      public static function set API_TOKEN(param1:String) : void
      {
         _settingData["api_token"] = param1;
      }
      
      public static function get URLROOT_API() : String
      {
         return Util.getString(_settingData,"url_root_api");
      }
      
      public static function set URLROOT_API(param1:String) : void
      {
         _settingData["url_root_api"] = param1;
      }
      
      public static function get URLROOT_GRAPHIC() : String
      {
         return Util.getString(_settingData,"url_root_graphic");
      }
      
      public static function set URLROOT_GRAPHIC(param1:String) : void
      {
         _settingData["url_root_graphic"] = param1;
      }
      
      public static function get URLROOT_SOUND() : String
      {
         return Util.getString(_settingData,"url_root_sound");
      }
      
      public static function get URLROOT_PURCHASE_IMAGE() : String
      {
         return Util.getString(_settingData,"url_root_purchase_image");
      }
      
      public static function get URLROOT_SHIP() : String
      {
         return URLROOT_GRAPHIC + "swf/ships/";
      }
      
      public static function get URLROOT_FURNITURE() : String
      {
         return URLROOT_GRAPHIC + "image/furniture/";
      }
      
      public static function get URLROOT_SLOTITEM() : String
      {
         return URLROOT_GRAPHIC + "image/slotitem/";
      }
      
      public static function get URLROOT_UITEM() : String
      {
         return URLROOT_GRAPHIC + "image/useitem/";
      }
      
      public static function get LOADER_URL() : String
      {
         return Util.getString(_settingData,"loader_url");
      }
      
      public static function get PROTOCOL_NAME() : String
      {
         return Util.getString(_settingData,"protocol_name");
      }
      
      public static function get DOMAIN_NAME() : String
      {
         return Util.getString(_settingData,"domain_name");
      }
      
      public static function get SWF_PATH() : String
      {
         return Util.getString(_settingData,"swf_path");
      }
      
      public static function get RES_TYPE_SHIP() : String
      {
         return Util.getString(_settingData,"res_ship");
      }
      
      public static function get RES_TYPE_SLOTITEM() : String
      {
         return Util.getString(_settingData,"res_slotitem");
      }
      
      public static function get RES_TYPE_USEITEM() : String
      {
         return Util.getString(_settingData,"res_useitem");
      }
      
      public static function get RES_TYPE_FURNITURE() : String
      {
         return Util.getString(_settingData,"res_furniture");
      }
      
      public static function get ANIMATION_TYPE() : int
      {
         return Util.getInt(_settingData,"animation_type");
      }
      
      public static function getURLROOT_API_Dummy(param1:String) : String
      {
         var _loc2_:Object = Util.getObject(_settingData,"dummy_api",{});
         return Util.getString(_loc2_,param1);
      }
      
      public static function get SOUND_VOLUME_VOICE() : Number
      {
         return settingModel.volumeVoice;
      }
      
      public function initialize(param1:Object, param2:Function) : void
      {
         flashVars = param1;
         completeFunc = param2;
         var loaderInfo:LoaderInfo = AppFacade.root.loaderInfo;
         var loaderURL:String = loaderInfo == null?"file:":loaderInfo.loaderURL;
         _createSetting(loaderURL);
         Util.overWrite(_settingData,flashVars);
         if(EX_SETTING.length > 0)
         {
            new DebugSettingLoader(_settingData,function():void
            {
            });
         }
         else
         {
            completeFunc();
         }
      }
      
      private function _createSetting(param1:String) : void
      {
         var _loc5_:* = null;
         var _loc6_:String = "";
         var _loc2_:String = "";
         var _loc4_:String = "";
         var _loc3_:Array = param1.match(/^[^\/:]+:/);
         if(_loc3_ != null && _loc3_.length > 0)
         {
            _loc4_ = _loc3_[0];
         }
         if(_loc4_ == "http:" || _loc4_ == "https:")
         {
            _loc6_ = param1.match(/^[httpsfile]+:\/{2,3}[0-9a-z\.\-]+\//i)[0];
            _loc5_ = param1.split("/");
            if(_loc5_ is Array)
            {
               _loc5_.pop();
               _loc2_ = _loc5_.join("/") + "/";
            }
         }
         _settingData = _createSettingBase(_loc6_,_loc2_);
         _settingData["loader_url"] = param1;
         _settingData["protocol_name"] = _loc4_;
         _settingData["domain_name"] = _loc6_;
         _settingData["swf_path"] = _loc2_;
         if(PROTOCOL_NAME == "app:" || PROTOCOL_NAME == "file:")
         {
            _settingData["exSetting"] = "setting.json";
         }
      }
      
      private function _createSettingBase(param1:String, param2:String) : Object
      {
         var _loc3_:Object = {
            "debug":0,
            "url_root_api":param1 + "kcsapi/",
            "url_root_graphic":param2 + "resources/",
            "url_root_purchase_image":param2 + "images/purchase_items/",
            "url_root_sound":param2 + "sound/",
            "res_ship":"swf",
            "res_slotitem":"image",
            "res_useitem":"image",
            "res_furniture":"image"
         };
         return _loc3_;
      }
   }
}
