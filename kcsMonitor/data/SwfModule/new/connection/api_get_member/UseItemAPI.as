package connection.api_get_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class UseItemAPI extends APIConnectionBase
   {
       
      
      public function UseItemAPI()
      {
         super();
         _API_NAME = "使用アイテム情報";
         _url = "api_get_member/useitem";
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
            DataFacade.getUseItemData().setData(_loc3_);
         }
         else
         {
            AppFacade.showErrorScreen("api_get_member/useitem must return array data.");
         }
      }
   }
}
