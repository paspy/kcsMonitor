package common.models.airunit
{
   import common.util.Util;
   
   public class AirUnitModel
   {
      
      public static const STATE_TAIKI:int = 0;
      
      public static const STATE_SYUTSUGEKI:int = 1;
      
      public static const STATE_BOKU:int = 2;
      
      public static const STATE_TAIHI:int = 3;
      
      public static const STATE_KYUSOKU:int = 4;
       
      
      private var _o:Object;
      
      private var _companies:Vector.<CompanyModel>;
      
      private var _tmp_actionflg:int = -1;
      
      private var _tmp_name:String = null;
      
      public function AirUnitModel(param1:Object)
      {
         super();
         _o = param1;
         _initializeCompaniesData();
      }
      
      private function get _actionflg() : int
      {
         return Util.getInt(_o,"api_action_kind");
      }
      
      private function get _airUnitName() : String
      {
         return Util.getString(_o,"api_name");
      }
      
      public function get areaID() : int
      {
         return Util.getInt(_o,"api_area_id");
      }
      
      public function get airUnitID() : int
      {
         return Util.getInt(_o,"api_rid");
      }
      
      public function get airUnitName() : String
      {
         return _tmp_name == null?_airUnitName:_tmp_name;
      }
      
      public function get airUnitState() : int
      {
         return _tmp_actionflg == -1?_actionflg:int(_tmp_actionflg);
      }
      
      public function get companies() : Vector.<CompanyModel>
      {
         return _companies;
      }
      
      private function get _companyArr() : Array
      {
         return Util.getArray(_o,"api_plane_info");
      }
      
      public function hasActiveCompany() : Boolean
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < companies.length)
         {
            _loc1_ = companies[_loc2_];
            if(_loc1_.state == 1 && _loc1_.itemMemID > 0 && _loc1_.count > 0)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function hasBoukuuCompany() : Boolean
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < companies.length)
         {
            _loc1_ = companies[_loc2_];
            if(_loc1_.state == 1 && _loc1_.count > 0 && airUnitState == 2)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function getFlagPlaneMstID() : int
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < companies.length)
         {
            _loc1_ = companies[_loc2_];
            if(_loc1_.state == 1 && _loc1_.itemMemID > 0)
            {
               return DataFacade.getUserSlotItemData().getItemID(_loc1_.itemMemID);
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function getDistance() : int
      {
         return Util.getInt(_o,"api_distance");
      }
      
      public function updateCompanyData(param1:Array, param2:int) : void
      {
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         if(param2 >= 0)
         {
            _o["api_distance"] = param2;
         }
         if(param1 == null)
         {
            return;
         }
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc5_ = param1[_loc7_];
            _loc3_ = Util.getInt(_loc5_,"api_squadron_id");
            _loc6_ = 0;
            while(_loc6_ < companies.length)
            {
               _loc4_ = companies[_loc6_];
               if(_loc4_.id == _loc3_)
               {
                  _companyArr[_loc6_] = _loc5_;
                  _loc4_.__updateObject(_loc5_);
               }
               _loc6_++;
            }
            _loc7_++;
         }
      }
      
      public function setTmpActionFlg(param1:int) : void
      {
         _tmp_actionflg = param1;
      }
      
      public function updateTmpActionFlg() : Boolean
      {
         if(_tmp_actionflg != -1 && _tmp_actionflg != _actionflg)
         {
            _o["api_action_kind"] = _tmp_actionflg;
            _tmp_actionflg == -1;
            return true;
         }
         return false;
      }
      
      public function setTmpAirUnitName(param1:String) : void
      {
         _tmp_name = param1;
      }
      
      public function updateTmpAirUnitName() : Boolean
      {
         if(_tmp_name != null && _tmp_name != _airUnitName)
         {
            _o["api_name"] = _tmp_name;
            _tmp_name = null;
            return true;
         }
         return false;
      }
      
      private function _initializeCompaniesData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = _companyArr;
         _companies = new Vector.<CompanyModel>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _companies.push(new CompanyModel(_loc1_[_loc2_],_loc2_));
            _loc2_++;
         }
      }
   }
}
