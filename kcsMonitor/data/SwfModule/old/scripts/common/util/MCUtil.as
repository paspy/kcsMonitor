package common.util
{
   import a24.tween.Tween24;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   
   public class MCUtil
   {
       
      
      public function MCUtil()
      {
         super();
      }
      
      public static function frameTween(param1:MovieClip, param2:int, param3:int) : Tween24
      {
         return Tween24.tween(param1,(param3 - param2) / 30).frame(param3);
      }
      
      public static function createLabelMap(param1:MovieClip) : Dictionary
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:Dictionary = new Dictionary();
         var _loc2_:Array = param1.currentLabels;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc5_] as FrameLabel;
            _loc3_[_loc4_.name] = _loc4_.frame;
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function getTime(param1:int, param2:int) : Number
      {
         var _loc3_:int = param2 - param1 + 1;
         return 1 / 30 * _loc3_;
      }
      
      public static function getTimeToLabel(param1:int, param2:String, param3:Dictionary) : Number
      {
         var _loc4_:int = 0;
         if(param3.hasOwnProperty(param2))
         {
            _loc4_ = param3[param2];
            return getTime(param1,_loc4_);
         }
         return NaN;
      }
   }
}
