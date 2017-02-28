package common.util
{
   public class MathUtil
   {
       
      
      public function MathUtil()
      {
         super();
      }
      
      public static function getRandomInt(param1:int, param2:int) : int
      {
         return Math.floor(Math.random() * (param2 - param1 + 1)) + 1;
      }
      
      public static function digit2(param1:int) : String
      {
         param1 = Math.min(param1,99);
         return param1 < 10?"0" + param1.toString():param1.toString();
      }
      
      public static function digit3(param1:uint) : String
      {
         param1 = Math.min(param1,999);
         return param1 > 99?param1.toString():"0" + digit2(param1);
      }
   }
}
