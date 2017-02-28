package connection
{
   import flash.events.Event;
   
   public class Start2API extends APIConnectionBase
   {
       
      
      public function Start2API()
      {
         super();
         _API_NAME = "マスタ";
         _url = "api_start2";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         DataFacade.getStartData().setData(param2);
         if(param2.hasOwnProperty("api_mst_ship") && param2["api_mst_ship"] is Array)
         {
            DataFacade.getMasterShipData().setData(param2["api_mst_ship"] as Array);
            if(param2.hasOwnProperty("api_mst_stype") && param2["api_mst_stype"] is Array)
            {
               DataFacade.getMasterShipTypeData().setData(param2["api_mst_stype"] as Array);
               if(param2.hasOwnProperty("api_mst_shipupgrade") && param2["api_mst_shipupgrade"] is Array)
               {
                  DataFacade.getMasterShipUpgradeData().setData(param2["api_mst_shipupgrade"] as Array);
                  if(param2.hasOwnProperty("api_mst_slotitem") && param2["api_mst_slotitem"] is Array)
                  {
                     DataFacade.getMasterSlotItemData().setData(param2["api_mst_slotitem"] as Array);
                     if(param2.hasOwnProperty("api_mst_slotitem_equiptype") && param2["api_mst_slotitem_equiptype"] is Array)
                     {
                        DataFacade.getMasterSlotItemData().setEquipTypeData(param2["api_mst_slotitem_equiptype"] as Array);
                        if(param2.hasOwnProperty("api_mst_equip_exslot") && param2["api_mst_equip_exslot"] is Array)
                        {
                           DataFacade.getMasterSlotItemData().setExtraEquipTypeData(param2["api_mst_equip_exslot"] as Array);
                           if(param2.hasOwnProperty("api_mst_useitem") && param2["api_mst_useitem"] is Array)
                           {
                              DataFacade.getUseItemData().setMasterData(param2["api_mst_useitem"] as Array);
                              if(param2.hasOwnProperty("api_mst_furniture") && param2["api_mst_furniture"] is Array)
                              {
                                 DataFacade.getMasterFurnitureData().setData(param2["api_mst_furniture"] as Array);
                                 if(param2.hasOwnProperty("api_mst_payitem") && param2["api_mst_payitem"] is Array)
                                 {
                                    DataFacade.getPayItemData().setMasterData(param2["api_mst_payitem"] as Array);
                                    if(param2.hasOwnProperty("api_mst_item_shop"))
                                    {
                                       DataFacade.getPayItemData().setShopListData(param2["api_mst_item_shop"]);
                                       if(param2.hasOwnProperty("api_mst_maparea") && param2["api_mst_maparea"] is Array && param2.hasOwnProperty("api_mst_mapinfo") && param2["api_mst_mapinfo"] is Array)
                                       {
                                          _loc5_ = param2["api_mst_maparea"];
                                          _loc3_ = param2["api_mst_mapinfo"];
                                          _loc4_ = !!param2.hasOwnProperty("api_mst_mapbgm")?param2["api_mst_mapbgm"]:[];
                                          DataFacade.getMapData().setMasterData(_loc5_,_loc3_,_loc4_);
                                          if(param2.hasOwnProperty("api_mst_mission"))
                                          {
                                             DataFacade.getMissionData().setData(param2["api_mst_mission"] as Array);
                                             if(param2.hasOwnProperty("api_mst_const"))
                                             {
                                                DataFacade.getServerConstData().setData(param2["api_mst_const"]);
                                                if(param2.hasOwnProperty("api_mst_bgm") && param2["api_mst_bgm"] is Array)
                                                {
                                                   DataFacade.getMasterBGMData().setData(param2["api_mst_bgm"] as Array);
                                                   return;
                                                }
                                                AppFacade.showErrorScreen("No BGMMaster Data.");
                                                return;
                                             }
                                             AppFacade.showErrorScreen("No ServerConst Data.");
                                             return;
                                          }
                                          AppFacade.showErrorScreen("No MissionMaster Data.");
                                          return;
                                       }
                                       AppFacade.showErrorScreen("NO MapMaster Data.");
                                       return;
                                    }
                                    AppFacade.showErrorScreen("No ItemShowList Data.");
                                    return;
                                 }
                                 AppFacade.showErrorScreen("No PayitemMaster Data.");
                                 return;
                              }
                              AppFacade.showErrorScreen("No FurnitureMaster Data.");
                              return;
                           }
                           AppFacade.showErrorScreen("No UseitemMaster Data.");
                           return;
                        }
                        AppFacade.showErrorScreen("No SlotitemEquipTypeMaster Data.");
                        return;
                     }
                     AppFacade.showErrorScreen("No SlotitemEquipTypeMaster Data.");
                     return;
                  }
                  AppFacade.showErrorScreen("No SlotitemMaster Data.");
                  return;
               }
               AppFacade.showErrorScreen("No ShipUpgradeMaster Data.");
               return;
            }
            AppFacade.showErrorScreen("No ShipTypeMaster Data.");
            return;
         }
         AppFacade.showErrorScreen("No ShipMaster Data.");
      }
   }
}
