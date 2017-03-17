package connection.api_port
{
   import core.apis._APIBaseS_;
   import flash.events.Event;
   import vo.DataController;
   import vo.UseItemData;
   
   public class PortAPI extends _APIBaseS_
   {
       
      
      private var _actionLog:Array;
      
      public function PortAPI(param1:Array = null)
      {
         super();
         _API_NAME = "母港TOP用新API";
         _url = "api_port/port";
         _actionLog = param1;
      }
      
      override protected function _preLoad() : void
      {
         _urlVariables.api_sort_key = "5";
         _urlVariables.spi_sort_order = "2";
         var _loc2_:Object = _createKey();
         var _loc1_:int = parseInt(DataFacade.getUserData().getMemberID());
         _urlVariables.api_port = __(_loc1_,_loc2_);
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         var _loc8_:* = null;
         var _loc3_:* = null;
         var _loc10_:* = null;
         var _loc12_:* = null;
         var _loc4_:* = null;
         var _loc14_:* = null;
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc13_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc7_:* = null;
         if(param2.hasOwnProperty("api_ship") && param2.hasOwnProperty("api_deck_port"))
         {
            _loc8_ = param2["api_ship"] as Array;
            if(_loc8_ != null)
            {
               DataFacade.getUserDeckData().setShipData(_loc8_);
               _loc3_ = param2["api_deck_port"] as Array;
               if(_loc3_ != null)
               {
                  DataFacade.getUserDeckData().setDeckData(_loc3_);
               }
               else
               {
                  AppFacade.showErrorScreen("api_get_member/ship2 must return \"decks\" array data.");
                  return;
               }
            }
            else
            {
               AppFacade.showErrorScreen("api_get_member/ship2 must return \"ships\" array data.");
               return;
            }
         }
         if(param2.hasOwnProperty("api_ndock"))
         {
            _loc10_ = param2["api_ndock"] as Array;
            if(_loc10_ != null)
            {
               DataFacade.getRepairDockData().setData(_loc10_);
            }
            else
            {
               AppFacade.showErrorScreen("api_get_member/ndock must return array data.");
            }
         }
         if(param2.hasOwnProperty("api_material"))
         {
            _loc12_ = param2["api_material"] as Array;
            if(_loc12_ != null)
            {
               _loc4_ = DataFacade.getUseItemData();
               _loc4_.setMaterial(_loc12_);
            }
            else
            {
               AppFacade.showErrorScreen("api_get_member/material must return array data.");
            }
         }
         if(param2.hasOwnProperty("api_basic"))
         {
            DataFacade.getUserData().setData(param2["api_basic"]);
         }
         if(_actionLog != null && param2.hasOwnProperty("api_log"))
         {
            _loc14_ = param2["api_log"] as Array;
            if(_loc14_ != null)
            {
               _loc9_ = 0;
               while(_loc9_ < _loc14_.length)
               {
                  _actionLog.push(_loc14_[_loc9_]);
                  _loc9_++;
               }
            }
         }
         if(param2.hasOwnProperty("api_combined_flag"))
         {
            _loc11_ = param2["api_combined_flag"];
            DataFacade.getUserDeckData().setCombinedFlag(_loc11_);
         }
         if(param2.hasOwnProperty("api_p_bgm_id"))
         {
            _loc13_ = param2["api_p_bgm_id"];
            DataFacade.getUserData().setPortMainBGMID(_loc13_);
         }
         if(param2.hasOwnProperty("api_parallel_quest_count"))
         {
            _loc6_ = param2["api_parallel_quest_count"];
            DataFacade.getUserData().setDutyExecutableCount(_loc6_);
         }
         if(param2.hasOwnProperty("api_event_object"))
         {
            _loc5_ = param2["api_event_object"];
            DataFacade.getUserData().setEventObj(_loc5_);
         }
         if(param2.hasOwnProperty("api_plane_info"))
         {
            _loc7_ = param2["api_plane_info"];
            if(_loc7_.hasOwnProperty("api_unset_slot"))
            {
               DataController.airUnit_updateUnset(_loc7_["api_unset_slot"]);
               delete _loc7_["api_unset_slot"];
            }
            DataFacade.getUserData().setPlaneInfo(_loc7_);
         }
         else
         {
            DataFacade.getUserData().setPlaneInfo({});
         }
      }
      
      private function _createKey() : Object
      {
         var key:Object = {};
         key.a = function(param1:String, param2:int, param3:int):String
         {
            return param1.substr(param2,param3);
         };
         key.b = function(param1:String):int
         {
            return param1.length;
         };
         key.c = function(param1:Number):String
         {
            return param1.toString();
         };
         key.r = function(param1:Number):int
         {
            return Math.floor(param1);
         };
         key.i = function(param1:int):int
         {
            return key.r(Math.random() * param1);
         };
         key.j = function():int
         {
            return 8;
         };
         key.k = function(param1:Number, param2:Number):Number
         {
            return param1 ^ param2;
         };
         key.l = function(param1:String, param2:int, param3:int):int
         {
            return parseInt(param1.substr(param2,param3));
         };
         key.m = function(param1:Number, param2:Number):Number
         {
            return param1 - param2;
         };
         key.n = function():Number
         {
            return key.r(new Date().getTime() / 1000);
         };
         key.o = function(param1:Number, param2:Number):Number
         {
            return param2 / param1;
         };
         key.p = function(param1:Number, param2:Number):Number
         {
            return param2 % param1;
         };
         key.q = function():Number
         {
            return 1.44269504088896;
         };
         key.s = function(param1:Object):String
         {
            return param1.toString();
         };
         key.t = function(... rest):String
         {
            return rest.join("");
         };
         key.u = function(param1:Number, param2:Number):Number
         {
            return param1 + param2;
         };
         key.v = function():int
         {
            return 16;
         };
         key.w = function():int
         {
            return 2;
         };
         key.x = function():int
         {
            return 4;
         };
         key.y = function(param1:int):Number
         {
            return Math.sqrt(param1);
         };
         key.z = function(param1:Number, param2:Number):Number
         {
            return param1 * param2;
         };
         return key;
      }
   }
}
