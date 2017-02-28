package common.resources
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import vo.StartData;
   
   public class FurnitureResourceLoader extends ImageResourceLoaderBase
   {
       
      
      private var _resource_type:int = 0;
      
      private var _isSWF:Boolean;
      
      public function FurnitureResourceLoader(param1:int, param2:String, param3:DisplayObjectContainer, param4:int, param5:Class)
      {
         var _loc6_:StartData = DataFacade.getStartData();
         _isSWF = _loc6_.getFurnitureAnimationType(param1) > 0;
         _resource_type = param4;
         super(param1,param2,param3,param5);
      }
      
      override protected function _createURLString() : String
      {
         var _loc5_:int = DataFacade.getMasterFurnitureData().getNo(_mstId);
         var _loc4_:int = DataFacade.getMasterFurnitureData().getType(_mstId);
         var _loc3_:StartData = DataFacade.getStartData();
         var _loc2_:String = _loc3_.getFurnitureFileName(_loc4_,_loc5_);
         var _loc1_:String = _loc3_.getFurnitureVersion(_loc4_,_loc5_);
         var _loc6_:String = SettingFacade.URLROOT_FURNITURE;
         _loc6_ = _loc6_ + (_type + "/");
         if(_resource_type == 1)
         {
            _isSWF = false;
            _loc6_ = _loc6_ + (_loc2_ + "t.png");
         }
         else if(_resource_type == 2)
         {
            _isSWF = false;
            _loc6_ = _loc6_ + ("card/" + _loc2_ + ".png");
         }
         else
         {
            _loc6_ = _loc6_ + (_loc2_ + (!!_isSWF?".swf":".png"));
         }
         if(_loc1_ != "1")
         {
            _loc6_ = _loc6_ + ("?version=" + _loc1_);
         }
         return _loc6_;
      }
      
      override protected function _preShow(param1:Loader) : void
      {
         if(_isSWF)
         {
            (param1.content as MovieClip).gotoAndStop(2);
            (param1.content as MovieClip).visible = true;
         }
      }
   }
}
