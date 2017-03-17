package vo
{
   import common.debug.Debug;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import manager.MissionManager;
   
   public class UserDeckData extends BaseData
   {
       
      
      private var _userDecks:Dictionary;
      
      private var _deckCount:int = 0;
      
      private var _shipsArr:Array;
      
      private var _shipsDic:Dictionary;
      
      private var _missionManager:MissionManager;
      
      private var _combinedType:int = 0;
      
      private var _combinedDeck:Array;
      
      private var _autoUnCombinedDeck:int = 0;
      
      public function UserDeckData()
      {
         _missionManager = new MissionManager();
         super();
         _shipsArr = [];
         _combinedDeck = [];
      }
      
      public function get autoUnCombinedDeck() : int
      {
         return _autoUnCombinedDeck;
      }
      
      public function get deckCount() : int
      {
         return _deckCount;
      }
      
      public function get shipCount() : int
      {
         return _shipsArr.length;
      }
      
      public function get vacancyCount() : int
      {
         var _loc1_:int = DataFacade.getUserData().getMaxShipCount();
         return _loc1_ - shipCount;
      }
      
      public function get missionManager() : MissionManager
      {
         return _missionManager;
      }
      
      public function setDeckData(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _userDecks = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1[_loc3_];
            if(_loc2_ != null)
            {
               _userDecks[_loc2_.api_id] = _loc2_;
            }
            _loc3_++;
         }
         _deckCount = param1.length;
         _missionManager.update(param1);
      }
      
      public function updateDeckData(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_ = param1[_loc5_];
            if(_loc3_ != null)
            {
               _userDecks[_loc3_.api_id] = _loc3_;
            }
            _loc5_++;
         }
         var _loc4_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _userDecks;
         for each(var _loc2_ in _userDecks)
         {
            _loc4_.push(_loc2_);
         }
         _loc4_.sortOn("api_id");
         _missionManager.update(_loc4_);
      }
      
      public function setShipData(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _shipsDic = new Dictionary();
         _shipsArr = param1;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] != null)
            {
               _loc2_ = new UserShipData(param1[_loc3_]);
               _shipsDic[_loc2_.getShipID()] = _loc2_;
            }
            _loc3_++;
         }
      }
      
      public function updateShipData(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:Vector.<int> = new Vector.<int>();
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            if(param1[_loc6_] != null)
            {
               _loc4_ = new UserShipData(param1[_loc6_]);
               _shipsDic[_loc4_.getShipID()] = _loc4_;
               _loc3_.push(_loc4_.getShipID());
            }
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _shipsArr.length)
         {
            _loc5_ = _shipsArr[_loc6_]["api_id"];
            _loc2_ = _loc3_.indexOf(_loc5_);
            if(_loc2_ >= 0)
            {
               _shipsArr[_loc6_] = param1.splice(_loc2_,1)[0];
               _loc3_.splice(_loc2_,1);
            }
            _loc6_++;
         }
         if(param1.length > 0)
         {
            _shipsArr.push(param1);
         }
      }
      
      public function setShipDataOneShip(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:UserShipData = new UserShipData(param1);
         _shipsDic[_loc2_.getShipID()] = _loc2_;
         _loc3_ = 0;
         while(_loc3_ < _shipsArr.length)
         {
            if(_shipsArr[_loc3_]["api_id"] == _loc2_.getShipID())
            {
               _shipsArr[_loc3_] = param1;
            }
            _loc3_++;
         }
      }
      
      public function setCombinedFlag(param1:int) : void
      {
         _combinedType = param1;
         _autoUnCombinedDeck = 0;
         if(param1 == 1)
         {
            Debug.log("====連合艦隊(機動部隊)====");
            _combinedDeck = [1,2];
         }
         else if(param1 == 2)
         {
            Debug.log("====連合艦隊(水上部隊)====");
            _combinedDeck = [1,2];
         }
         else if(param1 == 3)
         {
            Debug.log("====連合艦隊(輸送部隊)====");
            _combinedDeck = [1,2];
         }
         else
         {
            Debug.log("====連合艦隊ではない====");
            _combinedDeck = [];
            if(param1 < 0)
            {
               _autoUnCombinedDeck = param1 * -1;
            }
         }
      }
      
      public function getCombinedType(param1:int = 1) : int
      {
         if(_combinedDeck.indexOf(param1) != -1)
         {
            return _combinedType;
         }
         return 0;
      }
      
      public function getCombinedMainDeckID(param1:int) : int
      {
         var _loc2_:int = _combinedDeck.indexOf(param1);
         if(_loc2_ == -1)
         {
            return -1;
         }
         if(_loc2_ % 2 == 1)
         {
            return _combinedDeck[_loc2_ - 1];
         }
         return _combinedDeck[_loc2_];
      }
      
      public function getCombinedSubDeckID(param1:int) : int
      {
         var _loc2_:int = _combinedDeck.indexOf(param1);
         if(_loc2_ == -1)
         {
            return -1;
         }
         if(_loc2_ % 2 == 0)
         {
            return _combinedDeck[_loc2_ + 1];
         }
         return _combinedDeck[_loc2_];
      }
      
      public function isExistDeck(param1:int) : Boolean
      {
         return _userDecks && _userDecks.hasOwnProperty(param1);
      }
      
      public function getName(param1:int) : String
      {
         if(isExistDeck(param1))
         {
            return _userDecks[param1]["api_name"];
         }
         Debug.log("UserDeckData::getName. deckID=" + param1 + " is no data");
         return "";
      }
      
      public function getMissionList() : Array
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _deckCount)
         {
            _loc1_ = missionManager.getMissionID(_loc3_ + 1);
            _loc2_.push(_loc1_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getNameID(param1:int) : String
      {
         if(isExistDeck(param1))
         {
            return _userDecks[param1]["api_name_id"];
         }
         Debug.log("UserDeckData::getNameID. deckID=" + param1 + " is no data");
         return "";
      }
      
      public function getAllShip() : Vector.<UserShipData>
      {
         var _loc2_:Vector.<UserShipData> = new Vector.<UserShipData>();
         var _loc4_:int = 0;
         var _loc3_:* = _shipsDic;
         for each(var _loc1_ in _shipsDic)
         {
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
      
      public function getShipData(param1:int) : UserShipData
      {
         if(_shipsDic.hasOwnProperty(param1))
         {
            return _shipsDic[param1];
         }
         return null;
      }
      
      public function getCharaIDList() : Array
      {
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc1_:* = null;
         var _loc4_:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = _userDecks;
         for(var _loc2_ in _userDecks)
         {
            _loc3_ = parseInt(_loc2_);
            _loc6_ = _getShipIDs(_loc3_);
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               _loc1_ = getShipData(_loc6_[_loc5_]);
               if(_loc1_ != null)
               {
                  _loc4_.push(_loc1_.getCharaID());
               }
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      public function getFlagShipData(param1:int) : UserShipData
      {
         var _loc3_:int = 0;
         var _loc2_:Array = _getShipIDs(param1);
         if(_loc2_.length > 0)
         {
            _loc3_ = _loc2_[0];
            return getShipData(_loc3_);
         }
         return null;
      }
      
      public function getShipDataInDeck(param1:int) : Array
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:Array = _getShipIDs(param1);
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_ = getShipData(_loc4_[_loc5_]);
            _loc3_.push(_loc2_);
            _loc5_++;
         }
         while(_loc3_.length < 6)
         {
            _loc3_.push(null);
         }
         return _loc3_;
      }
      
      public function getShipDataInCombinedDeck(param1:int) : Array
      {
         var _loc3_:int = getCombinedMainDeckID(param1);
         if(_loc3_ == -1)
         {
            return getShipDataInDeck(param1);
         }
         var _loc2_:int = getCombinedSubDeckID(param1);
         if(_loc2_ == -1)
         {
            return getShipDataInDeck(param1);
         }
         var _loc5_:Array = getShipDataInDeck(_loc3_);
         var _loc4_:Array = getShipDataInDeck(_loc2_);
         return _loc5_.concat(_loc4_);
      }
      
      public function getShipTypeCountInDeck(param1:int, param2:int) : int
      {
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:Array = getShipDataInDeck(param1);
         _loc7_ = 0;
         while(_loc7_ < _loc6_.length)
         {
            if(_loc6_[_loc7_] != null)
            {
               _loc5_ = _loc6_[_loc7_];
               _loc3_ = _loc5_.getShipType();
               if(_loc3_ == param2)
               {
                  _loc4_++;
               }
            }
            _loc7_++;
         }
         return _loc4_;
      }
      
      function __setDeck(param1:int, param2:Array) : void
      {
         _userDecks[param1]["api_ship"] = param2;
      }
      
      function __getDeck(param1:int) : Array
      {
         return _userDecks[param1]["api_ship"];
      }
      
      public function getShipPos(param1:int, param2:int) : int
      {
         var _loc5_:int = 0;
         var _loc3_:* = -1;
         var _loc4_:Array = _userDecks[param1]["api_ship"];
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            if(param2 == _loc4_[_loc5_])
            {
               _loc3_ = _loc5_;
               break;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function getShipCountInDeck(param1:int, param2:Boolean = false) : int
      {
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc6_:Array = getShipDataInDeck(param1);
         var _loc3_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc7_] as UserShipData;
            if(_loc5_ != null)
            {
               if(param2)
               {
                  _loc4_ = _loc5_.getCondition();
                  if(_loc4_ != 0)
                  {
                     _loc3_++;
                  }
               }
               else
               {
                  _loc3_++;
               }
            }
            _loc7_++;
         }
         return _loc3_;
      }
      
      public function getDeckDataForBattle() : Object
      {
         var _loc5_:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:Object = {
            "decks":[],
            "ships":getShipDataArrayForBattleALL()
         };
         var _loc7_:int = 0;
         var _loc6_:* = _userDecks;
         for(var _loc4_ in _userDecks)
         {
            _loc5_ = parseInt(_loc4_);
            _loc1_ = _userDecks[_loc5_];
            _loc3_ = new ByteArray();
            _loc3_.writeObject(_loc1_);
            _loc3_.position = 0;
            _loc2_["decks"][_loc5_] = _loc3_.readObject();
         }
         return _loc2_;
      }
      
      public function getShipDataArrayForBattleALL() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         _loc2_ = 1;
         while(_loc2_ <= deckCount)
         {
            _loc3_ = _loc3_.concat(getShipDataArrayForBattle(_loc2_));
            _loc2_++;
         }
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_] != null)
            {
               _loc1_.push(_loc3_[_loc2_]);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getShipDataArrayForBattle(param1:int) : Array
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:Array = [];
         var _loc5_:Array = getShipDataInDeck(param1);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc2_ = _loc5_[_loc6_] as UserShipData;
            if(_loc2_ != null)
            {
               _loc4_ = _loc2_.cloneOriginalObject();
               _loc3_.push(_loc4_);
            }
            else
            {
               _loc3_.push(null);
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      public function getShipDataFromAllDeckForBattle() : Dictionary
      {
         var _loc3_:int = 0;
         var _loc1_:Dictionary = new Dictionary();
         var _loc5_:int = 0;
         var _loc4_:* = _userDecks;
         for(var _loc2_ in _userDecks)
         {
            _loc3_ = parseInt(_loc2_);
            _loc1_[_loc3_] = getShipDataArrayForBattle(_loc3_);
         }
         return _loc1_;
      }
      
      public function getSortedShipList(param1:Boolean, param2:Boolean, param3:int, param4:Boolean = false, param5:Array = null) : Vector.<UserShipData>
      {
         var _loc11_:int = 0;
         var _loc6_:* = 0;
         var _loc9_:* = null;
         var _loc7_:* = null;
         var _loc10_:Boolean = false;
         var _loc14_:Vector.<UserShipData> = new Vector.<UserShipData>();
         var _loc12_:Array = _getSortedIndexList(param3,param4);
         var _loc13_:Array = [];
         var _loc8_:Array = [];
         _loc11_ = 1;
         while(_loc11_ <= 4)
         {
            if(isExistDeck(_loc11_))
            {
               _loc13_.push.apply(null,_getShipIDs(_loc11_));
            }
            _loc11_++;
         }
         _loc11_ = 0;
         while(_loc11_ < _loc12_.length)
         {
            _loc6_ = uint(_loc12_[_loc11_]);
            _loc9_ = _shipsArr[_loc6_];
            _loc7_ = new UserShipData(_loc9_);
            _loc10_ = false;
            if(param1 && _loc13_.indexOf(_loc7_.getShipID()) != -1)
            {
               _loc10_ = true;
            }
            if(param2 && (_loc7_.isLocked() || _loc7_.isEquipLockedItem()))
            {
               _loc10_ = true;
            }
            if(param5 != null && param5.indexOf(_loc7_.getShipID()) != -1)
            {
               _loc10_ = true;
            }
            if(!_loc10_)
            {
               _loc14_.push(_loc7_);
            }
            _loc11_++;
         }
         return _loc14_;
      }
      
      private function _getDeckData(param1:int) : Object
      {
         if(isExistDeck(param1))
         {
            return _userDecks[param1];
         }
         return null;
      }
      
      private function _getShipIDs(param1:int) : Array
      {
         var _loc2_:Object = _getDeckData(param1);
         if(_loc2_)
         {
            return _getArray(_loc2_,"api_ship",[]).concat();
         }
         Debug.log("UserDeckData::getShipIDs. deckID=" + param1 + " is no data.");
         return [];
      }
      
      private function _getSortedIndexList(param1:int, param2:Boolean = false) : Array
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         switch(int(param1))
         {
            case 0:
               _loc3_ = ["api_lv","api_sortno","api_id"];
               if(param2)
               {
                  _loc4_ = [16 | 2 | 8,16,16];
               }
               else
               {
                  _loc4_ = [16 | 8,16 | 2,16 | 2];
               }
               break;
            case 1:
               _loc3_ = ["api_stype","api_sortno","api_lv","api_id"];
               if(param2)
               {
                  _loc4_ = [16 | 2 | 8,16,16 | 2,16];
               }
               else
               {
                  _loc4_ = [16 | 8,16 | 2,16,16 | 2];
               }
               break;
            default:
               _loc3_ = ["api_id"];
               if(param2)
               {
                  _loc4_ = [16 | 2 | 8];
                  break;
               }
               _loc4_ = [16 | 8];
               break;
            case 3:
               _loc3_ = ["hp_rate","api_sortno","api_id"];
               if(param2)
               {
                  _loc4_ = [16 | 8,16,16];
               }
               else
               {
                  _loc4_ = [16 | 2 | 8,16 | 2,16 | 2];
               }
         }
         return _shipsArr.sortOn(_loc3_,_loc4_);
      }
      
      function __addShip(param1:Object) : void
      {
         var _loc2_:UserShipData = new UserShipData(param1);
         _shipsDic[_loc2_.getShipID()] = _loc2_;
         _shipsArr.push(param1);
      }
      
      function __removeShip(param1:UserShipData) : void
      {
         var _loc2_:int = 0;
         if(param1.isLocked() || param1.isEquipLockedItem() || param1.isInDeck() >= 0)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _shipsArr.length)
         {
            if(_shipsArr[_loc2_]["api_id"] == param1.getShipID())
            {
               _shipsArr.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
         if(_shipsDic.hasOwnProperty(param1.getShipID()))
         {
            delete _shipsDic[param1.getShipID()];
         }
      }
      
      function __setDeckName(param1:int, param2:String) : void
      {
         if(isExistDeck(param1))
         {
            _userDecks[param1]["api_name"] = param2;
         }
      }
   }
}
