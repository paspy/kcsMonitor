package common.resources
{
   import common.util.MathUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   
   public class SlotitemResourceLoader extends ImageResourceLoaderBase
   {
       
      
      public function SlotitemResourceLoader(param1:int, param2:String, param3:DisplayObjectContainer, param4:Class)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function _createURLString() : String
      {
         var _loc1_:String = SettingFacade.URLROOT_SLOTITEM;
         _loc1_ = _loc1_ + (_type + "/");
         _loc1_ = _loc1_ + (MathUtil.digit3(_mstId) + ".png");
         var _loc2_:String = DataFacade.getMasterSlotItemData().getVersion(_mstId);
         if(_loc2_ != null && _loc2_ != "" && _loc2_ != "1")
         {
            _loc1_ = _loc1_ + ("?version=" + _loc2_);
         }
         return _loc1_;
      }
      
      override protected function _preShow(param1:Loader) : void
      {
         (param1.content as Bitmap).smoothing = true;
      }
   }
}
