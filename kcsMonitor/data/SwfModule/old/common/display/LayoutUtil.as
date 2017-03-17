package common.display
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public class LayoutUtil
   {
       
      
      public function LayoutUtil()
      {
         super();
      }
      
      public static function middleCenter(param1:DisplayObject, param2:DisplayObjectContainer = null) : void
      {
         var _loc4_:Number = !!param2?param2.width:0;
         var _loc3_:Number = !!param2?param2.height:0;
         param1.x = _loc4_ / 2 - param1.width / 2;
         param1.y = _loc3_ / 2 - param1.height / 2;
      }
   }
}
