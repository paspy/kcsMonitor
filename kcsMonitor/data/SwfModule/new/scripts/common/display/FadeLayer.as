package common.display
{
   import a24.tween.Tween24;
   import flash.display.Shape;
   
   public class FadeLayer extends Shape
   {
       
      
      public function FadeLayer(param1:uint = 0)
      {
         super();
         graphics.beginFill(param1);
         graphics.drawRect(0,0,800,480);
         graphics.endFill();
         alpha = 0;
      }
      
      public function getTween(param1:Number, param2:Number) : Tween24
      {
         return Tween24.tween(this,param2).alpha(param1);
      }
   }
}
