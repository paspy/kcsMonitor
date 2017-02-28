package vo
{
   import common.models.MaterialModel;
   import common.util.Util;
   import flash.utils.Dictionary;
   
   public class MasterShipData
   {
       
      
      private var _dic:Dictionary;
      
      public function MasterShipData()
      {
         super();
         _dic = new Dictionary();
      }
      
      public function getShipIDList() : Array
      {
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _dic;
         for(var _loc1_ in _dic)
         {
            _loc2_.push(parseInt(_loc1_));
         }
         return _loc2_;
      }
      
      public function setData(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _dic = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_];
            _loc2_ = _loc3_["api_id"];
            _dic[_loc2_] = _loc3_;
            _loc4_++;
         }
      }
      
      public function getName(param1:int) : String
      {
         return Util.getString(_getShipObj(param1),"api_name");
      }
      
      public function getYomi(param1:int) : String
      {
         return Util.getString(_getShipObj(param1),"api_yomi");
      }
      
      public function getShipType(param1:int) : int
      {
         return Util.getInt(_getShipObj(param1),"api_stype",-1);
      }
      
      public function getShipTypeName(param1:int) : String
      {
         return DataFacade.getMasterShipTypeData().getShipTypeName(getShipType(param1));
      }
      
      public function getSpeed(param1:int) : int
      {
         return Util.getInt(_getShipObj(param1),"api_soku");
      }
      
      public function getFuelMax(param1:int) : int
      {
         return Util.getInt(_getShipObj(param1),"api_fuel_max");
      }
      
      public function getAmmoMax(param1:int) : int
      {
         return Util.getInt(_getShipObj(param1),"api_bull_max");
      }
      
      public function getSlotNum(param1:int) : int
      {
         return Util.getInt(_getShipObj(param1),"api_slot_num");
      }
      
      public function getAfterLv(param1:int) : int
      {
         return Util.getInt(_getShipObj(param1),"api_afterlv");
      }
      
      public function getAfterShipId(param1:int) : int
      {
         return Util.getInt(_getShipObj(param1),"api_aftershipid");
      }
      
      public function getRemodelBull(param1:int) : int
      {
         return Util.getInt(_getShipObj(param1),"api_afterbull");
      }
      
      public function getRemodelSteel(param1:int) : int
      {
         return Util.getInt(_getShipObj(param1),"api_afterfuel");
      }
      
      public function getTaikyu(param1:int) : int
      {
         return _dic[param1]["api_taik"][0];
      }
      
      public function getPowUp(param1:int) : Array
      {
         return _dic[param1]["api_powup"];
      }
      
      public function getBacks(param1:int) : int
      {
         return _dic[param1]["api_backs"];
      }
      
      public function getBroken(param1:int) : MaterialModel
      {
         var _loc2_:MaterialModel = new MaterialModel();
         _loc2_.setFromArray4(Util.getArray(_getShipObj(param1),"api_broken",[0,0,0,0]));
         return _loc2_;
      }
      
      public function getBuildTime(param1:int) : int
      {
         var _loc2_:Object = _getShipObj(param1);
         return Util.getInt(_loc2_,"api_buildtime",5940);
      }
      
      public function getBuildTime_msec(param1:int) : int
      {
         return getBuildTime(param1) * 60 * 1000;
      }
      
      public function getMessageGet(param1:int) : String
      {
         return Util.formatNewLine(_dic[param1]["api_getmes"]);
      }
      
      public function getVoiceFlg(param1:int) : int
      {
         return Util.getInt(_getShipObj(param1),"api_voicef");
      }
      
      public function getVoiceFlg_Recognized(param1:int) : Boolean
      {
         var _loc2_:int = getVoiceFlg(param1);
         return (_loc2_ & 1) > 0;
      }
      
      public function getVoiceFlg_RecognizedSP(param1:int) : Boolean
      {
         var _loc2_:int = getVoiceFlg(param1);
         return (_loc2_ & 4) > 0;
      }
      
      public function getVoiceFlg_TimeSignal(param1:int) : Boolean
      {
         var _loc2_:int = getVoiceFlg(param1);
         return (_loc2_ & 2) > 0;
      }
      
      public function getGradeUpMax(param1:int) : Array
      {
         var _loc2_:Array = new Array(5);
         _loc2_[0] = _dic[param1]["api_houg"][1] - _dic[param1]["api_houg"][0];
         _loc2_[1] = _dic[param1]["api_raig"][1] - _dic[param1]["api_raig"][0];
         _loc2_[2] = _dic[param1]["api_tyku"][1] - _dic[param1]["api_tyku"][0];
         _loc2_[3] = _dic[param1]["api_souk"][1] - _dic[param1]["api_souk"][0];
         _loc2_[4] = _dic[param1]["api_luck"][1] - _dic[param1]["api_luck"][0];
         return _loc2_;
      }
      
      private function _getShipObj(param1:int) : Object
      {
         if(_dic.hasOwnProperty(param1))
         {
            return _dic[param1];
         }
         return {};
      }
      
      public function getTousai(param1:int) : int
      {
         return _dic[param1]["api_maxeq"][0] + _dic[param1]["api_maxeq"][1] + _dic[param1]["api_maxeq"][2] + _dic[param1]["api_maxeq"][3] + _dic[param1]["api_maxeq"][4];
      }
      
      public function getIconType(param1:int) : int
      {
         if(getSpeed(param1) == 0)
         {
            return 1;
         }
         return 0;
      }
   }
}
