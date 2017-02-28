package common.models.bases
{
   import common.util.Util;
   import scene.ISceneDTO;
   
   public class BattleBaseData implements ISceneDTO
   {
       
      
      private var _obj:Object;
      
      public function BattleBaseData(param1:Object = null)
      {
         _obj = {};
         super();
         _obj = !!param1?param1:{};
      }
      
      public function get deckID() : int
      {
         return Util.getInt(_obj,"deckID");
      }
      
      public function get formationID() : int
      {
         return Util.getInt(_obj,"formationID");
      }
      
      public function get enemyID() : int
      {
         return Util.getInt(_obj,"enemyID",-1);
      }
      
      public function get medalNum() : int
      {
         return Util.getInt(_obj,"medalNum");
      }
      
      public function get areaID() : int
      {
         return Util.getInt(_obj,"areaID");
      }
      
      public function get mapNo() : int
      {
         return Util.getInt(_obj,"mapNo");
      }
      
      public function get mapID() : int
      {
         return Util.getInt(_obj,"mapID");
      }
      
      private function get _cellColor() : int
      {
         return Util.getInt(_obj,"cellColor");
      }
      
      public function get cellID() : int
      {
         return Util.getInt(_obj,"cellID");
      }
      
      private function get _cellEventFlg() : int
      {
         return Util.getInt(_obj,"cellEventFlg",-1);
      }
      
      private function get _cellEventKind() : int
      {
         return Util.getInt(_obj,"cellEventKind",-1);
      }
      
      public function hasNext() : Boolean
      {
         return Util.getObject(_obj,"hasNext") as Boolean;
      }
      
      public function get marchingType() : int
      {
         return Util.getInt(_obj,"marchingType");
      }
      
      public function get underwayReplenishment() : int
      {
         return !!_obj.hasOwnProperty("underwayReplenishment")?_obj["underwayReplenishment"]:-1;
      }
      
      public function get ration() : int
      {
         return !!_obj.hasOwnProperty("ration")?_obj["ration"]:-1;
      }
      
      public function isPractice() : Boolean
      {
         return enemyID != -1;
      }
      
      public function isNormalBattle() : Boolean
      {
         if(isPractice())
         {
            return true;
         }
         return _cellEventKind == 1;
      }
      
      public function isNightOnlyBattle() : Boolean
      {
         if(isPractice())
         {
            return false;
         }
         if(_cellEventFlg > 0)
         {
            return _cellEventKind == 2;
         }
         return _cellColor == 6;
      }
      
      public function isNightDayBattle() : Boolean
      {
         if(isPractice())
         {
            return false;
         }
         if(_cellEventFlg > 0)
         {
            return _cellEventKind == 3;
         }
         return _cellColor == 7 || _cellColor == 8;
      }
      
      public function isAerialWarfare() : Boolean
      {
         if(isPractice())
         {
            return false;
         }
         return _cellEventKind == 4;
      }
      
      public function isLongDistanceAirRaid() : Boolean
      {
         if(isPractice())
         {
            return false;
         }
         return _cellEventKind == 6;
      }
      
      public function isBossMap() : Boolean
      {
         if(isPractice())
         {
            return false;
         }
         if(_cellEventFlg > 0)
         {
            return _cellEventFlg == 5;
         }
         return _cellColor == 5 || _cellColor == 8;
      }
      
      public function getCombinedType() : int
      {
         return Util.getInt(_obj,"deckType",0);
      }
      
      public function isCombinedFriend() : Boolean
      {
         var _loc1_:int = 0;
         if(shipsF2 == null)
         {
            return false;
         }
         if(!(shipsF2 is Array))
         {
            return false;
         }
         _loc1_ = 0;
         while(_loc1_ < shipsF2.length)
         {
            if(shipsF2[_loc1_] != null)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function isCombinedEnemy() : Boolean
      {
         if(isPractice())
         {
            return false;
         }
         return _cellEventKind == 5;
      }
      
      public function get exBossDefeat() : int
      {
         return Util.getInt(exBossObj,"api_defeat_count",exBossDefeatRequest);
      }
      
      public function get exBossDefeatRequest() : int
      {
         return Util.getInt(exBossObj,"api_required_defeat_count",0);
      }
      
      private function get exBossObj() : Object
      {
         return Util.getObject(_obj,"exboss",{});
      }
      
      public function get eventMapHPMax() : int
      {
         return Util.getInt(eventMapObj,"api_max_maphp",0);
      }
      
      public function get mapHPNow() : int
      {
         return Util.getInt(eventMapObj,"api_now_maphp",0);
      }
      
      public function get mapHPDmg() : int
      {
         return Util.getInt(eventMapObj,"api_dmg",0);
      }
      
      public function isInvalidationBoss() : Boolean
      {
         return false;
      }
      
      public function getEventMapHPType() : int
      {
         return Util.getInt(_obj,"gaugeType",1);
      }
      
      public function hasNextGaugeOnEventMap() : Boolean
      {
         return mapID == 373 && Util.getInt(_obj,"stage",1) == 1;
      }
      
      public function hasPrevGaugeOnEventMap() : Boolean
      {
         return mapID == 373 && Util.getInt(_obj,"stage",1) == 2;
      }
      
      private function get eventMapObj() : Object
      {
         return Util.getObject(_obj,"eventmap",{});
      }
      
      public function set shipsF(param1:Array) : void
      {
         _obj["ships_f"] = param1;
      }
      
      public function get shipsF() : Array
      {
         return Util.getArray(_obj,"ships_f",[]);
      }
      
      public function set shipsF2(param1:Array) : void
      {
         _obj["ships_f_2"] = param1;
      }
      
      public function get shipsF2() : Array
      {
         return Util.getArray(_obj,"ships_f_2",[]);
      }
      
      public function set shipsE(param1:Array) : void
      {
         _obj["ships_e"] = param1;
      }
      
      public function get shipsE() : Array
      {
         return Util.getArray(_obj,"ships_e",[]);
      }
      
      public function set shipsE2(param1:Array) : void
      {
         _obj["ships_e_2"] = param1;
      }
      
      public function get shipsE2() : Array
      {
         return Util.getArray(_obj,"ships_e_2",[]);
      }
      
      public function setEscapeCandidate(param1:Array, param2:Array) : void
      {
         _obj["escape_idx"] = param1;
         _obj["tow_idx"] = param2;
      }
      
      public function hasEscapeCandidate() : Boolean
      {
         return escape_cadidate.length > 0 && tow_cadidate.length > 0;
      }
      
      public function get escape_cadidate() : Array
      {
         return Util.getArray(_obj,"escape_idx",[]);
      }
      
      public function get tow_cadidate() : Array
      {
         return Util.getArray(_obj,"tow_idx",[]);
      }
      
      public function get __t__() : Number
      {
         return Util.getNumber(_obj,"__t__");
      }
      
      public function set __t__(param1:Number) : void
      {
         _obj["__t__"] = param1;
      }
      
      public function get __c__() : int
      {
         return Util.getInt(_obj,"__c__");
      }
      
      public function set __c__(param1:int) : void
      {
         _obj["__c__"] = param1;
      }
      
      public function get m1() : int
      {
         return _obj["__m1__"];
      }
      
      public function set m1(param1:int) : void
      {
         _obj["__m1__"] = param1;
      }
      
      public function createObject() : Object
      {
         return _obj;
      }
      
      public function setDataForBattle(param1:int, param2:int, param3:int, param4:int, param5:Object, param6:Object, param7:int, param8:int) : void
      {
         if(_obj == null)
         {
            _obj = {};
         }
         _obj["deckID"] = param1;
         _obj["formationID"] = param2;
         _obj["marchingType"] = param3;
         _obj["gaugeType"] = param4;
         _obj["eventmap"] = param5;
         _obj["exboss"] = param6;
         _obj["deckType"] = param7;
         _obj["stage"] = param8;
      }
      
      public function setMapInformation(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Boolean) : void
      {
         if(_obj == null)
         {
            _obj = {};
         }
         _obj["areaID"] = param1;
         _obj["mapNo"] = param2;
         _obj["mapID"] = param3;
         _obj["cellID"] = param4;
         _obj["cellColor"] = param5;
         _obj["cellEventFlg"] = param6;
         _obj["cellEventKind"] = param7;
         _obj["hasNext"] = param8;
      }
      
      public function setBoukuuData(param1:Object) : void
      {
         if(_obj == null)
         {
            _obj = {};
         }
         _obj["boku"] = param1;
      }
      
      public function getBoukuuData() : Object
      {
         return !!_obj.hasOwnProperty("boku")?_obj["boku"]:null;
      }
      
      public function setSelectResultsBeforeBattle(param1:int, param2:int) : void
      {
         if(_obj == null)
         {
            _obj = {};
         }
         _obj["underwayReplenishment"] = param1;
         _obj["ration"] = param2;
      }
      
      public function setDataForPractice(param1:int, param2:int, param3:int, param4:int) : void
      {
         _obj = {
            "deckID":param1,
            "formationID":param2,
            "enemyID":param3,
            "medalNum":param4
         };
      }
      
      public function setEmulateData(param1:String, param2:Object) : void
      {
         var _loc3_:Object = Util.getObject(_obj,"emulate_data",{});
         _loc3_[param1] = param2;
         _obj["emulate_data"] = _loc3_;
      }
      
      public function getEmulateData(param1:String) : Object
      {
         var _loc2_:Object = _getDebugAPIData();
         return Util.getObject(_loc2_,param1,null);
      }
      
      public function setResultEmulateData(param1:String, param2:Object) : void
      {
         var _loc3_:Object = Util.getObject(_obj,"emulate_data",{});
         if(_loc3_.hasOwnProperty("result") == false)
         {
            _loc3_["result"] = {};
         }
         var _loc4_:Object = _loc3_["result"];
         _loc4_[param1] = param2;
         _obj["emulate_data"] = _loc3_;
      }
      
      public function getResultEmulateData(param1:String) : Object
      {
         var _loc2_:Object = Util.getObject(_obj,"emulate_data",{});
         var _loc3_:Object = Util.getObject(_loc2_,"result",{});
         return Util.getObject(_loc3_,param1,null);
      }
      
      private function _getDebugAPIData() : Object
      {
         return Util.getObject(_obj,"emulate_data",{});
      }
   }
}
