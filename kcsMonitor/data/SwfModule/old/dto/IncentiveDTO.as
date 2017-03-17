package dto
{
   import common.util.Util;
   
   public class IncentiveDTO
   {
      
      public static const MODE_ADVANCED_REGISTRATION:int = 1;
      
      public static const MODE_INVITATION_PRIVILEGE:int = 2;
      
      public static const MODE_GAME_INCENTIVE:int = 3;
      
      public static const TYPE_SHIP:int = 1;
      
      public static const TYPE_SLOTITEM:int = 2;
      
      public static const TYPE_USEITEM:int = 3;
      
      public static const TYPE_MATERIAL:int = 4;
      
      public static const TYPE_FURNITURE:int = 5;
       
      
      private var _o:Object;
      
      public function IncentiveDTO(param1:Object)
      {
         super();
         _o = param1;
         if(type == 4)
         {
            _o["api_mst_id"] = [0,31,32,33,34,2,1,3][mstId];
            _o["api_type"] = 4;
         }
      }
      
      public function get mode() : int
      {
         return Util.getInt(_o,"api_mode",0);
      }
      
      public function get type() : int
      {
         return Util.getInt(_o,"api_type",0);
      }
      
      public function get mstId() : int
      {
         return Util.getInt(_o,"api_mst_id",0);
      }
      
      public function get message() : String
      {
         return Util.formatNewLine(Util.getString(_o,"api_getmes",""));
      }
      
      public function get count() : int
      {
         return Util.getInt(_o,"api_item_count",0);
      }
   }
}
