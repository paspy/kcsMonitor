package a24.tween.plugins.proxy
{
   import a24.tween.plugins.MatrixPlugin;
   import flash.display.DisplayObject;
   
   public class MatrixPluginProxy
   {
       
      
      public function MatrixPluginProxy()
      {
         super();
      }
      
      public function tween(param1:DisplayObject, param2:Number, param3:Function = null) : MatrixPlugin
      {
         return MatrixPlugin.tween(param1,param2,param3);
      }
      
      public function prop(param1:DisplayObject) : MatrixPlugin
      {
         return MatrixPlugin.prop(param1);
      }
   }
}
