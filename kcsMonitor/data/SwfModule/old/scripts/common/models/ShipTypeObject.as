package common.models
{
   import common.util.Util;
   
   public class ShipTypeObject
   {
       
      
      private var _o:Object;
      
      public function ShipTypeObject(param1:Object)
      {
         super();
         _o = param1;
      }
      
      public function get id() : int
      {
         return Util.getInt(_o,"api_id",0);
      }
      
      public function get sortNo() : int
      {
         return Util.getInt(_o,"api_sortno",0);
      }
      
      public function get name() : String
      {
         return Util.getString(_o,"api_name","");
      }
      
      public function get slotCount() : int
      {
         return Util.getInt(_o,"api_scnt",0);
      }
      
      public function get buildPhaseCount() : int
      {
         return Util.getInt(_o,"api_kcnt",3);
      }
      
      public function get equipTypes() : Array
      {
         var _loc1_:Object = Util.getObject(_o,"api_equip_type",{});
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _loc1_;
         for(var _loc2_ in _loc1_)
         {
            if(_loc1_[_loc2_] == 1)
            {
               _loc3_.push(parseInt(_loc2_));
            }
         }
         return _loc3_;
      }
      
      public function isEquip(param1:int) : Boolean
      {
         return equipTypes.indexOf(param1) != -1;
      }
   }
}
