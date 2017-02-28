package a24.util
{
   import flash.geom.Rectangle;
   
   public final class GraphicsUtil24
   {
       
      
      public function GraphicsUtil24()
      {
         super();
      }
      
      public function drawRectHitArea(param1:Object, param2:Object = null, param3:Boolean = false) : void
      {
         if(!param2)
         {
            param2 = param1;
         }
         param1.graphics.clear();
         var _loc4_:Rectangle = param2.getRect(param2);
         param1.graphics.beginFill(65535,!!param3?0.5:0);
         param1.graphics.drawRect(_loc4_.x,_loc4_.y,_loc4_.width,_loc4_.height);
      }
      
      public function drawCircleHitArea(param1:Object, param2:Object = null, param3:Boolean = false) : void
      {
         if(!param2)
         {
            param2 = param1;
         }
         param1.graphics.clear();
         var _loc4_:Rectangle = param2.getRect(param2);
         param1.graphics.beginFill(65535,!!param3?0.5:0);
         param1.graphics.drawCircle(_loc4_.x + _loc4_.width / 2,_loc4_.y + _loc4_.height / 2,_loc4_.width / 2);
      }
   }
}
