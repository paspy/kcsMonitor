package vo
{
   import common.util.MathUtil;
   import common.util.Util;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class StartData extends BaseData
   {
       
      
      private var _shipGraphData:Dictionary;
      
      private var _furnitureGraphData:Dictionary;
      
      public function StartData()
      {
         super();
         _shipGraphData = new Dictionary();
         _furnitureGraphData = new Dictionary();
      }
      
      public function setData(param1:Object) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = param1["api_mst_shipgraph"];
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc2_ = _loc3_[_loc5_]["api_id"];
            _shipGraphData[_loc2_] = _loc3_[_loc5_];
            _loc5_++;
         }
         _loc3_ = param1["api_mst_furnituregraph"];
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc5_]["api_id"];
            _furnitureGraphData[_loc4_] = _loc3_[_loc5_];
            _loc5_++;
         }
      }
      
      public function getShipFileName(param1:int) : String
      {
         if(_shipGraphData.hasOwnProperty(param1.toString()))
         {
            return _shipGraphData[param1.toString()].api_filename;
         }
         return "";
      }
      
      public function getShipVersion(param1:int) : String
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_shipGraphData.hasOwnProperty(param1.toString()))
         {
            _loc3_ = _shipGraphData[param1.toString()];
            _loc2_ = Util.getArray(_loc3_,"api_version");
            if(_loc2_ != null && _loc2_.length > 0)
            {
               return _loc2_[0] as String;
            }
         }
         return "";
      }
      
      public function getShipVoiceVersion(param1:int) : String
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_shipGraphData.hasOwnProperty(param1.toString()))
         {
            _loc3_ = _shipGraphData[param1.toString()];
            _loc2_ = Util.getArray(_loc3_,"api_version");
            if(_loc2_ != null && _loc2_.length > 1)
            {
               return _loc2_[1] as String;
            }
         }
         return "";
      }
      
      public function getShipVoiceVersion2(param1:int) : String
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_shipGraphData.hasOwnProperty(param1.toString()))
         {
            _loc3_ = _shipGraphData[param1.toString()];
            _loc2_ = Util.getArray(_loc3_,"api_version");
            if(_loc2_ != null && _loc2_.length > 2)
            {
               return _loc2_[2] as String;
            }
         }
         return "";
      }
      
      public function getOffsetInRemodelPowupUI(param1:int, param2:Boolean = false) : Point
      {
         var _loc3_:Array = _getArray(_getOffsetObject(param1),!!param2?"api_kaisyu_d":"api_kaisyu_n",[0,0]);
         return new Point(_loc3_[0],_loc3_[1]);
      }
      
      public function getOffsetInPortMain(param1:int, param2:Boolean = false) : Point
      {
         var _loc3_:Array = _getArray(_getOffsetObject(param1),!!param2?"api_boko_d":"api_boko_n",[0,0]);
         return new Point(_loc3_[0],_loc3_[1]);
      }
      
      public function getOffsetAtCenterShip(param1:int, param2:Boolean = false) : Point
      {
         var _loc3_:Array = _getArray(_getOffsetObject(param1),!!param2?"api_kaizo_d":"api_kaizo_n",[0,0]);
         return new Point(_loc3_[0],_loc3_[1]);
      }
      
      public function getOffsetAtRightShip(param1:int, param2:Boolean = false) : Point
      {
         var _loc4_:Array = _getArray(_getOffsetObject(param1),!!param2?"api_ensyue_d":"api_ensyue_n",[0,0]);
         var _loc3_:Array = _getArray(_getOffsetObject(param1),!!param2?"api_ensyuf_d":"api_ensyuf_n",[0,0]);
         return new Point(_loc4_[0],_loc3_[1]);
      }
      
      public function getOffsetAtLeftShip(param1:int, param2:Boolean = false) : Point
      {
         var _loc3_:Array = _getArray(_getOffsetObject(param1),!!param2?"api_ensyuf_d":"api_ensyuf_n",[0,0]);
         return new Point(_loc3_[0],_loc3_[1]);
      }
      
      public function getOffsetAtMap(param1:int, param2:Boolean = false) : Point
      {
         var _loc4_:String = !!param2?"api_map_d":"api_map_n";
         var _loc3_:Array = _getArray(_getOffsetObject(param1),_loc4_,[0,0]);
         return new Point(_loc3_[0],_loc3_[1]);
      }
      
      public function getOffsetAtBattle(param1:int, param2:Boolean = false) : Point
      {
         var _loc4_:String = !!param2?"api_battle_d":"api_battle_n";
         var _loc3_:Array = _getArray(_getOffsetObject(param1),_loc4_,[0,0]);
         return new Point(_loc3_[0],_loc3_[1]);
      }
      
      public function getRectOfFace(param1:int, param2:Boolean = false) : Rectangle
      {
         var _loc6_:String = "api_weda";
         var _loc4_:String = "api_wedb";
         var _loc3_:Array = _getArray(_getOffsetObject(param1),_loc6_,[0,0]);
         var _loc5_:Array = _getArray(_getOffsetObject(param1),_loc4_,[0,0]);
         return new Rectangle(_loc3_[0],_loc3_[1],_loc5_[0],_loc5_[1]);
      }
      
      public function getFacePoint(param1:int, param2:Boolean = false) : Point
      {
         var _loc3_:Rectangle = getRectOfFace(param1,param2);
         return new Point(_loc3_.x + _loc3_.width / 2,_loc3_.y + _loc3_.height / 2);
      }
      
      public function getFurnitureAnimationType(param1:int) : int
      {
         if(_furnitureGraphData.hasOwnProperty(param1))
         {
            return 1;
         }
         return 0;
      }
      
      public function getFurnitureFileName(param1:int, param2:int) : String
      {
         var _loc4_:String = "";
         var _loc3_:int = DataFacade.getMasterFurnitureData().getID(param1,param2);
         if(_furnitureGraphData.hasOwnProperty(_loc3_))
         {
            _loc4_ = Util.getString(_furnitureGraphData[_loc3_],"api_filename");
         }
         if(_loc4_ == "")
         {
            _loc4_ = MathUtil.digit3(param2 + 1);
         }
         return _loc4_;
      }
      
      public function getFurnitureVersion(param1:int, param2:int) : String
      {
         var _loc4_:String = "1";
         var _loc3_:int = DataFacade.getMasterFurnitureData().getID(param1,param2);
         if(_furnitureGraphData.hasOwnProperty(_loc3_))
         {
            _loc4_ = Util.getString(_furnitureGraphData[_loc3_],"api_version");
         }
         return _loc4_;
      }
      
      private function _getOffsetObject(param1:int) : Object
      {
         if(_shipGraphData.hasOwnProperty(param1))
         {
            return _shipGraphData[param1];
         }
         return {};
      }
   }
}
