package common.models
{
   import common.util.Util;
   
   public class MissionObject
   {
       
      
      private var _o:Object;
      
      public function MissionObject(param1:Object)
      {
         super();
         _o = param1;
      }
      
      public function get missionID() : int
      {
         return Util.getInt(_o,"api_id",-1);
      }
      
      public function get areaID() : int
      {
         return Util.getInt(_o,"api_maparea_id",-1);
      }
      
      public function get name() : String
      {
         return Util.getString(_o,"api_name","");
      }
      
      public function get description() : String
      {
         return Util.getString(_o,"api_details","");
      }
      
      public function get time() : int
      {
         return Util.getInt(_o,"api_time");
      }
      
      public function get difficulty() : int
      {
         return Util.getInt(_o,"api_difficulty");
      }
      
      public function get useFuel() : Number
      {
         return Util.getNumber(_o,"api_use_fuel");
      }
      
      public function get useAmmo() : Number
      {
         return Util.getNumber(_o,"api_use_bull");
      }
      
      public function get item1ID() : int
      {
         return Util.getArray(_o,"api_win_item1",[0,0])[0];
      }
      
      public function get item1Count() : int
      {
         return Util.getArray(_o,"api_win_item1",[0,0])[1];
      }
      
      public function get item2ID() : int
      {
         return Util.getArray(_o,"api_win_item2",[0,0])[0];
      }
      
      public function get item2Count() : int
      {
         return Util.getArray(_o,"api_win_item2",[0,0])[1];
      }
      
      public function get cancelable() : Boolean
      {
         return Util.getInt(_o,"api_return_flag",1) == 1;
      }
   }
}
