package scene
{
   import common.debug.Debug;
   import common.util.SwfVer;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class SceneLoader
   {
       
      
      private var _path:String;
      
      private var _version:String;
      
      private var _loader:Loader;
      
      private var _url:String;
      
      private var _urlReq:URLRequest;
      
      private var _compFunc:Function = null;
      
      private var _failFunc:Function = null;
      
      private var _bytesLoaded:Number = 0;
      
      private var _bytesTotal:Number = 1.7976931348623157E308;
      
      public var loadID:String = "";
      
      public function SceneLoader(param1:String, param2:String)
      {
         super();
         _path = param1;
         _version = param2;
         if(_version == "")
         {
            _version = new Date().time.toString();
         }
         _init();
      }
      
      public static function createSceneLoader(param1:int) : SceneLoader
      {
         var _loc2_:* = param1;
         if(21 !== _loc2_)
         {
            if(25 !== _loc2_)
            {
               if(26 !== _loc2_)
               {
                  if(28 !== _loc2_)
                  {
                     if(27 !== _loc2_)
                     {
                        if(24 !== _loc2_)
                        {
                           if(13 !== _loc2_)
                           {
                              if(11 !== _loc2_)
                              {
                                 if(12 !== _loc2_)
                                 {
                                    if(14 !== _loc2_)
                                    {
                                       if(15 !== _loc2_)
                                       {
                                          if(16 !== _loc2_)
                                          {
                                             if(2 !== _loc2_)
                                             {
                                                if(4 !== _loc2_)
                                                {
                                                   if(30 !== _loc2_)
                                                   {
                                                      return null;
                                                   }
                                                   return new SceneLoader(AppFacade.root.scenesRoot + "RevampMain.swf",SwfVer.X_REVAMP);
                                                }
                                                return new SceneLoader(AppFacade.root.scenesRoot + "BattleResultMain.swf",SwfVer.BATTLE_RESULT);
                                             }
                                             return new SceneLoader(AppFacade.root.scenesRoot + "BattleMain.swf",SwfVer.BATTLE);
                                          }
                                          return new SceneLoader(AppFacade.root.scenesRoot + "SallyMain.swf",SwfVer.L_SALLY);
                                       }
                                       return new SceneLoader(AppFacade.root.scenesRoot + "ArsenalMain.swf",SwfVer.L_ARSENAL);
                                    }
                                    return new SceneLoader(AppFacade.root.scenesRoot + "RepairMain.swf",SwfVer.L_REPAIR);
                                 }
                                 return new SceneLoader(AppFacade.root.scenesRoot + "RemodelMain.swf",SwfVer.L_REMODEL);
                              }
                              return new SceneLoader(AppFacade.root.scenesRoot + "SupplyMain.swf",SwfVer.L_SUPPLY);
                           }
                           return new SceneLoader(AppFacade.root.scenesRoot + "OrganizeMain.swf",SwfVer.L_ORGANIZE);
                        }
                        return new SceneLoader(AppFacade.root.scenesRoot + "DutyMain.swf",SwfVer.U_DUTY);
                     }
                     return new SceneLoader(AppFacade.root.scenesRoot + "InteriorMain.swf",SwfVer.U_INTERIOR);
                  }
               }
               return new SceneLoader(AppFacade.root.scenesRoot + "ItemlistMain.swf",SwfVer.U_ITEM);
            }
            return new SceneLoader(AppFacade.root.scenesRoot + "AlbumMain.swf",SwfVer.U_ALBUM);
         }
         return new SceneLoader(AppFacade.root.scenesRoot + "RecordMain.swf",SwfVer.U_RECORD);
      }
      
      public static function createWeddingLoader() : SceneLoader
      {
         return new SceneLoader(AppFacade.root.scenesRoot + "WeddingMain.swf",SwfVer.X_WEDDING);
      }
      
      public function get loader() : Loader
      {
         return _loader;
      }
      
      public function get content() : DisplayObject
      {
         return _loader.content;
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function get bytesLoaded() : Number
      {
         return _bytesLoaded;
      }
      
      public function get bytesTotal() : Number
      {
         return _bytesTotal;
      }
      
      public function get loadedPercent() : Number
      {
         return _bytesLoaded / _bytesTotal * 100;
      }
      
      public function load(param1:String = "", param2:Function = null, param3:Function = null) : void
      {
         _init();
         this.loadID = param1;
         _compFunc = param2;
         _failFunc = param3;
         _addEventListeners();
         var _loc4_:LoaderContext = new LoaderContext();
         _loc4_.applicationDomain = ApplicationDomain.currentDomain;
         _loader.load(_urlReq,_loc4_);
      }
      
      public function clear() : void
      {
         if(_loader != null)
         {
            _loader.unloadAndStop(true);
            _loader = null;
         }
         _urlReq = null;
         _failFunc = null;
         _compFunc = null;
      }
      
      private function _init() : void
      {
         _loader = new Loader();
         _url = _path + "?version=" + _version;
         _urlReq = new URLRequest(_url);
      }
      
      private function _addEventListeners() : void
      {
         _loader.contentLoaderInfo.addEventListener("complete",_handleLoadComplete);
         _loader.contentLoaderInfo.addEventListener("progress",_handleProgress);
         _loader.contentLoaderInfo.addEventListener("ioError",_handleLoadError);
      }
      
      private function _removeEventListeners() : void
      {
         _loader.contentLoaderInfo.removeEventListener("complete",_handleLoadComplete);
         _loader.contentLoaderInfo.removeEventListener("progress",_handleProgress);
         _loader.contentLoaderInfo.removeEventListener("ioError",_handleLoadError);
      }
      
      private function _handleLoadComplete(param1:Event) : void
      {
         var _loc2_:* = null;
         Debug.log("load comp." + loadID);
         _removeEventListeners();
         if(_compFunc != null)
         {
            _loc2_ = _compFunc;
            _failFunc = null;
            _compFunc = null;
            _loc2_(this);
         }
      }
      
      private function _handleProgress(param1:ProgressEvent) : void
      {
         _bytesLoaded = param1.bytesLoaded;
         _bytesTotal = param1.bytesTotal;
      }
      
      private function _handleLoadError(param1:IOErrorEvent) : void
      {
         var _loc2_:* = null;
         Debug.log("load failed." + loadID);
         _removeEventListeners();
         if(_failFunc != null)
         {
            _loc2_ = _failFunc;
            _failFunc = null;
            _compFunc = null;
            _loc2_(this);
         }
      }
   }
}
