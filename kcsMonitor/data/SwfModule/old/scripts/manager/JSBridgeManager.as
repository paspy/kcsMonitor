package manager
{
   import common.debug.Debug;
   import flash.external.ExternalInterface;
   import flash.system.Security;
   
   public class JSBridgeManager
   {
       
      
      private const _deckNameEdit_methodName:String = "kcsInspection_CreateInspectionDeckName";
      
      private const _deckNameEdit_callbackName:String = "asCreateInspectionDeckNameResult";
      
      private const _commentEdit_methodName:String = "kcsInspection_CreateInspectionComment";
      
      private const _commentEdit_callbackName:String = "asCreateInspectionCommentResult";
      
      private const _purchase_methodName:String = "kcsPayment_StartPayment";
      
      private const _purchase_callbackName:String = "asFunc";
      
      private var _nowEditedText:String = "";
      
      public var deckNameEditCallBack:Function = null;
      
      public var commentEditCallBack:Function = null;
      
      public var purchaseCallBack:Function = null;
      
      public function JSBridgeManager()
      {
         super();
         Security.allowDomain("*");
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("asCreateInspectionDeckNameResult",_deckNameEdit_callback);
            ExternalInterface.addCallback("asCreateInspectionCommentResult",_commentEdit_callback);
            ExternalInterface.addCallback("asFunc",_purchase_callback);
         }
         else
         {
            Debug.log("ExternalInterface is not Available.");
         }
      }
      
      public function deckNameEdit(param1:String) : void
      {
         if(_nowEditedText != "")
         {
            return;
         }
         if(ExternalInterface.available)
         {
            try
            {
               _nowEditedText = param1;
               ExternalInterface.call("kcsInspection_CreateInspectionDeckName",_nowEditedText);
            }
            catch(e:Error)
            {
               Debug.log("[Error] call JS from AS.(kcsInspection_CreateInspectionDeckName)");
               _deckNameEdit_callback("");
            }
         }
         else
         {
            Debug.log("ExternalInterface is not Available.");
            _deckNameEdit_callback("");
         }
      }
      
      private function _deckNameEdit_callback(param1:String) : void
      {
         if(deckNameEditCallBack != null)
         {
            deckNameEditCallBack(_nowEditedText,param1);
         }
         _nowEditedText = "";
      }
      
      public function commentEdit(param1:String) : void
      {
         if(_nowEditedText != "")
         {
            return;
         }
         if(ExternalInterface.available)
         {
            try
            {
               _nowEditedText = param1;
               ExternalInterface.call("kcsInspection_CreateInspectionComment",_nowEditedText);
            }
            catch(e:Error)
            {
               Debug.log("[Error] call JS from AS.(kcsInspection_CreateInspectionComment)");
            }
         }
         else
         {
            Debug.log("ExternalInterface is not Available.");
         }
      }
      
      private function _commentEdit_callback(param1:String) : void
      {
         if(commentEditCallBack != null)
         {
            commentEditCallBack(_nowEditedText,param1);
         }
         _nowEditedText = "";
      }
      
      public function purchase(param1:int, param2:int, param3:int, param4:String, param5:String, param6:String) : void
      {
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("kcsPayment_StartPayment",param1,param2,param3,param4,param5,param6);
            }
            catch(e:Error)
            {
               Debug.log("[Error] call JS from AS.(kcsPayment_StartPayment)");
            }
         }
         else
         {
            Debug.log("ExternalInterface is not Available.");
         }
      }
      
      private function _purchase_callback(param1:int) : void
      {
         if(purchaseCallBack != null)
         {
            purchaseCallBack(param1);
         }
      }
   }
}
