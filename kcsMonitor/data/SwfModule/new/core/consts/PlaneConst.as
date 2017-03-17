package core.consts
{
   public class PlaneConst
   {
      
      public static const PLANE:Array = [5,7,15,16,33,36,40];
      
      public static const PLANE_SAKUTEKI:Array = [9,10,11,41,59];
      
      public static const PLANE_AIRWAR:Array = [6,7,8,11,25,26,45,56,57,58];
      
      public static const PLANE_ATTACKABLE:Array = [6,45,56];
      
      public static const PLANE_AIRWAR_JET:Array = [56,57,58];
      
      public static const OFFSET:Object = {
         "19":{
            "r":30,
            "x":0,
            "y":13
         },
         "20":{
            "sx":-1,
            "r":33,
            "x":1,
            "y":14
         },
         "21":{"r":15},
         "23":{
            "r":31,
            "x":0,
            "y":7
         },
         "24":{"sx":-1},
         "55":{"sx":-1},
         "57":{"sx":-1},
         "60":{"r":340},
         "64":{"r":90},
         "69":{"sx":-1},
         "79":{"r":30},
         "80":{"r":316},
         "81":{"r":317},
         "83":{"sx":-1},
         "96":{"sx":-1},
         "98":{"sx":-1},
         "99":{"sx":-1},
         "102":{
            "x":0,
            "y":9,
            "r":24,
            "sx":-1
         },
         "109":{"sx":-1},
         "110":{
            "sx":-1,
            "r":21
         },
         "111":{
            "sx":-1,
            "r":345
         },
         "112":{"sx":-1},
         "113":{
            "sx":-1,
            "r":350
         },
         "115":{"r":9},
         "138":{"r":18},
         "143":{
            "sx":-1,
            "r":30
         },
         "144":{"r":345},
         "151":{"r":20},
         "152":{"sx":-1},
         "153":{"sx":-1},
         "154":{"sx":-1},
         "155":{"sx":-1},
         "156":{"sx":-1},
         "157":{"sx":-1},
         "158":{
            "sx":-1,
            "r":30
         },
         "159":{
            "sx":-1,
            "r":345
         },
         "163":{"sx":-1},
         "164":{"sx":-1},
         "165":{"sx":-1},
         "168":{
            "sx":-1,
            "r":12
         },
         "169":{
            "sx":-1,
            "r":15
         },
         "170":{
            "sx":-1,
            "r":15
         },
         "171":{"sx":-1},
         "175":{"r":340},
         "176":{
            "sx":-1,
            "r":34
         },
         "177":{
            "sx":-1,
            "r":34
         },
         "178":{
            "sx":-1,
            "r":12
         },
         "181":{"sx":-1},
         "182":{"sx":-1},
         "185":{"sx":-1},
         "186":{"sx":-1},
         "187":{"sx":-1},
         "194":{"r":18},
         "195":{"r":15},
         "196":{"r":6},
         "197":{"sx":-1},
         "198":{"sx":-1},
         "199":{"r":19},
         "200":{"r":26},
         "205":{
            "sx":-1,
            "y":5
         },
         "207":{"r":26},
         "215":{"sx":-1},
         "216":{"sx":-1}
      };
       
      
      public function PlaneConst()
      {
         super();
      }
      
      public static function get PLANE_AIRWAR_WITH_FLYINGBOAT() : Array
      {
         return PLANE_AIRWAR.concat(41);
      }
      
      public static function get PLANE_AIRUNIT() : Array
      {
         return PLANE_AIRWAR.concat(9,10,41,47,48,59);
      }
   }
}
