package common.models
{
   import common.util.Util;
   
   public class JukeBGMObject
   {
       
      
      private var _o:Object;
      
      public function JukeBGMObject(param1:Object = null)
      {
         super();
         _o = param1 == null?{}:param1;
      }
      
      public function get id() : int
      {
         return Util.getInt(_o,"api_id");
      }
      
      public function get name() : String
      {
         return Util.getString(_o,"api_name");
      }
      
      public function get description() : String
      {
         return Util.getString(_o,"api_description");
      }
      
      public function get bgmId() : String
      {
         return Util.getInt(_o,"api_bgm_id").toString();
      }
      
      public function get fCoin() : int
      {
         return Util.getInt(_o,"api_use_coin");
      }
      
      public function get bgmFlag() : Boolean
      {
         return Util.getInt(_o,"api_bgm_flag") == 1;
      }
      
      public function get loopCount() : int
      {
         return Util.getInt(_o,"api_loops");
      }
   }
}
