package connection.api_get_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class UnsetSlotAPI extends APIConnectionBase
   {
       
      
      public function UnsetSlotAPI()
      {
         super();
         _API_NAME = "未装備スロットアイテム";
         _url = "api_get_member/unsetslot";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         DataFacade.getUserSlotItemData().setUnEquipedData(param2);
      }
   }
}
