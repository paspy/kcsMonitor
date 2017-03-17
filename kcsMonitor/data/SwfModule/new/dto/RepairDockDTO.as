package dto
{
   import vo.BaseData;
   
   public class RepairDockDTO extends BaseData
   {
      
      public static const STATE_CLOSE:int = -1;
      
      public static const STATE_NONE:int = 0;
      
      public static const STATE_REPAIR:int = 1;
       
      
      private var _o:Object;
      
      public function RepairDockDTO(param1:Object)
      {
         super();
         _o = param1;
      }
      
      public function isDockOpen() : Boolean
      {
         return _getInt(_o,"api_state") > -1;
      }
      
      public function get dockID() : int
      {
         return _getInt(_o,"api_id",0);
      }
      
      public function get state() : int
      {
         return _getInt(_o,"api_state",0);
      }
      
      public function get shipID() : int
      {
         return _getInt(_o,"api_ship_id",0);
      }
      
      public function get completeTime() : Number
      {
         return _getNumber(_o,"api_complete_time");
      }
      
      public function isComplete() : Boolean
      {
         var _loc1_:Number = NaN;
         if(isDockOpen() && shipID != 0)
         {
            _loc1_ = new Date().getTime();
            return completeTime < _loc1_;
         }
         return false;
      }
   }
}
