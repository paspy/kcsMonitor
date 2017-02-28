package common.util
{
   public class DateTimeUtil
   {
       
      
      public function DateTimeUtil()
      {
         super();
      }
      
      public static function format(param1:Date) : String
      {
         return param1.fullYear + "/" + (param1.month + 1) + "/" + param1.date + " " + param1.hours + ":" + param1.minutes + ":" + param1.seconds;
      }
      
      public static function formatTime(param1:Number) : String
      {
         param1 = param1 / 1000;
         var _loc4_:int = Math.floor(param1 / 60 / 60);
         var _loc2_:int = Math.floor(param1 / 60);
         var _loc3_:int = Math.floor(param1 % 60);
         return (_loc4_ > 0?_loc4_ + "時間":"") + (_loc2_ > 0?_loc2_ + "分":"") + _loc3_ + "秒";
      }
   }
}
