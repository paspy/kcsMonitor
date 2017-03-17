package connection.api_get_member
{
   import common.debug.Debug;
   import common.util.Util;
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class StartMemAPI extends APIConnectionBase
   {
       
      
      public function StartMemAPI()
      {
         super();
         _API_NAME = "起動時メンバ情報の取得";
         _url = "api_get_member/require_info";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         if(param2 == null)
         {
            param2 = {};
         }
         var _loc3_:Object = Util.getObject(param2,"api_basic");
         if(_loc3_ != null)
         {
            DataFacade.getUserData().setData(_loc3_);
         }
         else
         {
            AppFacade.showErrorScreen("no user_basic_data in start_member_data.");
         }
         var _loc5_:Array = Util.getArray(param2,"api_furniture");
         if(_loc5_ != null)
         {
            DataFacade.getUserFurnitureData().setData(_loc5_);
         }
         else
         {
            AppFacade.showErrorScreen("no user_furniture_data in start_member_data.");
         }
         var _loc8_:Array = Util.getArray(param2,"api_slot_item");
         if(_loc8_ != null)
         {
            DataFacade.getUserSlotItemData().setData(_loc8_);
         }
         else
         {
            DataFacade.getUserSlotItemData().setData([]);
            Debug.log("no user_slotitem_data in start_member_data.");
         }
         var _loc4_:Array = Util.getArray(param2,"api_useitem");
         if(_loc4_ != null)
         {
            DataFacade.getUseItemData().setData(_loc4_);
         }
         else
         {
            DataFacade.getUseItemData().setData([]);
            Debug.log("[W] no user_useitem_data in start_member_data.");
         }
         var _loc7_:Array = Util.getArray(param2,"api_kdock");
         if(_loc7_ != null)
         {
            DataFacade.getBuildDockData().setData(_loc7_);
         }
         else
         {
            AppFacade.showErrorScreen("no user_kdock_data in start_member_data.");
         }
         var _loc6_:Object = Util.getObject(param2,"api_unsetslot");
         if(_loc6_ != null)
         {
            DataFacade.getUserSlotItemData().setUnEquipedData(_loc6_);
         }
         else
         {
            DataFacade.getUserSlotItemData().setUnEquipedData({});
            Debug.log("no user_unsetslotitem_data in start_member_data.");
         }
      }
   }
}
