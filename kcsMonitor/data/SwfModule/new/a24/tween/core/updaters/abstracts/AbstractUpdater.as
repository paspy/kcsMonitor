package a24.tween.core.updaters.abstracts
{
   public class AbstractUpdater
   {
       
      
      protected var _tweenFlag:uint;
      
      protected var _updateFlag:uint;
      
      protected var _$updateFlag:uint;
      
      protected var _$$updateFlag:uint;
      
      public function AbstractUpdater()
      {
         super();
      }
      
      public function initFlag() : void
      {
         _tweenFlag = _updateFlag;
      }
      
      public function update(param1:Number) : AbstractUpdater
      {
         return this;
      }
      
      public function complete() : void
      {
         update(1);
      }
      
      public function overwrite(param1:AbstractUpdater) : void
      {
         var _loc3_:uint = param1._tweenFlag;
         var _loc2_:uint = _tweenFlag;
         _tweenFlag = _loc3_ ^ (_loc3_ | _loc2_);
      }
      
      public function toString() : String
      {
         return "";
      }
      
      protected function formatToString(param1:String, ... rest) : String
      {
         if(rest.length == 1)
         {
            return " " + param1 + ":" + rest;
         }
         return " " + param1 + ":[" + rest.join(" ") + "]";
      }
   }
}
