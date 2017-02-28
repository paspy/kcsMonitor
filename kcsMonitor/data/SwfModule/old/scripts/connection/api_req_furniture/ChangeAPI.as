package connection.api_req_furniture
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class ChangeAPI extends APIConnectionBase
   {
       
      
      private var _furnitureArr:Array;
      
      private var _changed_season:int;
      
      public function ChangeAPI(param1:Array, param2:int)
      {
         super();
         _API_NAME = "模様替え";
         _url = "api_req_furniture/change";
         _furnitureArr = param1;
         _changed_season = param2;
      }
      
      override protected function _preLoad() : void
      {
         _urlVariables["api_floor"] = _furnitureArr[0];
         _urlVariables["api_wallpaper"] = _furnitureArr[1];
         _urlVariables["api_window"] = _furnitureArr[2];
         _urlVariables["api_wallhanging"] = _furnitureArr[3];
         _urlVariables["api_shelf"] = _furnitureArr[4];
         _urlVariables["api_desk"] = _furnitureArr[5];
         if(_changed_season >= 0)
         {
            _urlVariables["api_season"] = _changed_season;
         }
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
      }
   }
}
