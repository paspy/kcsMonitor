package manager.resource
{
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   
   public interface IFurnitureAttacher
   {
       
      
      function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void;
      
      function dispatchEvent(param1:Event) : Boolean;
      
      function hasEventListener(param1:String) : Boolean;
      
      function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void;
      
      function willTrigger(param1:String) : Boolean;
      
      function stack(param1:int, param2:int, param3:DisplayObjectContainer) : void;
      
      function stackThumbnail(param1:int, param2:int, param3:DisplayObjectContainer) : void;
      
      function stackCard(param1:int, param2:int, param3:DisplayObjectContainer) : void;
      
      function stackFloor(param1:int, param2:DisplayObjectContainer, param3:int = 0) : void;
      
      function stackWall(param1:int, param2:DisplayObjectContainer, param3:int = 0) : void;
      
      function stackWindow(param1:int, param2:DisplayObjectContainer, param3:int = 0) : void;
      
      function stackObject(param1:int, param2:DisplayObjectContainer, param3:int = 0) : void;
      
      function stackChest(param1:int, param2:DisplayObjectContainer, param3:int = 0) : void;
      
      function stackDesk(param1:int, param2:DisplayObjectContainer, param3:int = 0) : void;
      
      function load() : void;
      
      function cancel() : void;
   }
}
