package common.models
{
   import common.util.Util;
   
   public class BattleBGMObject
   {
       
      
      private var _o:Object;
      
      public function BattleBGMObject(param1:Object = null)
      {
         super();
         _o = param1 == null?{}:param1;
      }
      
      public function get mapID() : int
      {
         return Util.getInt(_o,"api_id",-1);
      }
      
      public function isDayBGM(param1:Boolean) : int
      {
         return _getBGMObject(param1)[0];
      }
      
      public function isNightBGM(param1:Boolean) : int
      {
         return _getBGMObject(param1)[1];
      }
      
      public function isSameBGM(param1:Boolean) : Boolean
      {
         var _loc2_:Array = _getBGMObject(param1);
         return _loc2_[0] == _loc2_[1];
      }
      
      private function _getBGMObject(param1:Boolean) : Array
      {
         return !!param1?_getBGMBossObject():_getBGMZakoObject();
      }
      
      private function _getBGMZakoObject() : Array
      {
         return Util.getArray(_o,"api_map_bgm",[0,0]);
      }
      
      private function _getBGMBossObject() : Array
      {
         return Util.getArray(_o,"api_boss_bgm",[0,0]);
      }
   }
}
