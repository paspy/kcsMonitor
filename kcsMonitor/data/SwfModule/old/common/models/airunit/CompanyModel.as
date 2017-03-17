package common.models.airunit
{
   import common.util.Util;
   
   public class CompanyModel
   {
      
      public static const STATE_MIHAIBI:int = 0;
      
      public static const STATE_HAIBI:int = 1;
      
      public static const STATE_TENKAN:int = 2;
       
      
      private var _o:Object;
      
      private var _index:int;
      
      public function CompanyModel(param1:Object, param2:int)
      {
         super();
         _o = param1;
         _index = param2;
      }
      
      public function get id() : int
      {
         return Util.getInt(_o,"api_squadron_id");
      }
      
      public function get state() : int
      {
         return Util.getInt(_o,"api_state");
      }
      
      public function get itemMemID() : int
      {
         return Util.getInt(_o,"api_slotid");
      }
      
      public function get count() : int
      {
         return Util.getInt(_o,"api_count");
      }
      
      public function get countMax() : int
      {
         return Util.getInt(_o,"api_max_count");
      }
      
      public function get tired() : int
      {
         return Util.getInt(_o,"api_cond");
      }
      
      function __updateObject(param1:Object) : void
      {
         _o = param1;
      }
   }
}
