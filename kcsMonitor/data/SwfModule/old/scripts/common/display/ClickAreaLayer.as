package common.display
{
   import flash.display.Sprite;
   
   public class ClickAreaLayer extends Sprite
   {
       
      
      public function ClickAreaLayer(param1:Number = 0, param2:uint = 0)
      {
         super();
         graphics.beginFill(param2,param1);
         graphics.drawRect(0,0,800,480);
         graphics.endFill();
      }
   }
}
