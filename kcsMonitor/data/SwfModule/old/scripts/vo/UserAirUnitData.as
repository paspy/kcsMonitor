package vo
{
   import common.models.airunit.AirUnitModel;
   import flash.utils.Dictionary;
   
   public class UserAirUnitData extends BaseData
   {
       
      
      private var _dataDic:Dictionary;
      
      public function UserAirUnitData()
      {
         super();
         _dataDic = new Dictionary();
      }
      
      public function setData(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _dataDic = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new AirUnitModel(param1[_loc3_]);
            if(_dataDic.hasOwnProperty(_loc2_.areaID) == false)
            {
               _dataDic[_loc2_.areaID] = new Vector.<AirUnitModel>();
            }
            _dataDic[_loc2_.areaID].push(_loc2_);
            _loc3_++;
         }
      }
      
      public function pushAirUnitModel(param1:AirUnitModel) : void
      {
         _dataDic[param1.areaID].push(param1);
      }
      
      public function getAirUnitCount(param1:int) : int
      {
         var _loc2_:Vector.<AirUnitModel> = _getAirUnitList(param1);
         if(_loc2_ == null)
         {
            return 0;
         }
         return _loc2_.length;
      }
      
      public function getAirUnitList(param1:int) : Vector.<AirUnitModel>
      {
         var _loc2_:Vector.<AirUnitModel> = _getAirUnitList(param1);
         if(_loc2_ == null)
         {
            return new Vector.<AirUnitModel>();
         }
         return _loc2_.concat();
      }
      
      public function getAirUnitModel(param1:int, param2:int) : AirUnitModel
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:Vector.<AirUnitModel> = _getAirUnitList(param1);
         if(_loc4_ == null)
         {
            return null;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_ = _loc4_[_loc5_];
            if(_loc3_.airUnitID == param2)
            {
               return _loc3_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function getAirUnits(param1:int, param2:int) : Vector.<AirUnitModel>
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc5_:Vector.<AirUnitModel> = _getAirUnitList(param1);
         if(_loc5_ == null)
         {
            return new Vector.<AirUnitModel>();
         }
         var _loc4_:Vector.<AirUnitModel> = new Vector.<AirUnitModel>();
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc3_ = _loc5_[_loc6_];
            if(_loc3_.airUnitState == param2)
            {
               _loc4_.push(_loc3_);
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function isReady(param1:int) : Vector.<AirUnitModel>
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:Vector.<AirUnitModel> = new Vector.<AirUnitModel>();
         var _loc4_:Vector.<AirUnitModel> = _getAirUnitList(param1);
         if(_loc4_ == null)
         {
            return _loc3_;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc5_];
            if(_loc2_.airUnitState == 1)
            {
               if(_loc2_.hasActiveCompany() != false)
               {
                  _loc3_.push(_loc2_);
               }
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      private function _getAirUnitList(param1:int) : Vector.<AirUnitModel>
      {
         if(_dataDic.hasOwnProperty(param1) == false)
         {
            return null;
         }
         return _dataDic[param1] as Vector.<AirUnitModel>;
      }
   }
}
