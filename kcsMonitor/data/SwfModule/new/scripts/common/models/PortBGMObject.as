package common.models
{
   import common.util.Util;
   
   public class PortBGMObject
   {
       
      
      private var _o:Object;
      
      public function PortBGMObject(param1:Object)
      {
         super();
         _o = param1;
      }
      
      public function get id() : String
      {
         return Util.getInt(_o,"api_id").toString();
      }
      
      public function get name() : String
      {
         return Util.getString(_o,"api_name");
      }
   }
}
