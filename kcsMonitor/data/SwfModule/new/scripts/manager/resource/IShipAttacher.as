package manager.resource
{
   import flash.display.DisplayObjectContainer;
   
   public interface IShipAttacher
   {
       
      
      function stackCardS(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void;
      
      function stackCardSS(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void;
      
      function stackCharaLevel(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void;
      
      function stackCharacterFull(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void;
      
      function stackCharacterUp(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void;
      
      function stackFull(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void;
      
      function stackSupplyCharacter(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void;
      
      function stackStatusTopCharacter(param1:int, param2:DisplayObjectContainer) : void;
      
      function load() : void;
      
      function cancel() : void;
   }
}
