package a24.util
{
   import flash.display.MovieClip;
   
   public final class TimelineUtil24
   {
       
      
      public function TimelineUtil24()
      {
         super();
      }
      
      public function play(... rest) : void
      {
         rest = Util24.array.compressAndClean(rest);
         var _loc4_:int = 0;
         var _loc3_:* = rest;
         for each(var _loc2_ in rest)
         {
            _loc2_.play();
         }
      }
      
      public function stop(... rest) : void
      {
         rest = Util24.array.compressAndClean(rest);
         var _loc4_:int = 0;
         var _loc3_:* = rest;
         for each(var _loc2_ in rest)
         {
            _loc2_.stop();
         }
      }
      
      public function gotoAndPlay(param1:*, ... rest) : void
      {
         rest = Util24.array.compressAndClean(rest);
         var _loc5_:int = 0;
         var _loc4_:* = rest;
         for each(var _loc3_ in rest)
         {
            _loc3_.gotoAndPlay(param1);
         }
      }
      
      public function gotoAndStop(param1:*, ... rest) : void
      {
         rest = Util24.array.compressAndClean(rest);
         var _loc5_:int = 0;
         var _loc4_:* = rest;
         for each(var _loc3_ in rest)
         {
            _loc3_.gotoAndStop(param1);
         }
      }
      
      public function gotoPrevFrame(... rest) : void
      {
         rest = Util24.array.compressAndClean(rest);
         var _loc4_:int = 0;
         var _loc3_:* = rest;
         for each(var _loc2_ in rest)
         {
            _loc2_.gotoAndStop(_loc2_.currentFrame - 1);
         }
      }
      
      public function gotoNextFrame(... rest) : void
      {
         rest = Util24.array.compressAndClean(rest);
         var _loc4_:int = 0;
         var _loc3_:* = rest;
         for each(var _loc2_ in rest)
         {
            _loc2_.gotoAndStop(_loc2_.currentFrame + 1);
         }
      }
      
      public function gotoLastFrame(... rest) : void
      {
         rest = Util24.array.compressAndClean(rest);
         var _loc4_:int = 0;
         var _loc3_:* = rest;
         for each(var _loc2_ in rest)
         {
            _loc2_.gotoAndStop(_loc2_.totalFrames);
         }
      }
      
      public function gotoRandomAndPlay(... rest) : void
      {
         rest = Util24.array.compressAndClean(rest);
         var _loc4_:int = 0;
         var _loc3_:* = rest;
         for each(var _loc2_ in rest)
         {
            _loc2_.gotoAndPlay(int(_loc2_.totalFrames * Math.random() + 1));
         }
      }
      
      public function gotoRandomAndStop(... rest) : void
      {
         rest = Util24.array.compressAndClean(rest);
         var _loc4_:int = 0;
         var _loc3_:* = rest;
         for each(var _loc2_ in rest)
         {
            _loc2_.gotoAndStop(int(_loc2_.totalFrames * Math.random() + 1));
         }
      }
   }
}
