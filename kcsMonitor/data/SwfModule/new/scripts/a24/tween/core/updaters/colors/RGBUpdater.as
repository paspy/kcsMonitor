package a24.tween.core.updaters.colors
{
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   
   public final class RGBUpdater extends AbstractUpdater
   {
       
      
      private var _r:int;
      
      private var _g:int;
      
      private var _b:int;
      
      private var _startR:int;
      
      private var _startG:int;
      
      private var _startB:int;
      
      private var _deltaR:int;
      
      private var _deltaG:int;
      
      private var _deltaB:int;
      
      private var _compR:int;
      
      private var _compG:int;
      
      private var _compB:int;
      
      private var _complete:int;
      
      public function RGBUpdater()
      {
         super();
      }
      
      public static function getInt16(param1:int) : String
      {
         return "0x" + (String("000000" + param1.toString(16))).substr(-6,6);
      }
      
      public function setProp(param1:Number, param2:uint) : RGBUpdater
      {
         _complete = param2;
         _startR = param1 >> 16 & 255;
         _startG = param1 >> 8 & 255;
         _startB = param1 & 255;
         if(param1 < 0)
         {
            _startR = _startR * -1;
            _startG = _startG * -1;
            _startB = _startB * -1;
         }
         _compR = param2 >> 16 & 255;
         _compG = param2 >> 8 & 255;
         _compB = param2 & 255;
         if(param2 < 0)
         {
            _compR = _compR * -1;
            _compG = _compG * -1;
            _compB = _compB * -1;
         }
         _deltaR = _compR - _startR;
         _deltaG = _compG - _startG;
         _deltaB = _compB - _startB;
         return this;
      }
      
      public function getColor() : uint
      {
         return _r << 16 | _g << 8 | _b;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         _r = _startR + _deltaR * param1;
         _g = _startG + _deltaG * param1;
         _b = _startB + _deltaB * param1;
         return this;
      }
      
      override public function toString() : String
      {
         return "0x" + _complete.toString(16);
      }
      
      public function get r() : int
      {
         return _r;
      }
      
      public function get g() : int
      {
         return _g;
      }
      
      public function get b() : int
      {
         return _b;
      }
   }
}
