package vo
{
   import flash.utils.Dictionary;
   
   public class MasterShipUpgradeData
   {
       
      
      private var _dic:Dictionary;
      
      public function MasterShipUpgradeData()
      {
         super();
         _dic = new Dictionary();
      }
      
      public function setData(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _dic = new Dictionary();
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = param1[_loc5_];
            _loc3_ = _loc4_["api_current_ship_id"];
            _loc2_ = _loc4_["api_id"];
            if(_dic[_loc3_] == null)
            {
               _dic[_loc3_] = new Dictionary();
            }
            _dic[_loc3_][_loc2_] = _loc4_;
            _loc5_++;
         }
      }
      
      public function getRequireResources(param1:int, param2:int) : Array
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = null;
         if(DataFacade.getMasterShipData().getAfterLv(param1) == 0)
         {
            _loc3_ = [0,0,0,0,0];
         }
         else if(_dic.hasOwnProperty(param1))
         {
            _loc5_ = getNextUseSteel(param1);
            if(_dic[param1].hasOwnProperty(param2))
            {
               _loc4_ = _dic[param1][param2]["api_drawing_count"];
               _loc3_ = [getNextUseBullet(param1),_loc5_,_loc4_,_dic[param1][param2]["api_catapult_count"],_getNeedDevNum(_loc5_,_loc4_)];
            }
         }
         if(_loc3_ == null)
         {
            _loc5_ = getNextUseSteel(param1);
            _loc3_ = [getNextUseBullet(param1),_loc5_,0,0,_getNeedDevNum(_loc5_,0)];
         }
         return _loc3_;
      }
      
      public function getNextShipIDArray(param1:int) : Array
      {
         var _loc2_:Array = [];
         if(_dic.hasOwnProperty(param1))
         {
            var _loc5_:int = 0;
            var _loc4_:* = _dic[param1];
            for each(var _loc3_ in _dic[param1])
            {
               _loc2_.push(_loc3_["api_id"]);
            }
            _loc2_.sort();
         }
         else
         {
            _loc2_ = [getNextShipId(param1)];
         }
         return _loc2_;
      }
      
      public function getNextUseBullet(param1:int) : int
      {
         return DataFacade.getMasterShipData().getRemodelBull(param1);
      }
      
      public function getNextUseSteel(param1:int) : int
      {
         return DataFacade.getMasterShipData().getRemodelSteel(param1);
      }
      
      public function getNextRemodelLV(param1:int) : int
      {
         return DataFacade.getMasterShipData().getAfterLv(param1);
      }
      
      public function getNextShipId(param1:int) : int
      {
         return DataFacade.getMasterShipData().getAfterShipId(param1);
      }
      
      private function _getNeedDevNum(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         if(param2 > 0)
         {
            _loc3_ = 0;
         }
         else if(param1 < 4500)
         {
            _loc3_ = 0;
         }
         else if(param1 < 5500)
         {
            _loc3_ = 10;
         }
         else if(param1 < 6500)
         {
            _loc3_ = 15;
         }
         else if(param1 < 999999)
         {
            _loc3_ = 20;
         }
         return _loc3_;
      }
   }
}
