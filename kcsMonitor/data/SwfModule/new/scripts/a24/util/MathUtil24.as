package a24.util
{
   public final class MathUtil24
   {
       
      
      public function MathUtil24()
      {
         super();
      }
      
      public function randomInRange(param1:Number, param2:Number, param3:Number = NaN, param4:Number = NaN, param5:Boolean = false) : Number
      {
         var _loc6_:Number = NaN;
         var _loc7_:* = !(isNaN(param3) || isNaN(param4));
         do
         {
            _loc6_ = Math.random() * (param2 - param1) + param1;
         }
         while(_loc7_ && (param3 < _loc6_ && _loc6_ < param4));
         
         return !!param5?Math.round(_loc6_):Number(_loc6_);
      }
   }
}
