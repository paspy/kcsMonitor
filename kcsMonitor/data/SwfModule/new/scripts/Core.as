package
{
   import a24.tween.Tween24;
   import common.debug.Debug;
   import common.resources.ExtraBytesLoader;
   import common.util.LoaderThread;
   import common.util.SoundUtil;
   import common.util.SwfVer;
   import core.RootView;
   import core.SceneHolder;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.UncaughtErrorEvent;
   import flash.system.ApplicationDomain;
   import flash.text.Font;
   import manager.DebugManager;
   import manager.JSBridgeManager;
   import scene.IAppRoot;
   import scene.IPortMain;
   import scene.SceneLoader;
   
   public class Core extends Sprite implements IAppRoot
   {
       
      
      private var _scenesRoot:String = "./scenes/";
      
      private var _view:RootView;
      
      private var _title:Sprite;
      
      private var _holder:SceneHolder = null;
      
      private var _scenes:Array;
      
      private var _loadedSoundBGM:Boolean = false;
      
      private var _loadedSoundSE:Boolean = false;
      
      private var _jsBridgeManager:JSBridgeManager;
      
      private var _clsAB1:Class;
      
      public var _clsAM1_:Class;
      
      public var _clsAA1_:Class;
      
      public function Core()
      {
         _jsBridgeManager = new JSBridgeManager();
         _clsAB1 = §__AB1__$a3afe9358adf2a2604f7f4b06497e69d-1823591617§;
         _clsAM1_ = §__AM1__$f21acf29c67ab2654a920305c788c8bd-1824443582§;
         _clsAA1_ = §__AA1__$78232e2d1a4c606805107f70bb06f28d-1823555618§;
         super();
         if(AppFacade.root == null)
         {
            AppFacade.root = this;
         }
         _view = new RootView();
         addChild(_view);
         _holder = new SceneHolder();
         log();
         loaderInfo.uncaughtErrorEvents.addEventListener("uncaughtError",_handleUncaughtError);
      }
      
      public function get scenesRoot() : String
      {
         return _scenesRoot;
      }
      
      public function get loadProgress() : Number
      {
         if(_holder == null)
         {
            return 0;
         }
         return _holder.loadProgress();
      }
      
      public function get jsBridgeManager() : JSBridgeManager
      {
         return _jsBridgeManager;
      }
      
      public function setSWFVer(param1:Object) : void
      {
      }
      
      public function startApp(param1:Object) : void
      {
         _holder.initialize(_scenesRoot);
         new SettingFacade().initialize(param1,_completeSettingInitialize);
      }
      
      private function _completeSettingInitialize() : void
      {
         Debug.log("Complete Setting Initialize.");
         var _loc1_:ExtraBytesLoader = new ExtraBytesLoader(_clsAB1);
         _loc1_.addEventListener("complete",_handleLoadExtra1);
         _loc1_.loadExtraBytes();
      }
      
      private function _handleLoadExtra1(param1:Event) : void
      {
         var _loc2_:ExtraBytesLoader = new ExtraBytesLoader(_clsAM1_);
         _loc2_.addEventListener("complete",_handleLoadExtra2);
         _loc2_.loadExtraBytes();
      }
      
      private function _handleLoadExtra2(param1:Event) : void
      {
         _loadExtraAA1();
      }
      
      private function _loadExtraAA1() : void
      {
         var _loc1_:ExtraBytesLoader = new ExtraBytesLoader(_clsAA1_);
         _loc1_.addEventListener("complete",_handleLoadExtraAA1);
         _loc1_.loadExtraBytes();
      }
      
      private function _handleLoadExtraAA1(param1:Event) : void
      {
         _loadDebug();
      }
      
      private function _loadDebug() : void
      {
         _view.debugLayer.visible = SettingFacade.DEBUG;
         if(SettingFacade.DEBUG)
         {
            _loadDebugLogView();
         }
         else
         {
            _loadTitleSWF();
         }
      }
      
      public function isLoadedSoundBGM() : Boolean
      {
         return _loadedSoundBGM;
      }
      
      public function isLoadedSoundSE() : Boolean
      {
         return _loadedSoundSE;
      }
      
      public function loadSoundBGMTween(param1:Boolean) : Tween24
      {
         isLoad = param1;
         if(isLoadedSoundBGM() == false && isLoad == true)
         {
            var t:LoaderThread = new LoaderThread(SceneHolder.createSoundBGMLoader());
            var loadTween:Tween24 = t.createTween(true,this);
            return loadTween.onComplete(function():void
            {
               _loadedSoundBGM = true;
            });
         }
         return Tween24.wait(0);
      }
      
      public function loadSoundSETween(param1:Boolean) : Tween24
      {
         isLoad = param1;
         if(isLoadedSoundSE() == false && isLoad == true)
         {
            var t:LoaderThread = new LoaderThread(SceneHolder.createSoundSELoader());
            var loadTween:Tween24 = t.createTween(true,this);
            return loadTween.onComplete(function():void
            {
               _loadedSoundSE = true;
            });
         }
         return Tween24.wait(0);
      }
      
      private function _loadDebugLogView() : void
      {
         var _loc1_:SceneLoader = new SceneLoader("./debug.swf",new Date().getTime().toString());
         _loc1_.load("debug",_loadedDebugLogView,_loadErrorDebugLogView);
         _view.debugLayer.addChild(_loc1_.loader);
      }
      
      private function _loadedDebugLogView(param1:SceneLoader) : void
      {
         Debug.log("Loaded debug.");
         _loadTitleSWF();
      }
      
      private function _loadErrorDebugLogView(param1:SceneLoader) : void
      {
         Debug.log("not Loaded debug.");
         _loadTitleSWF();
      }
      
      private function _loadTitleSWF() : void
      {
         Debug.log(SettingFacade.toString());
         _holder.titleLoader.load("title",_loadedTitleSWF,_loadError);
      }
      
      private function _loadedTitleSWF(param1:SceneLoader) : void
      {
         var _loc2_:* = null;
         Debug.log("Loaded Title.");
         var _loc3_:String = "title.Title";
         if(ApplicationDomain.currentDomain.hasDefinition(_loc3_))
         {
            _loc2_ = ApplicationDomain.currentDomain.getDefinition("title.Title") as Class;
            _title = new _loc2_();
            _view.mainLayer.addChild(_title);
            _title["start"](this);
            _loadFontAsset();
         }
         else
         {
            showErrorScreen("Failed load TitleMain.swf");
         }
      }
      
      private function _loadFontAsset() : void
      {
         _holder.fontLoader.load("fontAsset",_loadedFontAsset,_loadError);
      }
      
      private function _loadedFontAsset(param1:SceneLoader) : void
      {
         Debug.log("Loaded FontAsset.");
         var _loc2_:Class = ApplicationDomain.currentDomain.getDefinition("res.fonts.FontJp") as Class;
         Font.registerFont(_loc2_);
         var _loc3_:Class = ApplicationDomain.currentDomain.getDefinition("res.fonts.FontNumber") as Class;
         Font.registerFont(_loc3_);
         _loadIconAssets();
      }
      
      private function _loadIconAssets() : void
      {
         _holder.iconAssetsLoader.load("iconAsset",_loadedIconAssets,_loadError);
      }
      
      private function _loadedIconAssets(param1:SceneLoader) : void
      {
         Debug.log("Loaded IconAsset.");
         _loadUseitemIconAssets();
      }
      
      private function _loadUseitemIconAssets() : void
      {
         _holder.useitemIconAssetsLoader.load("useitemIconAsset",_loadedUseitemIconAssets,_loadError);
      }
      
      private function _loadedUseitemIconAssets(param1:SceneLoader) : void
      {
         Debug.log("Loaded UseitemIconAsset.");
         _loadCommonAssets();
      }
      
      private function _loadCommonAssets() : void
      {
         _holder.commonAssetsLoader.load("commonAsset",_loadedCommonAssets,_loadError);
      }
      
      private function _loadedCommonAssets(param1:SceneLoader) : void
      {
         Debug.log("Loaded CommonAsset.");
         _loadSoundBGMAsset();
      }
      
      private function _loadSoundBGMAsset() : void
      {
         if(SoundUtil.volumeBGM > 0)
         {
            _holder.soundBGMAssetsLoader.load("soundBGMAsset",_loadedSoundBGMAsset,_loadError);
         }
         else
         {
            _holder.skip(_holder.soundBGMAssetsLoader);
            _loadedSoundBGMAsset(null);
         }
      }
      
      private function _loadedSoundBGMAsset(param1:SceneLoader) : void
      {
         if(param1 == null)
         {
            Debug.log("skiped Sound BGM Asset.");
         }
         else
         {
            _loadedSoundBGM = true;
            Debug.log("Loaded Sound BGM Asset.");
         }
         _loadSoundSEAsset();
      }
      
      private function _loadSoundSEAsset() : void
      {
         if(SoundUtil.volumeSE > 0)
         {
            _holder.soundSEAssetsLoader.load("soundSEAsset",_loadedSoundSEAsset,_loadError);
         }
         else
         {
            _holder.skip(_holder.soundSEAssetsLoader);
            _loadedSoundSEAsset(null);
         }
      }
      
      private function _loadedSoundSEAsset(param1:SceneLoader) : void
      {
         if(param1 == null)
         {
            Debug.log("skiped Sound SE Asset.");
         }
         else
         {
            _loadedSoundSE = true;
            Debug.log("Loaded Sound SE Asset.");
         }
         _loadPort();
      }
      
      private function _loadPort() : void
      {
         _holder.portLoader.load("Port",_loadedPort,_loadError);
      }
      
      private function _loadedPort(param1:SceneLoader) : void
      {
         Debug.log("Loaded Port.");
         Debug.log("--version--");
         Debug.log(SwfVer.toString());
         Debug.log("--version--");
      }
      
      public function gotoPort(param1:Boolean = false) : void
      {
         if(Assets.CreateURLVariablesClass == null)
         {
            showErrorScreen("");
            return;
         }
         var _loc2_:IPortMain = AppFacade.portMain;
         if(_loc2_)
         {
            if(param1)
            {
               _view.mainLayer.removeChild(_title);
               _title.removeChildren();
               _title = null;
               _holder.clearLoader();
               _holder = null;
               _view.mainLayer.addChild(_loc2_ as DisplayObject);
               _loc2_.initialize();
            }
            else
            {
               _loc2_.backToPort();
            }
         }
         else
         {
            showErrorScreen("[mainD2] portMain no have.");
         }
      }
      
      public function showErrorScreen(param1:String = "") : void
      {
         Tween24.stopAllTweens().play();
         _view.showErrorScreen(param1);
      }
      
      public function log(param1:String = null) : void
      {
         _view.log(param1);
      }
      
      public function task1(param1:Array) : Tween24
      {
         var _loc2_:* = null;
         if(SettingFacade.DEBUG)
         {
            if(_view.debugLayer.numChildren)
            {
               _loc2_ = (_view.debugLayer.getChildAt(0) as Loader).content;
               if(_loc2_ && _loc2_.hasOwnProperty("task1") && _loc2_["task1"] is Function)
               {
                  return _loc2_["task1"](param1);
               }
            }
         }
         return Tween24.wait(0);
      }
      
      public function getDebugManager() : DebugManager
      {
         var _loc1_:* = null;
         if(SettingFacade.DEBUG)
         {
            if(_view.debugLayer.numChildren)
            {
               _loc1_ = (_view.debugLayer.getChildAt(0) as Loader).content;
               if(_loc1_ && _loc1_.hasOwnProperty("getDebugManager") && _loc1_["getDebugManager"] is Function)
               {
                  return _loc1_["getDebugManager"]();
               }
            }
         }
         return null;
      }
      
      private function _loadError(param1:SceneLoader) : void
      {
         Debug.log("[Load Error] " + param1.loadID + " (" + param1.url + ")");
         showErrorScreen("[mainD2] " + param1.loadID + " load Error");
      }
      
      private function _handleUncaughtError(param1:UncaughtErrorEvent) : void
      {
         param1.preventDefault();
         if(param1.error is IOErrorEvent)
         {
            Debug.log("IOErrorEventは無視する" + param1);
            return;
         }
         if(AppFacade.globalErrorHandleFunction != null)
         {
            AppFacade.globalErrorHandleFunction.call(null,param1);
         }
         else
         {
            Debug.log("type:" + param1.type);
            Debug.log("error:" + param1.error);
            Debug.log("errorID:" + param1.errorID);
            showErrorScreen("[Global Error Handle] " + param1.error + "\n" + param1.target);
         }
      }
   }
}
