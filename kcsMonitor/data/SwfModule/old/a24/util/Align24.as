package a24.util
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public final class Align24
   {
      
      public static const TOP_LEFT:uint = 1;
      
      public static const TOP_CENTER:uint = 2;
      
      public static const TOP_RIGHT:uint = 3;
      
      public static const MIDDLE_LEFT:uint = 4;
      
      public static const MIDDLE_CENTER:uint = 5;
      
      public static const MIDDLE_RIGHT:uint = 6;
      
      public static const BOTTOM_LEFT:uint = 7;
      
      public static const BOTTOM_CENTER:uint = 8;
      
      public static const BOTTOM_RIGHT:uint = 9;
      
      public static const DEFAULT:uint = 0;
      
      public static const LEFT:uint = 11;
      
      public static const CENTER:uint = 12;
      
      public static const RIGHT:uint = 13;
      
      public static const TOP:uint = 14;
      
      public static const MIDDLE:uint = 15;
      
      public static const BOTTOM:uint = 16;
      
      public static const SELECTED:uint = 100;
       
      
      public var topLeft:uint = 1;
      
      public var topCenter:uint = 2;
      
      public var topRight:uint = 3;
      
      public var middleLeft:uint = 4;
      
      public var middleCenter:uint = 5;
      
      public var middleRight:uint = 6;
      
      public var bottomLeft:uint = 7;
      
      public var bottomCenter:uint = 8;
      
      public var bottomRight:uint = 9;
      
      public var deautlt:uint = 0;
      
      public var left:uint = 11;
      
      public var center:uint = 12;
      
      public var right:uint = 13;
      
      public var top:uint = 14;
      
      public var middle:uint = 15;
      
      public var bottom:uint = 16;
      
      public var selected:uint = 100;
      
      public function Align24()
      {
         super();
      }
      
      public static function getAlignPoint(param1:DisplayObject, param2:uint) : Point
      {
         var _loc3_:Point = new Point();
         var _loc4_:Rectangle = param1.getRect(param1);
         switch(int(param2) - 1)
         {
            case 0:
               _loc3_.x = _loc4_.left;
               break;
            case 1:
               _loc3_.x = _loc4_.left + _loc4_.width / 2;
               break;
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
               _loc3_.x = _loc4_.right;
            default:
            case 10:
            case 11:
            case 12:
               _loc3_.x = _loc4_.right;
         }
         switch(int(param2) - 1)
         {
            case 0:
            case 1:
            case 2:
               _loc3_.y = _loc4_.top;
               break;
            case 3:
            case 4:
            case 5:
               _loc3_.y = _loc4_.top + _loc4_.height / 2;
               break;
            case 6:
            case 7:
            case 8:
               _loc3_.y = _loc4_.bottom;
            default:
               _loc3_.y = _loc4_.bottom;
            default:
               _loc3_.y = _loc4_.bottom;
            default:
               _loc3_.y = _loc4_.bottom;
            default:
            case 13:
            case 14:
            case 15:
               _loc3_.y = _loc4_.bottom;
         }
         return _loc3_;
      }
   }
}
