package common.events
{
   import flash.events.Event;
   
   public class BooleanEvent extends Event
   {
       
      
      public var data:Boolean = false;
      
      public function BooleanEvent(param1:String, param2:Boolean, param3:Boolean = false, param4:Boolean = false)
      {
         this.data = param2;
         super(param1,param3,param4);
      }
   }
}
