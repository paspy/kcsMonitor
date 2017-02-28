package a24.util
{
   import flash.display.BitmapData;
   import flash.utils.getDefinitionByName;
   
   public final class ClassUtil24
   {
       
      
      public function ClassUtil24()
      {
         super();
      }
      
      public function getInstanceByName(param1:String) : *
      {
         var _loc2_:Class = getDefinitionByName(param1) as Class;
         return new _loc2_();
      }
      
      public function getLinkageBitmapDataByName(param1:String) : BitmapData
      {
         var _loc2_:Class = getDefinitionByName(param1) as Class;
         return new _loc2_(0,0);
      }
   }
}
