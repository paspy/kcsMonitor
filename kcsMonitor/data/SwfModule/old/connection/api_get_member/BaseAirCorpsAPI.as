package connection.api_get_member
{
   import common.debug.Debug;
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class BaseAirCorpsAPI extends APIConnectionBase
   {
       
      
      public function BaseAirCorpsAPI()
      {
         super();
         _API_NAME = "基地航空隊情報の取得";
         _url = "api_get_member/base_air_corps";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         Debug.log(JSON.stringify(param2));
         if(param2 == null)
         {
            param2 = [];
         }
         if(param2 is Array)
         {
            DataFacade.getUserAirUnitData().setData(param2 as Array);
            return;
         }
         AppFacade.showErrorScreen("api_get_member/base_air_corps must return array data.");
      }
   }
}
