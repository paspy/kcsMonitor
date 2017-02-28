package connection.api_get_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class UserFurnitureAPI extends APIConnectionBase
   {
       
      
      public function UserFurnitureAPI()
      {
         super();
         _API_NAME = "家具情報";
         _url = "api_get_member/furniture";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         var _loc3_:Array = param2 as Array;
         if(_loc3_ != null)
         {
            DataFacade.getUserFurnitureData().setData(_loc3_);
         }
         else
         {
            AppFacade.showErrorScreen("api_get_member/furniture must return array data.");
         }
      }
   }
}
