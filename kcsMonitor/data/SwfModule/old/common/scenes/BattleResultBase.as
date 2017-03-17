package common.scenes
{
   import a24.tween.Tween24;
   import flash.display.Sprite;
   
   public class BattleResultBase extends Sprite
   {
       
      
      public var battleBase:BattleBase;
      
      public function BattleResultBase()
      {
         super();
      }
      
      public function initialTween(param1:Object = null) : Tween24
      {
         return null;
      }
      
      public function finalize() : void
      {
      }
      
      public function getEscapeShipIndexes() : Array
      {
         return null;
      }
      
      public function getTowShipIndexes() : Array
      {
         return null;
      }
   }
}
