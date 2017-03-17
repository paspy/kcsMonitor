package dto.scene
{
   import scene.ISceneDTO;
   import vo.BaseData;
   
   public class SceneDTO extends BaseData implements ISceneDTO
   {
       
      
      protected var _o:Object;
      
      public function SceneDTO(param1:Object = null)
      {
         super();
         _o = param1 != null?param1:{};
      }
      
      public function createObject() : Object
      {
         return _o;
      }
   }
}
