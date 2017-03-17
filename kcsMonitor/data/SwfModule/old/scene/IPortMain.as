package scene
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public interface IPortMain
   {
       
      
      function get cutinLayer() : Sprite;
      
      function initialize() : void;
      
      function finalize() : void;
      
      function backToPort() : void;
      
      function backToPortFromBattle() : void;
      
      function gotoShop() : void;
      
      function updateUpperBar() : void;
      
      function changeFurnitureView(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void;
      
      function openJukeBox() : void;
      
      function sendMessage(param1:String) : void;
      
      function dispatchEvent(param1:Event) : Boolean;
   }
}
