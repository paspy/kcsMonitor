package connection
{
   import common.debug.Debug;
   import flash.net.URLLoader;
   import flash.utils.ByteArray;
   
   public class APIConnectionBaseB extends APIConnectionBase
   {
       
      
      public function APIConnectionBaseB(param1:String = "")
      {
         super(param1);
      }
      
      override protected function _preLoad() : void
      {
         _urlLoader.dataFormat = "binary";
      }
      
      override protected function _getURLLoaderData(param1:URLLoader) : String
      {
         var _loc2_:* = null;
         try
         {
            _loc2_ = param1.data;
            _loc2_.uncompress();
            var _loc4_:* = _loc2_.readUTFBytes(_loc2_.length);
            return _loc4_;
         }
         catch(error:Error)
         {
            Debug.log("start2/compress の解凍に失敗: " + error);
            var _loc5_:String = "";
            return _loc5_;
         }
      }
   }
}
