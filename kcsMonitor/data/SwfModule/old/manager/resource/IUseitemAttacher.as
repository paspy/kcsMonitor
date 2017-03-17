package manager.resource
{
   import flash.display.DisplayObjectContainer;
   
   public interface IUseitemAttacher
   {
       
      
      function stackCard(param1:int, param2:DisplayObjectContainer) : void;
      
      function stackIcon(param1:int, param2:DisplayObjectContainer) : void;
      
      function stackPayItemIcon(param1:int, param2:DisplayObjectContainer) : void;
      
      function load() : void;
      
      function cancel() : void;
   }
}
