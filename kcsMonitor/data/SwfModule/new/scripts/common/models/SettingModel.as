package common.models
{
   import common.debug.Debug;
   import common.util.Util;
   import flash.net.SharedObject;
   
   public class SettingModel
   {
       
      
      public var volumeMaster:Number = 1;
      
      public var volumeBGM:Number = 1;
      
      public var volumeSE:Number = 1;
      
      public var volumeVoice:Number = 1;
      
      public var recognizedVoice:Boolean;
      
      public var ooyodoVoice:Boolean;
      
      public function SettingModel()
      {
         super();
         _initialize();
      }
      
      public function save() : void
      {
         var _loc1_:* = null;
         var _loc2_:SharedObject = _getSharedObject();
         if(_loc2_ != null)
         {
            try
            {
               _loc2_.data["bgm"] = Math.floor(volumeBGM * 100);
               _loc2_.data["se"] = Math.floor(volumeSE * 100);
               _loc2_.data["voice"] = Math.floor(volumeVoice * 100);
               _loc2_.data["flg_recognized"] = !!recognizedVoice?1:0;
               _loc2_.data["flg_ooyodo"] = !!ooyodoVoice?1:0;
               Debug.log("size: " + _loc2_.size);
               _loc1_ = _loc2_.flush();
               var _loc4_:* = _loc1_;
               if("flushed" !== _loc4_)
               {
                  if("pending" === _loc4_)
                  {
                     Debug.log("save setting pending.");
                  }
               }
               else
               {
                  Debug.log("save setting. " + JSON.stringify(_loc2_.data));
               }
            }
            catch(e:Error)
            {
               Debug.log("Failed save volume.");
            }
         }
         else
         {
            Debug.log("ボリューム用のSharedObjectがありません。");
         }
      }
      
      public function clear() : void
      {
         var _loc1_:SharedObject = _getSharedObject();
         if(_loc1_ != null)
         {
            _loc1_.clear();
         }
      }
      
      private function _getSharedObject() : SharedObject
      {
         return SharedObject.getLocal("volume_setting");
      }
      
      private function _initialize() : void
      {
         var _loc1_:SharedObject = _getSharedObject();
         if(_loc1_ == null)
         {
            __initialize({});
         }
         else
         {
            __initialize(_loc1_.data);
         }
      }
      
      private function __initialize(param1:Object) : void
      {
         volumeBGM = Number(Util.getInt(param1,"bgm",30) / 100);
         volumeSE = Number(Util.getInt(param1,"se",40) / 100);
         volumeVoice = Number(Util.getInt(param1,"voice",60) / 100);
         recognizedVoice = Util.getBooleanFromInt(param1,"flg_recognized",true);
         ooyodoVoice = Util.getBooleanFromInt(param1,"flg_ooyodo",true);
      }
   }
}
