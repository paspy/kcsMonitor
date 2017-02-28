package common.resources
{
   import common.debug.Debug;
   import common.util.Util;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.utils.ByteArray;
   import manager.CacheManager;
   import vo.StartData;
   
   public class ShipResourceLoader extends ImageResourceLoaderBase
   {
      
      public static var option:Object;
       
      
      public function ShipResourceLoader(param1:int, param2:String, param3:DisplayObjectContainer)
      {
         super(param1,param2,param3,null);
      }
      
      override protected function _createURLString() : String
      {
         var _loc1_:* = _mstId.toString();
         var _loc5_:String = null;
         var _loc2_:StartData = DataFacade.getStartData();
         var _loc4_:String = _loc2_.getShipFileName(_mstId);
         if(_loc4_ != "" && SettingFacade.IGNORE_SHIP_FILENAME == false)
         {
            _loc1_ = _loc4_;
            _loc5_ = _loc2_.getShipVersion(_mstId);
         }
         var _loc3_:String = SettingFacade.URLROOT_SHIP;
         _loc3_ = _loc3_ + (_loc1_ + _getURLSuffix() + ".swf");
         if(_loc5_ != null && _loc5_ != "" && _loc5_ != "1")
         {
            _loc3_ = _loc3_ + ("?VERSION=" + _loc5_);
         }
         return _loc3_;
      }
      
      override public function load() : void
      {
         var _loc1_:ByteArray = CacheManager.getCacheShipResource(_mstId);
         if(_loc1_ != null)
         {
            Debug.log("[Ship Resource] From Cache : " + _mstId);
            _load(_loc1_);
         }
         else
         {
            super.load();
         }
      }
      
      override protected function _preShow(param1:Loader) : void
      {
         var _loc2_:MovieClip = param1.content as MovieClip;
         _loc2_.visible = true;
         var _loc3_:int = parseInt(_type);
         _loc2_.gotoAndStop(_loc3_);
         CacheManager.setCacheShipResource(_mstId,param1);
      }
      
      private function _getURLSuffix() : String
      {
         var _loc1_:Object = Util.getObject(option,_mstId.toString());
         return Util.getString(_loc1_,"suffix");
      }
   }
}
