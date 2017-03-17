package connection.api_get_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class NDockAPI extends APIConnectionBase
   {
       
      
      public function NDockAPI()
      {
         super();
         _API_NAME = "入渠情報";
         _url = "api_get_member/ndock";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         var _loc3_:Array = param2 as Array;
         if(_loc3_ != null)
         {
            DataFacade.getRepairDockData().setData(_loc3_);
         }
         else
         {
            AppFacade.showErrorScreen("api_get_member/ndock must return array data.");
         }
      }
   }
}
