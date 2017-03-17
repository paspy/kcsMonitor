package common.models.map
{
   import common.models.BattleBGMObject;
   import core.consts.DutyConst;
   import flash.utils.Dictionary;
   
   public class MapData
   {
       
      
      private var _o:Object;
      
      private var _areaDic:Dictionary;
      
      private var _bgmDic:Dictionary;
      
      public function MapData()
      {
         super();
      }
      
      public static function getInfoID(param1:int, param2:int) : int
      {
         return param1 * 10 + param2;
      }
      
      public function setMasterData(param1:Array, param2:Array, param3:Array) : void
      {
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         _o = {};
         _o["area"] = param1;
         _o["info"] = param2;
         _areaDic = new Dictionary();
         var _loc6_:Vector.<MapInfoData> = new Vector.<MapInfoData>();
         _loc7_ = 0;
         while(_loc7_ < param2.length)
         {
            _loc6_.push(new MapInfoData(param2[_loc7_]));
            _loc7_++;
         }
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc4_ = new MapAreaData(param1[_loc7_]);
            _areaDic[_loc4_.areaID] = _loc4_;
            _loc4_.setMasterData(_loc6_);
            _loc7_++;
         }
         _bgmDic = new Dictionary();
         _loc7_ = 0;
         while(_loc7_ < param3.length)
         {
            _loc5_ = new BattleBGMObject(param3[_loc7_]);
            _bgmDic[_loc5_.mapID] = _loc5_;
            _loc7_++;
         }
      }
      
      public function getAreaData(param1:int) : MapAreaData
      {
         if(_areaDic.hasOwnProperty(param1))
         {
            return _areaDic[param1];
         }
         return null;
      }
      
      public function hasArea(param1:int) : Boolean
      {
         return _areaDic.hasOwnProperty(param1);
      }
      
      public function getInfoData(param1:int) : MapInfoData
      {
         var _loc2_:int = Math.floor((param1 - 1) / 10);
         var _loc3_:int = Math.floor(param1 % 10);
         var _loc4_:MapAreaData = getAreaData(_loc2_);
         if(_loc4_ != null)
         {
            return _loc4_.getInfoData(_loc3_);
         }
         return null;
      }
      
      public function getOpenMapIDs(param1:int, param2:int) : Array
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         if(param1 == 2 && param2 == 4)
         {
            return [25,31,41];
         }
         if(param1 == 3 && param2 == 4)
         {
            if(DataFacade.getMapData().getInfoData(44).isClear())
            {
               return [35,51];
            }
            return [35];
         }
         if(param1 == 4 && param2 == 4)
         {
            if(DataFacade.getMapData().getInfoData(34).isClear())
            {
               return [51];
            }
            return [];
         }
         if(param1 == 5 && param2 == 1)
         {
            return [52,45];
         }
         if(param1 == 6 && param2 == 4)
         {
            if(DataFacade.getUserAirUnitData().getAirUnitCount(6) > 0)
            {
               return [65];
            }
            return [];
         }
         var _loc6_:Array = [];
         var _loc5_:int = getInfoID(param1,param2 + 1);
         if(getInfoData(_loc5_) != null)
         {
            _loc6_.push(_loc5_);
         }
         if(param2 == 4)
         {
            _loc4_ = getInfoID(param1 + 1,1);
            if(getInfoData(_loc4_) != null)
            {
               _loc6_.push(_loc4_);
            }
         }
         _loc7_ = 0;
         while(_loc7_ < DutyConst.OPEN_MAPS.length)
         {
            _loc3_ = _loc6_.indexOf(DutyConst.OPEN_MAPS[_loc7_]);
            if(_loc3_ != -1)
            {
               _loc6_.splice(_loc3_,1);
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      public function getBGMObj(param1:int, param2:int) : BattleBGMObject
      {
         if(param1 == 0 && param2 == 0)
         {
            param1 = 1;
            param2 = 1;
         }
         var _loc3_:int = getInfoID(param1,param2);
         if(_bgmDic.hasOwnProperty(_loc3_))
         {
            return _bgmDic[_loc3_];
         }
         return new BattleBGMObject();
      }
      
      public function isActiveAirUnit() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _areaDic;
         for each(var _loc1_ in _areaDic)
         {
            trace("area:" + _loc1_.areaID + " 基地航空隊運用:" + _loc1_.isActiveAirUnit());
            if(_loc1_.isActiveAirUnit() == true)
            {
               return true;
            }
         }
         return false;
      }
   }
}
