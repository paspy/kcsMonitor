package connection.api_get_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class RecordAPI extends APIConnectionBase
   {
       
      
      public function RecordAPI()
      {
         super();
         _API_NAME = "戦績情報";
         _url = "api_get_member/record";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         DataFacade.getUserRecordData().setData(param2);
      }
   }
}
