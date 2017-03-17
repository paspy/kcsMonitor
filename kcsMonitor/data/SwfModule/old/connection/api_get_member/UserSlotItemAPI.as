package connection.api_get_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class UserSlotItemAPI extends APIConnectionBase
   {
       
      
      public function UserSlotItemAPI()
      {
         super();
         _API_NAME = "スロット装備情報";
         _url = "api_get_member/slot_item";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         if(param2 == null)
         {
            param2 = [];
         }
         var _loc3_:Array = param2 as Array;
         if(_loc3_ != null)
         {
            DataFacade.getUserSlotItemData().setData(_loc3_);
         }
         else
         {
            AppFacade.showErrorScreen("api_get_member/slotitem must return array data.");
         }
      }
   }
}
