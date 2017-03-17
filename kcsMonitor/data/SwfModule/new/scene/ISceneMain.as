package scene
{
   import a24.tween.Tween24;
   
   public interface ISceneMain
   {
       
      
      function initialTween(param1:Object = null) : Tween24;
      
      function initialize(param1:Object = null) : void;
      
      function finalize() : void;
   }
}
