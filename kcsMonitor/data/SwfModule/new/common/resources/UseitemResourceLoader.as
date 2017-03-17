package common.resources
{
   import common.util.MathUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   
   public class UseitemResourceLoader extends ImageResourceLoaderBase
   {
       
      
      public function UseitemResourceLoader(param1:int, param2:String, param3:DisplayObjectContainer, param4:Class)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function _createURLString() : String
      {
         var _loc1_:String = SettingFacade.URLROOT_UITEM;
         _loc1_ = _loc1_ + (_type + "/");
         _loc1_ = _loc1_ + (MathUtil.digit3(_mstId) + ".png");
         return _loc1_;
      }
      
      override protected function _preShow(param1:Loader) : void
      {
         (param1.content as Bitmap).smoothing = true;
      }
   }
}
