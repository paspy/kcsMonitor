package dto.scene
{
   import scene.ISceneDTO;
   
   public class SallySceneDTO extends SceneDTO implements ISceneDTO
   {
       
      
      public function SallySceneDTO(param1:Object = null)
      {
         super(param1);
         if(DataFacade.getUserDeckData().deckCount > 1)
         {
            isOpenEnsei = true;
         }
      }
      
      public function set isOpenEnsei(param1:Boolean) : void
      {
         _o["isOpenEnsei"] = param1;
      }
      
      public function get isOpenEnsei() : Boolean
      {
         return !!_o.hasOwnProperty("isOpenEnsei")?_o["isOpenEnsei"]:false;
      }
      
      override public function createObject() : Object
      {
         return _o;
      }
   }
}
