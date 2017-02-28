package a24.tween.core.plugins
{
   import a24.tween.Tween24;
   import a24.util.Util24;
   
   public class PulginTween24
   {
       
      
      protected var _tween:Tween24;
      
      private var _target:Object;
      
      private var _time:Number;
      
      private var _easing:Function;
      
      public function PulginTween24()
      {
         super();
         _tween = new Tween24();
      }
      
      protected function setTween(param1:Object, param2:Number, param3:Function = null) : PulginTween24
      {
         _tween = Tween24.tween(param1,param2,param3);
         return this;
      }
      
      protected function setProp(param1:Object) : PulginTween24
      {
         _tween = Tween24.prop(param1);
         return this;
      }
      
      protected function setFunc(param1:Function, ... rest) : PulginTween24
      {
         rest.unshift(param1);
         _tween = Tween24.func.apply(_tween,rest);
         return this;
      }
      
      protected function add(param1:String, ... rest) : PulginTween24
      {
         rest = Util24.array.compress(rest);
         _tween[param1].apply(_tween,rest);
         return this;
      }
      
      protected function addParam(param1:String, param2:*) : void
      {
         _tween.addParam(param1,param2);
      }
      
      public function getTween24() : Tween24
      {
         return _tween;
      }
      
      public function play() : void
      {
         _tween.play();
      }
      
      public function pause() : void
      {
         _tween.pause();
      }
      
      public function skip() : void
      {
         _tween.skip();
      }
      
      public function stop() : void
      {
         _tween.stop();
      }
      
      public function setTimeScale(param1:Number) : void
      {
         _tween.setTimeScale(param1);
      }
   }
}
