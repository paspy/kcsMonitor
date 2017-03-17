package manager
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class CacheManager
   {
      
      public static var ALL_CACHE:Boolean = false;
      
      private static var _cachedShipData:Dictionary = new Dictionary();
       
      
      public function CacheManager()
      {
         super();
      }
      
      public static function getCacheShipResource(param1:int) : ByteArray
      {
         if(_cachedShipData.hasOwnProperty(param1))
         {
            return _cachedShipData[param1];
         }
         return null;
      }
      
      public static function setCacheShipResource(param1:int, param2:Loader, param3:Boolean = false) : void
      {
         var _loc5_:* = null;
         if(param2 == null || param2.content == null)
         {
            return;
         }
         var _loc4_:Boolean = param3 || ALL_CACHE;
         if(_loc4_ == false)
         {
            _loc5_ = DataFacade.getUserDeckData().getCharaIDList();
            if(_loc5_.indexOf(param1) != -1)
            {
               _loc4_ = true;
            }
         }
         if(_loc4_ && param2.content is MovieClip)
         {
            _cachedShipData[param1] = param2.contentLoaderInfo.bytes;
         }
      }
      
      public static function reduceCache() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:Array = DataFacade.getUserDeckData().getCharaIDList();
         var _loc6_:int = 0;
         var _loc5_:* = _cachedShipData;
         for(var _loc3_ in _cachedShipData)
         {
            _loc1_ = parseInt(_loc3_);
            if(_loc4_.indexOf(_loc1_) == -1)
            {
               delete _cachedShipData[_loc1_];
            }
         }
         return _loc2_;
      }
   }
}
