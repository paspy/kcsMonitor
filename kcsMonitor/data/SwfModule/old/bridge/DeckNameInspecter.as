package bridge
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class DeckNameInspecter extends EventDispatcher
   {
       
      
      private var _text:String;
      
      private var _text_id:String;
      
      public function DeckNameInspecter(param1:String)
      {
         super();
         _text = param1;
         _text_id = "";
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get textId() : String
      {
         return _text_id;
      }
      
      public function inspect() : void
      {
         if(_text == null || _text == "" || AppFacade.root.jsBridgeManager.deckNameEditCallBack != null)
         {
            _complete();
         }
         else
         {
            AppFacade.root.jsBridgeManager.deckNameEditCallBack = _callBack;
            AppFacade.root.jsBridgeManager.deckNameEdit(_text);
         }
      }
      
      private function _callBack(param1:String, param2:String) : void
      {
         AppFacade.root.jsBridgeManager.deckNameEditCallBack = null;
         _text_id = param2;
         if(_text_id == null)
         {
            _text_id = "";
         }
         _complete();
      }
      
      private function _complete() : void
      {
         dispatchEvent(new Event("complete"));
      }
   }
}
