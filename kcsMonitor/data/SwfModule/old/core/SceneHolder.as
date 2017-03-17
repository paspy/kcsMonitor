package core
{
   import common.util.SwfVer;
   import scene.SceneLoader;
   
   public class SceneHolder
   {
       
      
      public var titleLoader:SceneLoader = null;
      
      public var fontLoader:SceneLoader = null;
      
      public var iconAssetsLoader:SceneLoader = null;
      
      public var useitemIconAssetsLoader:SceneLoader = null;
      
      public var commonAssetsLoader:SceneLoader = null;
      
      public var soundBGMAssetsLoader:SceneLoader = null;
      
      public var soundSEAssetsLoader:SceneLoader = null;
      
      public var portLoader:SceneLoader = null;
      
      private var _commonLoaders:Vector.<SceneLoader>;
      
      private var _sceneLoaders:Vector.<SceneLoader>;
      
      private var _skipList:Array;
      
      public function SceneHolder()
      {
         _commonLoaders = new Vector.<SceneLoader>();
         _sceneLoaders = new Vector.<SceneLoader>();
         super();
         _skipList = [];
      }
      
      public static function createSoundBGMLoader() : SceneLoader
      {
         return new SceneLoader("./resources/swf/sound_bgm.swf",SwfVer.SOUND_BGM_ASSET);
      }
      
      public static function createSoundSELoader() : SceneLoader
      {
         return new SceneLoader("./resources/swf/sound_se.swf",SwfVer.SOUND_SE_ASSET);
      }
      
      public function loadProgress() : Number
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = 0;
         var _loc1_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _commonLoaders.length)
         {
            _loc4_ = _commonLoaders[_loc5_];
            if(_skipList.indexOf(_loc4_) == -1)
            {
               _loc2_ = Number(_loc2_ + SceneLoader(_loc4_).loadedPercent);
               _loc1_++;
            }
            _loc5_++;
         }
         var _loc3_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _sceneLoaders.length)
         {
            _loc4_ = _sceneLoaders[_loc5_];
            if(_skipList.indexOf(_loc4_) == -1)
            {
               _loc2_ = Number(_loc2_ + SceneLoader(_loc4_).loadedPercent);
               _loc3_++;
            }
            _loc5_++;
         }
         return _loc2_ / (100 * (_loc1_ + _loc3_));
      }
      
      public function clearLoader() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _sceneLoaders.length)
         {
            _sceneLoaders[_loc1_].clear();
            _sceneLoaders[_loc1_] = null;
            _loc1_++;
         }
         _sceneLoaders = null;
      }
      
      public function skip(param1:SceneLoader) : int
      {
         if(_skipList.indexOf(param1) == -1)
         {
            _skipList.push(param1);
         }
         return _skipList.length;
      }
      
      public function initialize(param1:String) : void
      {
         titleLoader = new SceneLoader(param1 + "TitleMain.swf",SwfVer.TITLE);
         _sceneLoaders.push(titleLoader);
         fontLoader = new SceneLoader("./resources/swf/font.swf",SwfVer.FONTASSET);
         _commonLoaders.push(fontLoader);
         iconAssetsLoader = new SceneLoader("./resources/swf/icons.swf",SwfVer.ICONASSET);
         _commonLoaders.push(iconAssetsLoader);
         useitemIconAssetsLoader = new SceneLoader("./resources/swf/itemicons.swf",SwfVer.UITEM_ICONASSET);
         _commonLoaders.push(useitemIconAssetsLoader);
         commonAssetsLoader = new SceneLoader("./resources/swf/commonAssets.swf",SwfVer.COMMONASSETS);
         _commonLoaders.push(commonAssetsLoader);
         soundBGMAssetsLoader = createSoundBGMLoader();
         _commonLoaders.push(soundBGMAssetsLoader);
         soundSEAssetsLoader = createSoundSELoader();
         _commonLoaders.push(soundSEAssetsLoader);
         portLoader = new SceneLoader("./PortMain.swf",SwfVer.PORT);
         _commonLoaders.push(portLoader);
      }
   }
}
