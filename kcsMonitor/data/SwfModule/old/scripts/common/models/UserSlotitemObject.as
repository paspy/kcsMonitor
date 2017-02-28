package common.models
{
   import common.Consts;
   import common.debug.Debug;
   import common.util.Util;
   import core.consts.PlaneConst;
   
   public class UserSlotitemObject
   {
       
      
      private var _o:Object;
      
      public function UserSlotitemObject(param1:Object)
      {
         super();
         _o = param1;
      }
      
      public static function sortedArray(param1:Vector.<UserSlotitemObject>, param2:int) : Vector.<UserSlotitemObject>
      {
         listData = param1;
         sortKey = param2;
         var tmp:Vector.<UserSlotitemObject> = listData.concat();
         if(sortKey == 0)
         {
            var start_time:Number = new Date().getTime();
            tmp.sort(function(param1:UserSlotitemObject, param2:UserSlotitemObject):int
            {
               if(param1.equipTypeSp < param2.equipTypeSp)
               {
                  return -1;
               }
               if(param1.equipTypeSp > param2.equipTypeSp)
               {
                  return 1;
               }
               if(param1.mstID < param2.mstID)
               {
                  return -1;
               }
               if(param1.mstID > param2.mstID)
               {
                  return 1;
               }
               if(param1.memID < param2.memID)
               {
                  return -1;
               }
               if(param1.memID > param2.memID)
               {
                  return 1;
               }
               return 0;
            });
            Debug.log("[--sort --] " + (new Date().getTime() - start_time));
         }
         else if(sortKey == 1)
         {
            start_time = new Date().getTime();
            tmp.sort(function(param1:UserSlotitemObject, param2:UserSlotitemObject):int
            {
               if(param1.equipTypeSp < param2.equipTypeSp)
               {
                  return -1;
               }
               if(param1.equipTypeSp > param2.equipTypeSp)
               {
                  return 1;
               }
               if(param1.mstID < param2.mstID)
               {
                  return -1;
               }
               if(param1.mstID > param2.mstID)
               {
                  return 1;
               }
               if(param1.level > param2.level)
               {
                  return -1;
               }
               if(param1.level < param2.level)
               {
                  return 1;
               }
               if(param1.memID < param2.memID)
               {
                  return -1;
               }
               if(param1.memID > param2.memID)
               {
                  return 1;
               }
               return 0;
            });
            Debug.log("[--sort --] " + (new Date().getTime() - start_time));
         }
         else if(sortKey == 2)
         {
            start_time = new Date().getTime();
            tmp.sort(function(param1:UserSlotitemObject, param2:UserSlotitemObject):int
            {
               if(param1.equipTypeSp < param2.equipTypeSp)
               {
                  return -1;
               }
               if(param1.equipTypeSp > param2.equipTypeSp)
               {
                  return 1;
               }
               if(param1.mstID < param2.mstID)
               {
                  return -1;
               }
               if(param1.mstID > param2.mstID)
               {
                  return 1;
               }
               if(param1.level < param2.level)
               {
                  return -1;
               }
               if(param1.level > param2.level)
               {
                  return 1;
               }
               if(param1.memID < param2.memID)
               {
                  return -1;
               }
               if(param1.memID > param2.memID)
               {
                  return 1;
               }
               return 0;
            });
            Debug.log("[--sort --] " + (new Date().getTime() - start_time));
         }
         return tmp;
      }
      
      public static function filteredArray(param1:Vector.<UserSlotitemObject>, param2:int) : Vector.<UserSlotitemObject>
      {
         listData = param1;
         filterKey = param2;
         var aaa:Object = Consts.SLOT_FILTERING_CATEGORIES;
         if(filterKey == 8)
         {
            var type3_ids:Array = [];
            var _loc5_:int = 0;
            var _loc4_:* = Consts.SLOT_FILTERING_CATEGORIES;
            for(key in Consts.SLOT_FILTERING_CATEGORIES)
            {
               type3_ids = type3_ids.concat(Consts.SLOT_FILTERING_CATEGORIES[key]);
            }
            return listData.filter(function(param1:UserSlotitemObject, param2:int, param3:Vector.<UserSlotitemObject>):Boolean
            {
               return type3_ids.indexOf(param1.equipTypeSp) == -1;
            });
         }
         if(filterKey == 0)
         {
            return listData.concat();
         }
         if(Consts.SLOT_FILTERING_CATEGORIES.hasOwnProperty(filterKey))
         {
            type3_ids = Consts.SLOT_FILTERING_CATEGORIES[filterKey];
            return listData.filter(function(param1:UserSlotitemObject, param2:int, param3:Vector.<UserSlotitemObject>):Boolean
            {
               return type3_ids.indexOf(param1.equipTypeSp) >= 0;
            });
         }
         return new Vector.<UserSlotitemObject>();
      }
      
      public function get mstID() : int
      {
         return Util.getInt(_o,"api_slotitem_id");
      }
      
      public function get memID() : int
      {
         return Util.getInt(_o,"api_id");
      }
      
      public function get itemName() : String
      {
         return DataFacade.getMasterSlotItemData().getName(mstID);
      }
      
      public function get level() : int
      {
         return Util.getInt(_o,"api_level");
      }
      
      public function isLocked() : Boolean
      {
         return Util.getInt(_o,"api_locked",0) == 1;
      }
      
      public function get aLevel() : int
      {
         return Util.getInt(_o,"api_alv");
      }
      
      public function get cardType() : int
      {
         return DataFacade.getMasterSlotItemData().getSlotItemCardType(mstID);
      }
      
      public function get equipType() : int
      {
         return DataFacade.getMasterSlotItemData().getSlotItemEquipType(mstID);
      }
      
      public function get equipTypeSp() : int
      {
         if(Consts.SLOTITEM_SPECIAL_FLAGS.hasOwnProperty(mstID))
         {
            return Consts.SLOTITEM_SPECIAL_FLAGS[mstID]["eqType"];
         }
         return equipType;
      }
      
      public function get equipTypeSp2() : int
      {
         if(mstID == 128)
         {
            return 38;
         }
         if(mstID == 142)
         {
            return 93;
         }
         if(mstID == 151)
         {
            return 94;
         }
         return equipType;
      }
      
      public function get iconType() : int
      {
         return DataFacade.getMasterSlotItemData().getSlotItemIconType(mstID);
      }
      
      public function getMaterialsFromBroken() : MaterialModel
      {
         return DataFacade.getMasterSlotItemData().getMaterialsFromBroken(mstID);
      }
      
      public function get rarity() : int
      {
         return DataFacade.getMasterSlotItemData().getRarity(mstID);
      }
      
      public function get syatei() : int
      {
         return DataFacade.getMasterSlotItemData().getSyatei(mstID);
      }
      
      public function get karyoku() : int
      {
         return DataFacade.getMasterSlotItemData().getKaryoku(mstID);
      }
      
      public function get raisou() : int
      {
         return DataFacade.getMasterSlotItemData().getRaisou(mstID);
      }
      
      public function get taikuu() : int
      {
         return DataFacade.getMasterSlotItemData().getTaikuu(mstID);
      }
      
      public function get taisen() : int
      {
         return DataFacade.getMasterSlotItemData().getTaisen(mstID);
      }
      
      public function get bakusou() : int
      {
         return DataFacade.getMasterSlotItemData().getBakusou(mstID);
      }
      
      public function get meichu() : int
      {
         return DataFacade.getMasterSlotItemData().getMeichu(mstID);
      }
      
      public function get kaihi() : int
      {
         return DataFacade.getMasterSlotItemData().getKaihi(mstID);
      }
      
      public function get sakuteki() : int
      {
         return DataFacade.getMasterSlotItemData().getSakuteki(mstID);
      }
      
      public function get soukou() : int
      {
         return DataFacade.getMasterSlotItemData().getSoukou(mstID);
      }
      
      public function isPlane() : Boolean
      {
         return PlaneConst.PLANE.indexOf(cardType) != -1;
      }
      
      public function getCost() : int
      {
         return DataFacade.getMasterSlotItemData().getCost(mstID);
      }
      
      public function getDistance() : int
      {
         return DataFacade.getMasterSlotItemData().getDistance(mstID);
      }
      
      public function detailText(param1:String = "", param2:String = "", param3:Boolean = true) : String
      {
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc4_:Array = [];
         if(syatei > 0 && param3)
         {
            _loc4_.push("射程 " + ["","短","中","長","超長"][syatei]);
         }
         var _loc6_:Array = ["火力","雷装","対空","対潜","爆装","命中","回避","索敵","装甲"];
         if(equipType == 48)
         {
            _loc6_[5] = "対爆";
            _loc6_[6] = "迎撃";
         }
         var _loc7_:Array = [karyoku,raisou,taikuu,taisen,bakusou,meichu,kaihi,sakuteki,soukou];
         _loc8_ = 0;
         while(_loc8_ < _loc7_.length)
         {
            if(_loc7_[_loc8_] != 0)
            {
               _loc5_ = param1;
               if(_loc7_[_loc8_] < 0)
               {
                  _loc5_ = param1.split("+").join("");
               }
               _loc4_.push(_loc6_[_loc8_] + _loc5_ + _loc7_[_loc8_]);
            }
            _loc8_++;
         }
         return _loc4_.join(param2);
      }
   }
}
