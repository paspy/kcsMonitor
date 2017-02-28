package vo
{
   import common.debug.Debug;
   
   public class BaseData
   {
       
      
      public function BaseData()
      {
         super();
      }
      
      protected function _getInt(param1:Object, param2:String, param3:int = 0) : int
      {
         return _getProp(param1,param2,param3);
      }
      
      protected function _getNumber(param1:Object, param2:String, param3:Number = 0.0) : Number
      {
         return _getProp(param1,param2,param3);
      }
      
      protected function _getString(param1:Object, param2:String, param3:String = "") : String
      {
         return _getProp(param1,param2,param3);
      }
      
      protected function _getBoolean(param1:Object, param2:String, param3:Boolean = false) : Boolean
      {
         return _getString(param1,param2,!!param3?"true":"false") == "true";
      }
      
      protected function _getArray(param1:Object, param2:String, param3:Array = null) : Array
      {
         var _loc4_:Array = _getProp(param1,param2,param3);
         return !!_loc4_?_loc4_:param3;
      }
      
      protected function _getObject(param1:Object, param2:String, param3:Object = null) : Object
      {
         return _getProp(param1,param2,param3);
      }
      
      protected function _getProp(param1:Object, param2:String, param3:*) : *
      {
         if(param1 && param1.hasOwnProperty(param2))
         {
            return param1[param2];
         }
         Debug.log("[W] no property " + param2);
         return param3;
      }
   }
}
