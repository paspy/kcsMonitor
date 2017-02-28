package core.consts
{
   public class MapConst
   {
      
      public static const AIRUNIT_INFO_TYPE:Object = {
         "64":2,
         "371":3,
         "372":3,
         "373":3
      };
      
      public static const AIRUNIT_INFO_OFFSET:Object = {
         "64":[-17,46],
         "65":[-9,43],
         "371":[-8,88],
         "372":[-8,88],
         "373":[0,230]
      };
      
      public static const GAUGEPOS_OFFSET:Object = {
         "15":[-20,-15],
         "16":[-35,84],
         "25":[-23,0],
         "35":[-15,-2],
         "45":[-11,-9],
         "55":[-22,-6],
         "65":[-15,-1],
         "372":[-5,5],
         "373":[-5,-5]
      };
      
      public static const LEFTGAUGE_MAP:Array = [371];
      
      public static const SP_GAUGE_LEFT:Array = [373];
      
      public static const SP_GAUGE_POS:Object = {"373":[-10,35]};
       
      
      public function MapConst()
      {
         super();
      }
   }
}
