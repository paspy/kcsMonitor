package common.models.map
{
   import common.util.Util;
   
   public class MapCellData
   {
       
      
      private var _o:Object;
      
      public function MapCellData(param1:Object)
      {
         super();
         _o = param1;
      }
      
      public function get cellID() : int
      {
         return Util.getInt(_o,"api_id",-1);
      }
      
      public function get cellNo() : int
      {
         return Util.getInt(_o,"api_no",-1);
      }
      
      public function get cellColor() : int
      {
         return Util.getInt(_o,"api_color_no",-1);
      }
      
      public function get passed() : Boolean
      {
         return Util.getInt(_o,"api_passed") == 1;
      }
      
      public function get distance() : int
      {
         return Util.getInt(_o,"api_distance",-1);
      }
   }
}
