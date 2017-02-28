package connection.api_get_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class DeckAPI extends APIConnectionBase
   {
       
      
      public function DeckAPI()
      {
         super();
         _API_NAME = "デッキ情報";
         _url = "api_get_member/deck";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         var _loc3_:Array = param2 as Array;
         if(_loc3_ != null)
         {
            DataFacade.getUserDeckData().setDeckData(_loc3_);
         }
         else
         {
            AppFacade.showErrorScreen("api_get_member/deck must return array data.");
         }
      }
   }
}
