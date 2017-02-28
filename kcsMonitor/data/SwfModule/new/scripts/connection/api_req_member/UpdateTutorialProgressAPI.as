package connection.api_req_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   import vo.DataController;
   
   public class UpdateTutorialProgressAPI extends APIConnectionBase
   {
       
      
      private var _tutorial_No:int = 0;
      
      public function UpdateTutorialProgressAPI(param1:int)
      {
         super();
         _API_NAME = "チュートリアル進行度更新";
         _url = "api_req_member/update_tutorial_progress";
         _tutorial_No = param1;
      }
      
      override protected function _preLoad() : void
      {
         _urlVariables["api_no"] = _tutorial_No;
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         DataController.updateTutorialProgress(_tutorial_No);
      }
   }
}
