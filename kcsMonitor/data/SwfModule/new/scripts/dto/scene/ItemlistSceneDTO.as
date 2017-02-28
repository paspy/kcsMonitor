package dto.scene
{
   import scene.ISceneDTO;
   
   public class ItemlistSceneDTO extends SceneDTO implements ISceneDTO
   {
       
      
      public function ItemlistSceneDTO(param1:Object = null)
      {
         super(param1);
      }
      
      public function set state(param1:String) : void
      {
         _o["state"] = param1;
      }
      
      public function get state() : String
      {
         return _getString(_o,"state","STATE_ITEMLIST");
      }
      
      override public function createObject() : Object
      {
         return _o;
      }
   }
}
