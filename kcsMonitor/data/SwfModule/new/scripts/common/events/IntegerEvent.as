package common.events
{
   import flash.events.Event;
   
   public class IntegerEvent extends Event
   {
       
      
      public var data:int = 0;
      
      public function IntegerEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         this.data = param2;
         super(param1,param3,param4);
      }
   }
}
