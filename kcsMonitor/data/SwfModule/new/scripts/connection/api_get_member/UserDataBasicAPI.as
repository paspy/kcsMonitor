package connection.api_get_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class UserDataBasicAPI extends APIConnectionBase
   {
       
      
      public function UserDataBasicAPI()
      {
         super();
         _API_NAME = "ユーザー情報";
         _url = "api_get_member/basic";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         DataFacade.getUserData().setData(param2);
      }
   }
}
