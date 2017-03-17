package connection.api_get_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   import vo.UseItemData;
   
   public class MaterialAPI extends APIConnectionBase
   {
       
      
      public function MaterialAPI()
      {
         super();
         _API_NAME = "資材情報";
         _url = "api_get_member/material";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         var _loc4_:* = null;
         var _loc3_:Array = param2 as Array;
         if(_loc3_ != null)
         {
            _loc4_ = DataFacade.getUseItemData();
            _loc4_.setMaterial(_loc3_);
         }
         else
         {
            AppFacade.showErrorScreen("api_get_member/material must return array data.");
         }
      }
   }
}
