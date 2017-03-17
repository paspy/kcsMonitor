package connection.api_get_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class KDockAPI extends APIConnectionBase
   {
       
      
      public function KDockAPI()
      {
         super();
         _API_NAME = "工廠ドック情報";
         _url = "api_get_member/kdock";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         var _loc3_:Array = param2 as Array;
         if(_loc3_ != null)
         {
            DataFacade.getBuildDockData().setData(_loc3_);
         }
         else
         {
            AppFacade.showErrorScreen("api_get_member/kdock must return array data.");
         }
      }
   }
}
