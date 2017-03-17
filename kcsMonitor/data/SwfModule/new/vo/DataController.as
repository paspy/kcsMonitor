package vo
{
   import common.debug.Debug;
   import common.models.airunit.AirUnitModel;
   import common.models.airunit.CompanyModel;
   import common.util.Util;
   import core.consts.DutyConst;
   import dto.FurnitureDTO;
   import dto.RepairDockDTO;
   import dto.SupplyDTO;
   import flash.events.Event;
   
   public class DataController
   {
       
      
      public function DataController()
      {
         super();
      }
      
      public static function updateTutorialProgress(param1:int) : void
      {
         DataFacade.getUserData().__setTutorialProgress(param1);
      }
      
      public static function addShipToDeck(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc6_:UserDeckData = DataFacade.getUserDeckData();
         var _loc5_:Array = _loc6_.__getDeck(param1);
         var _loc4_:UserShipData = _loc6_.getShipData(param2);
         var _loc7_:int = _loc4_.isInDeck();
         if(_loc7_ > -1)
         {
            if(_loc7_ == 0)
            {
               _loc7_ = 1;
            }
            _loc3_ = _loc6_.getShipPos(_loc7_,param2);
            if(_loc7_ != param1)
            {
               deleteShipFromDeck(_loc7_,_loc3_);
            }
         }
         _loc5_[_loc6_.getShipCountInDeck(param1)] = param2;
         if(_loc7_ == param1)
         {
            deleteShipFromDeck(_loc7_,_loc3_);
         }
         else
         {
            _loc6_.__setDeck(param1,_loc5_);
         }
      }
      
      public static function deleteShipFromDeck(param1:int, param2:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:UserDeckData = DataFacade.getUserDeckData();
         var _loc4_:* = _loc5_.__getDeck(param1);
         _loc4_[param2] = null;
         var _loc3_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < 6)
         {
            if(_loc4_[_loc6_] != null)
            {
               _loc3_.push(_loc4_[_loc6_]);
            }
            _loc6_++;
         }
         _loc4_ = [];
         _loc4_ = _loc3_;
         while(_loc4_.length < 6)
         {
            _loc4_.push(null);
         }
         _loc5_.__setDeck(param1,_loc4_);
      }
      
      public static function changeShipInDeck(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc9_:UserDeckData = DataFacade.getUserDeckData();
         var _loc8_:Array = _loc9_.__getDeck(param1);
         Debug.log("変更前　->　" + _loc8_.toString());
         var _loc7_:UserShipData = _loc9_.getShipData(param3);
         var _loc6_:int = _loc8_[param2];
         var _loc10_:int = _loc7_.isInDeck();
         if(_loc10_ > -1)
         {
            if(_loc10_ == 0)
            {
               _loc10_ = 1;
            }
            _loc4_ = _loc9_.getShipPos(_loc10_,param3);
            _loc5_ = _loc9_.__getDeck(_loc10_);
            _loc5_[_loc4_] = _loc6_;
            _loc9_.__setDeck(_loc10_,_loc5_);
         }
         _loc8_[param2] = param3;
         _loc9_.__setDeck(param1,_loc8_);
         Debug.log("変更後　->　" + _loc9_.__getDeck(param1).toString());
      }
      
      public static function updateDeckName(param1:int, param2:String) : void
      {
         var _loc3_:UserDeckData = DataFacade.getUserDeckData();
         _loc3_.__setDeckName(param1,param2);
      }
      
      public static function changeLockCondition(param1:int, param2:int) : void
      {
         var _loc3_:UserShipData = DataFacade.getUserDeckData().getShipData(param1);
         _loc3_.__setLocked(param2);
      }
      
      public static function organize_preset_afterPresetExpand() : void
      {
         var _loc1_:Boolean = DataFacade.getUseItemData().__useRepairDockKey();
         if(!_loc1_)
         {
            throw new Error("Failed Repair Dock Open.");
         }
      }
      
      public static function supply(param1:SupplyDTO) : void
      {
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc3_:UserDeckData = DataFacade.getUserDeckData();
         _loc9_ = 0;
         while(_loc9_ < param1.getShipCount())
         {
            _loc2_ = param1.getShipID(_loc9_);
            _loc6_ = param1.getShipFuel(_loc9_);
            _loc8_ = param1.getShipAmmo(_loc9_);
            _loc7_ = param1.getShipOnSlot(_loc9_);
            _loc5_ = _loc3_.getShipData(_loc2_);
            _loc5_.__setFuel(_loc6_);
            _loc5_.__setAmmo(_loc8_);
            _loc5_.__setOnSlot(_loc7_);
            _loc9_++;
         }
         var _loc4_:UseItemData = DataFacade.getUseItemData();
         _loc4_.__setCount(31,param1.fuel);
         _loc4_.__setCount(32,param1.ammo);
         _loc4_.__setCount(33,param1.steel);
         _loc4_.__setCount(34,param1.baux);
         _loc4_.dispatchEvent(new Event("EVENT_CHANGE"));
         if(param1.useBaux())
         {
            _loc4_.dispatchEvent(new Event("EVENT_USE_BAUXITE_AT_SUPPLY"));
         }
      }
      
      public static function equipExchange(param1:int, param2:Array) : void
      {
         var _loc3_:UserShipData = DataFacade.getUserDeckData().getShipData(param1);
         _loc3_.__exChange(param2);
      }
      
      public static function remodelEatShips(param1:int, param2:Vector.<UserShipData>) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            arsenalBreakship(param2[_loc3_]);
            _loc3_++;
         }
      }
      
      public static function remodelUpdateShipData(param1:Object, param2:Array) : void
      {
         var _loc3_:UserDeckData = DataFacade.getUserDeckData();
         _loc3_.setShipDataOneShip(param1);
         _loc3_.setDeckData(param2);
      }
      
      public static function remodelUpdateRecipeCount(param1:Array) : void
      {
         var _loc2_:UseItemData = DataFacade.getUseItemData();
         var _loc3_:int = _loc2_.getCount(58);
         var _loc4_:int = _loc2_.getCount(65);
         _loc2_.__setCount(58,_loc3_ - param1[2]);
         _loc2_.__setCount(65,_loc4_ - param1[3]);
      }
      
      public static function changeSlotitemLockCondition(param1:int, param2:int) : void
      {
         DataFacade.getUserSlotItemData().__setSlotitemLockCondition(param1,param2);
      }
      
      public static function openExtraSlot(param1:int) : void
      {
         var _loc2_:UserShipData = DataFacade.getUserDeckData().getShipData(param1);
         _loc2_.__setExSlotItem(-1);
      }
      
      public static function useAddSlot(param1:UseItemData = null) : void
      {
         if(param1 == null)
         {
            param1 = DataFacade.getUseItemData();
         }
         param1.__useItem(64,1);
      }
      
      public static function openRepairDock() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:UseItemData = DataFacade.getUseItemData();
         var _loc1_:Boolean = _loc3_.__useRepairDockKey();
         if(!_loc1_)
         {
            throw new Error("Failed Repair Dock Open.");
         }
         var _loc4_:UserRepairDockData = DataFacade.getRepairDockData();
         _loc5_ = 0;
         while(_loc5_ < _loc4_.dockNum)
         {
            _loc2_ = _loc4_.getDock(_loc5_);
            if(!_loc2_.isDockOpen())
            {
               _loc4_.__setState(_loc5_,0);
               break;
            }
            _loc5_++;
         }
      }
      
      public static function useMaterialAtRepair(param1:UserShipData, param2:Boolean) : void
      {
         var _loc3_:UseItemData = DataFacade.getUseItemData();
         _loc3_.__useItem(31,param1.getRepairFuel());
         _loc3_.__useItem(33,param1.getRepairSteel());
         if(param2)
         {
            useRepairKit(_loc3_);
         }
         _loc3_.dispatchEvent(new Event("EVENT_CHANGE"));
      }
      
      public static function useRepairKit(param1:UseItemData = null) : void
      {
         if(param1 == null)
         {
            param1 = DataFacade.getUseItemData();
         }
         param1.__useItem(1,1);
      }
      
      public static function repair(param1:UserShipData, param2:int = 100) : void
      {
         param1.__setNowHP(param1.getMaxHp());
         param1.__setRepairItems(0,0);
         param1.__setRepairTime(0);
         if(param1.getTired() < 40)
         {
            param1.__setTired(40);
         }
      }
      
      public static function outRepairDock(param1:int) : void
      {
         var _loc2_:UserRepairDockData = DataFacade.getRepairDockData();
         _loc2_.__setState(param1,0);
         _loc2_.__setShipID(param1,-1);
         _loc2_.__setCompleteTime(param1,0);
      }
      
      public static function useBuildKit(param1:int, param2:UseItemData = null) : void
      {
         if(param2 == null)
         {
            param2 = DataFacade.getUseItemData();
         }
         param2.__useItem(2,param1);
      }
      
      public static function useKeyWithOpenArsenalDock() : void
      {
         var _loc2_:UseItemData = DataFacade.getUseItemData();
         var _loc1_:Boolean = _loc2_.__useRepairDockKey();
         if(!_loc1_)
         {
            throw new Error("Failed Repair Dock Open.");
         }
      }
      
      public static function arsenalBuild(param1:Object, param2:Array) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         DataFacade.getUserDeckData().__addShip(param1);
         var _loc3_:UserSlotItemData = DataFacade.getUserSlotItemData();
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            _loc4_ = param2[_loc5_];
            _loc3_.__updateItem(_loc4_["api_id"],_loc4_);
            _loc5_++;
         }
         AppFacade.portMain.updateUpperBar();
      }
      
      public static function arsenalBreakship(param1:UserShipData) : void
      {
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:UserSlotItemData = DataFacade.getUserSlotItemData();
         var _loc6_:Array = param1.getSlotItemMemberIDs();
         _loc8_ = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc4_.__removeItem(_loc6_[_loc8_]);
            _loc8_++;
         }
         var _loc2_:int = param1.getExtraSlotItemID();
         if(_loc2_ > 0)
         {
            _loc4_.__removeItem(_loc2_);
         }
         var _loc3_:UserDeckData = DataFacade.getUserDeckData();
         if(param1.isInDeck() >= 0)
         {
            _loc7_ = param1.isInDeck();
            _loc5_ = _loc3_.getShipPos(_loc7_,param1.getShipID());
            DataController.deleteShipFromDeck(_loc7_,_loc5_);
         }
         _loc3_.__removeShip(param1);
         AppFacade.portMain.updateUpperBar();
      }
      
      public static function arsenalDevelop(param1:int, param2:Object, param3:int, param4:Array) : void
      {
         var _loc5_:UserSlotItemData = DataFacade.getUserSlotItemData();
         if(param1 != -1 && param2 != null)
         {
            _loc5_.__updateItem(param1,param2);
         }
         if(param3 != -1 && param4 != null)
         {
            _loc5_.updateUnsetListData(param3,param4);
         }
      }
      
      public static function arsenalAbolish(param1:Array, param2:Array) : void
      {
         var _loc5_:int = 0;
         var _loc3_:UserSlotItemData = DataFacade.getUserSlotItemData();
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_.__removeItem(param1[_loc5_]);
            _loc5_++;
         }
         var _loc4_:UseItemData = DataFacade.getUseItemData();
         _loc4_.__useItem(31,-param2[0]);
         _loc4_.__useItem(32,-param2[1]);
         _loc4_.__useItem(33,-param2[2]);
         _loc4_.__useItem(34,-param2[3]);
         _loc4_.dispatchEvent(new Event("EVENT_CHANGE"));
      }
      
      public static function revampSlotitem(param1:Object, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:UserSlotItemData = DataFacade.getUserSlotItemData();
         if(param1 != null)
         {
            _loc4_ = Util.getInt(param1,"api_id");
            _loc3_.__updateItem(_loc4_,param1);
         }
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            _loc3_.__removeItem(param2[_loc5_]);
            _loc5_++;
         }
      }
      
      public static function revampWithUseitem(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:UseItemData = DataFacade.getUseItemData();
         if(!(int(param1) - 71))
         {
            if(param3)
            {
               _loc4_.__useItem(param1,param2);
            }
         }
         else
         {
            AppFacade.showErrorScreen();
         }
      }
      
      public static function updateUseitemCount(param1:int, param2:int) : void
      {
         var _loc3_:int = DataFacade.getUserSlotItemData().__getSlotitemCount(param2);
         DataFacade.getUseItemData().__setCount(param1,_loc3_);
      }
      
      public static function addSlotitem(param1:Object) : void
      {
         var _loc2_:int = param1["api_id"];
         DataFacade.getUserSlotItemData().__updateItem(_loc2_,param1);
      }
      
      public static function usePayItem(param1:int, param2:Object) : void
      {
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(param2 != null)
         {
            _loc3_ = "使用効果：";
            _loc7_ = DataFacade.getUseItemData();
            var _loc10_:int = 0;
            var _loc9_:* = param2;
            for(var _loc8_ in param2)
            {
               _loc4_ = parseInt(_loc8_);
               _loc6_ = param2[_loc4_];
               if(_loc6_ != 0)
               {
                  _loc3_ = _loc3_ + (_loc7_.getName(_loc4_) + (_loc6_ > 0?"+":"-") + _loc6_);
                  _loc5_ = _loc7_.getCount(_loc4_);
                  _loc7_.__setCount(_loc4_,_loc5_ + _loc6_);
                  _loc3_ = _loc3_ + (" " + _loc5_ + "->" + (_loc5_ + _loc6_) + "  ");
               }
            }
            Debug.log(_loc3_);
         }
      }
      
      public static function buyFurniture(param1:FurnitureDTO, param2:Boolean) : void
      {
         var _loc5_:UseItemData = DataFacade.getUseItemData();
         if(param2 == true)
         {
            _loc5_.__useItem(52);
         }
         else if(param1.isNeedSpecialCraftsman())
         {
            _loc5_.__useItem(52);
         }
         var _loc4_:int = param1.price;
         if(param2 == true)
         {
            _loc4_ = param1.getDiscountPrice();
         }
         _loc5_.__useItem(44,_loc4_);
         var _loc3_:UserFurnitureData = DataFacade.getUserFurnitureData();
         _loc3_.__addData(param1.furnitureType,param1.furnitureID,param1.furnitureNo);
      }
      
      public static function duty_useJukurenToujoin(param1:int) : void
      {
         if(DutyConst.SAIHENSEI_TOUJOIN.indexOf(param1) > 0)
         {
            DataFacade.getUseItemData().__useItem(70,1);
         }
      }
      
      public static function duty_useUseitem(param1:int) : Boolean
      {
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:Object = Util.getObject(DutyConst.MODELCHANGE_EXTRA,param1.toString());
         if(_loc8_ == null)
         {
            return false;
         }
         var _loc5_:Object = Util.getObject(_loc8_,"lost");
         if(_loc5_ == null)
         {
            return false;
         }
         var _loc4_:Boolean = true;
         var _loc3_:Array = Util.getArray(_loc5_,"useitem");
         if(_loc3_ != null)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc3_.length)
            {
               _loc7_ = _loc3_[_loc9_];
               if(_loc7_ != null)
               {
                  _loc2_ = Util.getInt(_loc7_,"id");
                  _loc6_ = Util.getInt(_loc7_,"count");
                  if(!(_loc2_ <= 0 || _loc6_ <= 0))
                  {
                     _loc4_ = DataFacade.getUseItemData().__useItem(_loc2_,_loc6_) && _loc4_;
                  }
               }
               _loc9_++;
            }
         }
         return _loc4_;
      }
      
      public static function airUnit_updateUnset(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc2_ = param1[_loc5_];
            _loc4_ = Util.getInt(_loc2_,"api_type3No");
            _loc3_ = Util.getArray(_loc2_,"api_slot_list");
            if(_loc4_ > 0 && _loc3_ != null)
            {
               DataFacade.getUserSlotItemData().updateUnsetListData(_loc4_,_loc3_);
            }
            _loc5_++;
         }
      }
      
      public static function airUnit_set(param1:int, param2:int, param3:int, param4:Array, param5:Array, param6:int) : void
      {
         var _loc11_:Boolean = false;
         var _loc9_:int = 0;
         var _loc13_:* = null;
         var _loc7_:AirUnitModel = DataFacade.getUserAirUnitData().getAirUnitModel(param1,param2);
         var _loc8_:int = _loc7_.companies[param3].state;
         var _loc10_:int = _loc7_.companies[param3].itemMemID;
         DataFacade.getUseItemData().setMaterial2(param4);
         _loc7_.updateCompanyData(param5,param6);
         var _loc12_:CompanyModel = _loc7_.companies[param3];
         if(_loc12_.state == 1)
         {
            DataFacade.getUserSlotItemData().__removeUnsetSlotitem(_loc12_.itemMemID);
         }
         if(_loc8_ == 1)
         {
            _loc11_ = false;
            _loc9_ = 0;
            while(_loc9_ < _loc7_.companies.length)
            {
               _loc13_ = _loc7_.companies[_loc9_];
               if(_loc13_.state == 1 && _loc13_.itemMemID == _loc10_)
               {
                  _loc11_ = true;
                  break;
               }
               _loc9_++;
            }
            if(_loc11_ == false)
            {
               DataFacade.getUserSlotItemData().__addReassignmentSlotitem(_loc10_);
            }
         }
      }
      
      public static function airUnit_supply(param1:int, param2:int, param3:Array, param4:Array, param5:int) : void
      {
         DataFacade.getUseItemData().setMaterial2(param3);
         var _loc6_:AirUnitModel = DataFacade.getUserAirUnitData().getAirUnitModel(param1,param2);
         _loc6_.updateCompanyData(param4,param5);
      }
      
      public static function removeSaiun(param1:Array) : void
      {
         if(param1 != null)
         {
            DataFacade.getUserDeckData().updateShipData(param1);
         }
         DataFacade.getUserSlotItemData().__removeSlotitemFromMstID(209);
      }
      
      public static function useYouinInTaihaMarch(param1:UserShipData) : Boolean
      {
         var _loc2_:int = 42;
         param1.__setNowHP(param1.getMaxHp() * (50 / 100));
         return _useSpendSlotitemA(param1,_loc2_);
      }
      
      public static function useMegamiInTaihaMarch(param1:UserShipData) : Boolean
      {
         var _loc2_:int = 43;
         param1.__setNowHP(param1.getMaxHp());
         return _useSpendSlotitemA(param1,_loc2_);
      }
      
      public static function useUnderwayReplenishment(param1:UserShipData) : Boolean
      {
         var _loc2_:int = 146;
         return _useSpendSlotitemB(param1,_loc2_);
      }
      
      private static function _useSpendSlotitemA(param1:UserShipData, param2:int) : Boolean
      {
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(param1.getExtraSlotItemMstID() == param2)
         {
            _loc7_ = param1.getExtraSlotItemID();
            param1.__setExSlotItem(-1);
            DataFacade.getUserSlotItemData().__removeItem(_loc7_);
            return true;
         }
         _loc4_ = param1.getSlotItemMemberIDs();
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc6_];
            _loc3_ = DataFacade.getUserSlotItemData().getItemID(_loc5_);
            if(param2 == _loc3_)
            {
               _loc4_.splice(_loc6_,1);
               _loc4_.push(-1);
               param1.__setSlotItems(_loc4_);
               DataFacade.getUserSlotItemData().__removeItem(_loc5_);
               return true;
            }
            _loc6_++;
         }
         return false;
      }
      
      private static function _useSpendSlotitemB(param1:UserShipData, param2:int) : Boolean
      {
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(param1.getExtraSlotItemMstID() == param2)
         {
            _loc7_ = param1.getExtraSlotItemID();
            param1.__setExSlotItem(-1);
            DataFacade.getUserSlotItemData().__removeItem(_loc7_);
            return true;
         }
         _loc4_ = param1.getSlotItemMemberIDs();
         _loc4_ = _loc4_.reverse();
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc6_];
            _loc3_ = DataFacade.getUserSlotItemData().getItemID(_loc5_);
            if(param2 == _loc3_)
            {
               _loc4_.splice(_loc6_,1);
               _loc4_.unshift(-1);
               param1.__setSlotItems(_loc4_.reverse());
               DataFacade.getUserSlotItemData().__removeItem(_loc5_);
               return true;
            }
            _loc6_++;
         }
         return false;
      }
   }
}
