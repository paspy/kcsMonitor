package dto
{
   import common.util.Util;
   
   public class SupplyDTO
   {
       
      
      private var _o:Object;
      
      private var _ships:Array;
      
      public function SupplyDTO(param1:Object = null)
      {
         super();
         setData(param1);
      }
      
      public function setData(param1:Object) : void
      {
         _o = param1;
         _ships = Util.getArray(_o,"api_ship",[]);
      }
      
      public function get fuel() : int
      {
         return Util.getArray(_o,"api_material",[0,0,0,0])[0];
      }
      
      public function get ammo() : int
      {
         return Util.getArray(_o,"api_material",[0,0,0,0])[1];
      }
      
      public function get steel() : int
      {
         return Util.getArray(_o,"api_material",[0,0,0,0])[2];
      }
      
      public function get baux() : int
      {
         return Util.getArray(_o,"api_material",[0,0,0,0])[3];
      }
      
      public function useBaux() : Boolean
      {
         return Util.getInt(_o,"api_use_bou",0) > 0;
      }
      
      public function getShipCount() : int
      {
         return _ships.length;
      }
      
      public function getShipID(param1:int) : int
      {
         return Util.getInt(_ships[param1],"api_id");
      }
      
      public function getShipFuel(param1:int) : int
      {
         return Util.getInt(_ships[param1],"api_fuel");
      }
      
      public function getShipAmmo(param1:int) : int
      {
         return Util.getInt(_ships[param1],"api_bull");
      }
      
      public function getShipOnSlot(param1:int) : Array
      {
         return Util.getArray(_ships[param1],"api_onslot",[]);
      }
   }
}
