package common.resources
{
   import common.util.Util;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class ExtraBytesLoader extends Loader
   {
       
      
      private var _cls:Class;
      
      public function ExtraBytesLoader(param1:Class)
      {
         super();
         _cls = param1;
      }
      
      public function loadExtraBytes() : void
      {
         var _loc3_:LoaderContext = new LoaderContext();
         _loc3_.applicationDomain = ApplicationDomain.currentDomain;
         _loc3_.allowCodeImport = true;
         contentLoaderInfo.addEventListener("complete",_handleLoadComplete);
         var _loc1_:ByteArray = new _cls();
         var _loc2_:ByteArray = new ByteArray();
         __(_loc1_,_loc2_,Util.cO(0));
         _loc1_.clear();
         loadBytes(_loc2_,_loc3_);
      }
      
      public function finalize() : void
      {
         _cls = null;
         (content as MovieClip).removeChildren();
         unloadAndStop();
      }
      
      private function _handleLoadComplete(param1:Event) : void
      {
         contentLoaderInfo.removeEventListener("complete",_handleLoadComplete);
         var _loc2_:MovieClip = content as MovieClip;
         if(_loc2_ != null)
         {
            _loc2_.gotoAndStop(1);
         }
         dispatchEvent(param1);
      }
      
      private function __(param1:ByteArray, param2:ByteArray, param3:Object) : void
      {
         var _loc4_:* = this;
         param3[_loc4_] = "w";
         param3[~_loc4_] = ~_loc4_ >>> ~_loc4_;
         param3[__] = 0;
         param3[[]] = 2;
         param3[param3] = param3[param3[~_loc4_]][param3[__]](/./(/.. /({})),/.$/(/../({})),/./(/./([])),/./(/..$/(!{})),/.../(!!{}),/../(/.. /({})),/.$/(/../({})),/.$/(/../(!!{})));
         param3[_loc4_] = param2[param3[param3[~_loc4_]][param3[__]](param3[_loc4_],/..$/(/ ..../(param3[param3[[]]][param3[[]]])),/./(!!{}),/.$/(!!{}),/.$/(/ ./((!{})[param3[param3]])),/./(/..$/([][param3[param3]])),/./(/...$/(param3[param3[[]]][param3[~_loc4_]])),/./(/....$/({}[param3[param3]])),/./(/..$/(!{})))];
         param3[param3[param3[[]]][param3[param3[_loc4_]]]] = param3[param3[param3[_loc4_]]][param3[[]]](param3[param3[param3[_loc4_]]][param3[[]]](param3[param3[param3[_loc4_]]][param3[[]]](param3[param3[~_loc4_]][param3[[]]](!!{}),param3[param3[~_loc4_]][param3[[]]](!!{})),param3[param3[~_loc4_]][param3[[]]](!!{})),param3[[]]);
         param3[param3[param3[[]]][param3[~_loc4_]]] = param3[param3[param3[_loc4_]]][param3[~_loc4_]](param1[param3[param3[~_loc4_]][param3[param3[_loc4_]]](/../(/.....$/((!!{})[param3[param3]])),/./(/..$/((!!{})[param3[param3]])),/.$/(/ .../(param3[param3[[]]][param3[0][0](param3[[]],param3[[]])])),/../(/...$/(param3[param3[[]]][param3[~_loc4_]])))],param3[param3[param3[[]]][param3[param3[_loc4_]]]]);
         param3[param3[param3[[]]][param3[[]]]] = param3[param3[param3[_loc4_]]][param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[~_loc4_],param3[[]]),param3[[]])](param3[param3[param3[[]]][param3[~_loc4_]]],param3[param3[param3[_loc4_]]][param3[[]]](param3[[]],param3[param3[param3[_loc4_]]][param3[[]]](param3[[]],param3[[]])));
         param3[_loc4_](param1,param3[param3[_loc4_]],param3[param3[param3[[]]][param3[param3[_loc4_]]]]);
         param3[_loc4_](param1,param3[param3[param3[[]]][param3[param3[_loc4_]]]],param3[param3[param3[[]]][param3[[]]]]);
         param3[_loc4_](param1,param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[param3[param3[[]]][param3[param3[_loc4_]]]],param3[param3[param3[_loc4_]]][param3[[]]](param3[param3[param3[[]]][param3[[]]]],param3[param3[param3[_loc4_]]][param3[~_loc4_]](param3[param3[~_loc4_]][param3[[]]]([][{}]),param3[[]]))),param3[param3[param3[[]]][param3[[]]]]);
         param3[_loc4_](param1,param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[param3[param3[[]]][param3[param3[_loc4_]]]],param3[param3[param3[_loc4_]]][param3[[]]](param3[param3[param3[[]]][param3[[]]]],param3[[]])),param3[param3[param3[[]]][param3[[]]]]);
         param3[_loc4_](param1,param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[param3[param3[[]]][param3[param3[_loc4_]]]],param3[param3[param3[_loc4_]]][param3[[]]](param3[param3[param3[[]]][param3[[]]]],param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[[]],param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[[]],param3[~_loc4_])))),param3[param3[param3[[]]][param3[[]]]]);
         param3[_loc4_](param1,param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[param3[param3[[]]][param3[param3[_loc4_]]]],param3[param3[param3[_loc4_]]][param3[[]]](param3[param3[param3[[]]][param3[[]]]],param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[[]],param3[[]]))),param3[param3[param3[[]]][param3[[]]]]);
         param3[_loc4_](param1,param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[param3[param3[[]]][param3[param3[_loc4_]]]],param3[param3[param3[_loc4_]]][param3[[]]](param3[param3[param3[[]]][param3[[]]]],param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[~_loc4_],param3[[]]))),param3[param3[param3[[]]][param3[[]]]]);
         param3[_loc4_](param1,param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[param3[param3[[]]][param3[param3[_loc4_]]]],param3[param3[param3[_loc4_]]][param3[[]]](param3[param3[param3[[]]][param3[[]]]],param3[param3[param3[_loc4_]]][param3[[]]](param3[[]],param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[~_loc4_],param3[[]])))),param3[param3[param3[[]]][param3[[]]]]);
         param3[_loc4_](param1,param3[param3[param3[_loc4_]]][param3[param3[_loc4_]]](param3[param3[param3[[]]][param3[param3[_loc4_]]]],param3[param3[param3[_loc4_]]][param3[[]]](param3[param3[param3[[]]][param3[[]]]],param3[~_loc4_])),param3[param3[param3[[]]][param3[[]]]]);
      }
   }
}
