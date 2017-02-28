package core
{
   import flash.display.Sprite;
   
   public class ErrorScreen extends Sprite
   {
       
      
      private var _imgCls:Class;
      
      public function ErrorScreen()
      {
         _imgCls = error_png$c68a5cf3c7d4e1744f0d6622e629e7ef619659770;
         super();
         addChild(new _imgCls());
      }
   }
}
