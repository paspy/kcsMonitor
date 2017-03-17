package common.scenes
{
   import a24.tween.Tween24;
   import flash.display.Sprite;
   
   public class MapViewBase extends Sprite
   {
       
      
      public function MapViewBase()
      {
         super();
      }
      
      public function setMapLayerAlpha(param1:Number) : void
      {
      }
      
      public function getTweenSpecialMapClearEffect(param1:int, param2:int, param3:int) : Vector.<Tween24>
      {
         return Vector.<Tween24>([Tween24.wait(3),Tween24.wait(0)]);
      }
   }
}
