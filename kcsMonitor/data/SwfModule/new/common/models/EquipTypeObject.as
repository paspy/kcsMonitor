package common.models
{
   import common.util.Util;
   
   public class EquipTypeObject
   {
       
      
      private var _o:Object;
      
      public function EquipTypeObject(param1:Object)
      {
         super();
         _o = param1;
      }
      
      public function get id() : int
      {
         return Util.getInt(_o,"api_id");
      }
      
      public function get name() : String
      {
         return Util.getString(_o,"api_name");
      }
      
      public function isShow() : Boolean
      {
         return Util.getInt(_o,"api_show_flg") == 1;
      }
   }
}
