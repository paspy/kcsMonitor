package connection.req_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class GetIncentiveAPI extends APIConnectionBase
   {
       
      
      public function GetIncentiveAPI()
      {
         super();
         _API_NAME = "インセンティブチェック";
         _url = "api_req_member/get_incentive";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         DataFacade.getIncentiveData().setData(param2);
      }
   }
}
