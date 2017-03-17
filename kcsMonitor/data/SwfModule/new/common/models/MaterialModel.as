package common.models
{
   public class MaterialModel
   {
       
      
      public var fuel:int = 0;
      
      public var ammo:int = 0;
      
      public var steel:int = 0;
      
      public var baux:int = 0;
      
      public function MaterialModel()
      {
         super();
      }
      
      public function setFromArray4(param1:Array) : void
      {
         if(param1 == null || param1.length < 4)
         {
            baux = 0;
            steel = 0;
            ammo = 0;
            fuel = 0;
         }
         else
         {
            fuel = param1[0];
            ammo = param1[1];
            steel = param1[2];
            baux = param1[3];
         }
      }
      
      public function addFromMaterialModel(param1:MaterialModel) : void
      {
         if(param1 == null)
         {
            return;
         }
         fuel = fuel + param1.fuel;
         ammo = ammo + param1.ammo;
         steel = steel + param1.steel;
         baux = baux + param1.baux;
      }
   }
}
