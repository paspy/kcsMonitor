package dto
{
   import common.util.Util;
   
   public class FurnitureDTO
   {
       
      
      private var _o:Object;
      
      public function FurnitureDTO(param1:Object)
      {
         super();
         _o = param1;
      }
      
      public function get furnitureID() : int
      {
         return Util.getInt(_o,"api_id",0);
      }
      
      public function get furnitureType() : int
      {
         return Util.getInt(_o,"api_type",0);
      }
      
      public function get furnitureNo() : int
      {
         return Util.getInt(_o,"api_no",0);
      }
      
      public function get name() : String
      {
         return Util.getString(_o,"api_title","");
      }
      
      public function get description() : String
      {
         return Util.getString(_o,"api_description","");
      }
      
      public function get rarity() : int
      {
         return Util.getInt(_o,"api_rarity",0);
      }
      
      public function get price() : int
      {
         return Util.getInt(_o,"api_price",0);
      }
      
      public function get season() : int
      {
         return Util.getInt(_o,"api_season",0);
      }
      
      public function isSale() : Boolean
      {
         return Util.getInt(_o,"api_saleflg",0) == 1;
      }
      
      public function hasItem() : Boolean
      {
         return DataFacade.getUserFurnitureData().hasItem(furnitureType,furnitureID);
      }
      
      public function isNeedSpecialCraftsman() : Boolean
      {
         return price >= 2000 && price < 20000;
      }
      
      public function isCabinetry() : Boolean
      {
         return price >= 100000;
      }
      
      public function getDiscountPrice() : int
      {
         var _loc1_:Number = (price - 100000) * 0.1;
         _loc1_ = Math.max(_loc1_,0);
         return Math.floor(_loc1_);
      }
   }
}
