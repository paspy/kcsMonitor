package connection.api_get_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class UserShipAPI extends APIConnectionBase
   {
       
      
      public function UserShipAPI()
      {
         super();
         _API_NAME = "所有艦情報";
         _url = "api_get_member/ship2";
      }
      
      override protected function _preLoad() : void
      {
         _urlVariables.api_sort_key = "5";
         _urlVariables.spi_sort_order = "2";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(param2.hasOwnProperty("api_ship") && param2.hasOwnProperty("api_deck"))
         {
            _loc4_ = param2["api_ship"] as Array;
            if(_loc4_ != null)
            {
               DataFacade.getUserDeckData().setShipData(_loc4_);
               _loc3_ = param2["api_deck"] as Array;
               if(_loc3_ != null)
               {
                  DataFacade.getUserDeckData().setDeckData(_loc3_);
               }
               else
               {
                  AppFacade.showErrorScreen("api_get_member/ship2 must return \"decks\" array data.");
                  return;
               }
            }
            else
            {
               AppFacade.showErrorScreen("api_get_member/ship2 must return \"ships\" array data.");
               return;
            }
         }
      }
   }
}
