package common.models
{
   import flash.utils.Dictionary;
   
   public class MissionData
   {
       
      
      private var _dic:Dictionary;
      
      public function MissionData()
      {
         super();
         _dic = new Dictionary();
      }
      
      public function setData(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _dic = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new MissionObject(param1[_loc3_]);
            _dic[_loc2_.missionID] = _loc2_;
            _loc3_++;
         }
      }
      
      public function getData(param1:int) : MissionObject
      {
         if(_dic.hasOwnProperty(param1))
         {
            return _dic[param1];
         }
         return null;
      }
      
      public function getCounts() : Array
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc4_:Array = [];
         var _loc9_:int = 0;
         var _loc8_:* = _dic;
         for each(var _loc3_ in _dic)
         {
            _loc2_ = _loc3_ as MissionObject;
            if(_loc2_ != null)
            {
               _loc1_ = _loc2_.areaID;
               while(_loc4_.length <= _loc1_)
               {
                  _loc4_.push(0);
               }
               var _loc5_:* = _loc4_;
               var _loc6_:* = _loc1_;
               var _loc7_:* = Number(_loc5_[_loc6_]) + 1;
               _loc5_[_loc6_] = _loc7_;
            }
         }
         return _loc4_;
      }
   }
}
