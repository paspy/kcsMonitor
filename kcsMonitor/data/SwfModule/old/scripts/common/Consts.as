package common
{
   public class Consts
   {
      
      public static const TIMEOUT_SEC:int = 5;
      
      public static const FPS:int = 30;
      
      public static const WIDTH:Number = 800;
      
      public static const HEIGHT:Number = 480;
      
      public static const COLOR_WHITE:int = 16774898;
      
      public static const COLOR_BROWN:int = 4999235;
      
      public static const COLOR_GREEN:int = 1949120;
      
      public static const COLOR_PINK:int = 16766947;
      
      public static const COLOR_UPPERLAYER:int = 0;
      
      public static const COLOR_UPPERLAYER_ALPHA:Number = 0.2;
      
      public static const RANK_NAME:Array = ["","元帥","大将","中将","少将","大佐","中佐","新米中佐","少佐","中堅少佐","新米少佐"];
      
      public static const MARRIAGE_LV:int = 99;
      
      public static const HP_LEVEL_NODAMAGE:int = 100;
      
      public static const HP_LEVEL_SHOHA:int = 75;
      
      public static const HP_LEVEL_CHUHA:int = 50;
      
      public static const HP_LEVEL_TAIHA:int = 25;
      
      public static const HP_LEVEL_GEKICHIN:int = 0;
      
      public static const SCENE_MAIN:int = 0;
      
      public static const SCENE_BATTLE:int = 2;
      
      public static const SCENE_YASEN:int = 3;
      
      public static const SCENE_BATTLE_RESULT:int = 4;
      
      public static const SCENE_SUPPLY:int = 11;
      
      public static const SCENE_REMODEL:int = 12;
      
      public static const SCENE_ORGANIZE:int = 13;
      
      public static const SCENE_REPAIR:int = 14;
      
      public static const SCENE_ARSENAL:int = 15;
      
      public static const SCENE_SALLY:int = 16;
      
      public static const SCENE_RECORD:int = 21;
      
      public static const SCENE_DUTY:int = 24;
      
      public static const SCENE_ALBUM:int = 25;
      
      public static const SCENE_ITEMLIST:int = 26;
      
      public static const SCENE_INTERIOR:int = 27;
      
      public static const SCENE_SHOP:int = 28;
      
      public static const SCENE_REVAMP:int = 30;
      
      public static const SCENE_OPTION:int = 99;
      
      public static const SORT_KEY_LEVEL:int = 0;
      
      public static const SORT_KEY_STYPE:int = 1;
      
      public static const SORT_KEY_OLDER:int = 2;
      
      public static const SORT_KEY_DAMAGE:int = 3;
      
      public static const SLOTSORT_KEY_DEFAULT:int = 0;
      
      public static const SLOTSORT_KEY_LEVEL_D:int = 1;
      
      public static const SLOTSORT_KEY_LEVEL_U:int = 2;
      
      public static const SLOTFILTER_KEY_DEFAULT:int = 0;
      
      public static const SLOTFILTER_KEY_KANSEN:int = 1;
      
      public static const SLOTFILTER_KEY_KANBAKU_KANKOU:int = 2;
      
      public static const SLOTFILTER_KEY_KANTEI_SUIJO:int = 3;
      
      public static const SLOTFILTER_KEY_SYUHO:int = 4;
      
      public static const SLOTFILTER_KEY_FUKUHO_TAIKU:int = 5;
      
      public static const SLOTFILTER_KEY_GYORAI:int = 6;
      
      public static const SLOTFILTER_KEY_BAKURAI:int = 7;
      
      public static const SLOTFILTER_KEY_OTHER:int = 8;
      
      public static const SLOT_FILTERING_CATEGORIES:Object = {
         1:[6,56],
         2:[7,8,57,58],
         3:[9,10,11,25,26,41,45,59],
         4:[1,2,3,38],
         5:[4,21],
         6:[5,22,32],
         7:[14,15,40]
      };
      
      public static const AKASHI_ID:int = 182;
      
      public static const AKASHI_KAI_ID:int = 187;
      
      public static const STYPE_01_KAIBOU:int = 1;
      
      public static const STYPE_02_KUCHIKU:int = 2;
      
      public static const STYPE_03_KEIJUN:int = 3;
      
      public static const STYPE_04_JUURAI:int = 4;
      
      public static const STYPE_05_JUUJUN:int = 5;
      
      public static const STYPE_06_KOUJUN:int = 6;
      
      public static const STYPE_07_KEIKUUBO:int = 7;
      
      public static const STYPE_08_JUNYOUSENKAN:int = 8;
      
      public static const STYPE_09_SENKAN:int = 9;
      
      public static const STYPE_10_KOUKUUSENKAN:int = 10;
      
      public static const STYPE_11_SEIKIKUUBO:int = 11;
      
      public static const STYPE_12_CHOUDOKYUU:int = 12;
      
      public static const STYPE_13_SENSUIKAN:int = 13;
      
      public static const STYPE_14_SENSUIKUUBO:int = 14;
      
      public static const STYPE_15_HOKYUUKAN:int = 15;
      
      public static const STYPE_16_SUIJOUBOKAN:int = 16;
      
      public static const STYPE_17_YOURIKUKAN:int = 17;
      
      public static const STYPE_18_SOUKOUKUUBO:int = 18;
      
      public static const STYPE_19_KOUSAKUKAN:int = 19;
      
      public static const STYPE_20_SENSUIBOKAN:int = 20;
      
      public static const STYPE_21_RENSYUJUNYOKAN:int = 21;
      
      public static const STYPE_22_HOKYUKAN:int = 22;
      
      public static const JIN01_TANJUU:int = 1;
      
      public static const JIN02_FUKUJUU:int = 2;
      
      public static const JIN03_RINKEI:int = 3;
      
      public static const JIN04_TEIKEI:int = 4;
      
      public static const JIN05_TANOU:int = 5;
      
      public static const JIN11_DAI1:int = 11;
      
      public static const JIN12_DAI2:int = 12;
      
      public static const JIN13_DAI3:int = 13;
      
      public static const JIN14_DAI4:int = 14;
      
      private static const SLOTITEM_RARITY_NAMES:Array = ["コモン","レア","ホロ","Sホロ","SSホロ","SSホロ","SSホロ+"];
      
      public static const SLOTITEM_CARDTYPE_01:int = 1;
      
      public static const SLOTITEM_CARDTYPE_02:int = 2;
      
      public static const SLOTITEM_EQUIPTYPE_01_SYUHOU_S:int = 1;
      
      public static const SLOTITEM_EQUIPTYPE_02_SYUHOU_M:int = 2;
      
      public static const SLOTITEM_EQUIPTYPE_03_SYUHOU_L:int = 3;
      
      public static const SLOTITEM_EQUIPTYPE_04_FUKUHOU:int = 4;
      
      public static const SLOTITEM_EQUIPTYPE_05_GYORAI:int = 5;
      
      public static const SLOTITEM_EQUIPTYPE_06_SENTOUKI:int = 6;
      
      public static const SLOTITEM_EQUIPTYPE_07_BAKUGEKIKI:int = 7;
      
      public static const SLOTITEM_EQUIPTYPE_08_KOUGEKIKI:int = 8;
      
      public static const SLOTITEM_EQUIPTYPE_09_KANJO_TEISATSUKI:int = 9;
      
      public static const SLOTITEM_EQUIPTYPE_10_SUIJO_TEISATSUKI:int = 10;
      
      public static const SLOTITEM_EQUIPTYPE_11_SUIZYOU_BAKUGEKIKI:int = 11;
      
      public static const SLOTITEM_EQUIPTYPE_18_SANSHIKI_DAN:int = 18;
      
      public static const SLOTITEM_EQUIPTYPE_21_TAIKUU_KIZYU:int = 21;
      
      public static const SLOTITEM_EQUIPTYPE_25_AUTOGYRO:int = 25;
      
      public static const SLOTITEM_EQUIPTYPE_26_ANTISUBMARINE_PATROL:int = 26;
      
      public static const SLOTITEM_EQUIPTYPE_29_SEARCHLIGHT:int = 29;
      
      public static const SLOTITEM_EQUIPTYPE_32_SUBMARINE_TORPEDO:int = 32;
      
      public static const SLOTITEM_EQUIPTYPE_37_GROUNDATTACK:int = 37;
      
      public static const SLOTITEM_EQUIPTYPE_38_SYUHOU_L_SPECIAL1:int = 38;
      
      public static const SLOTITEM_EQUIPTYPE_39_SURFACESHIP_CREW:int = 39;
      
      public static const SLOTITEM_EQUIPTYPE_41_FLYING_BOAT:int = 41;
      
      public static const SLOTITEM_EQUIPTYPE_42_LARGE_SEARCHLIGHT:int = 42;
      
      public static const SLOTITEM_EQUIPTYPE_43_RATION:int = 43;
      
      public static const SLOTITEM_EQUIPTYPE_45_SUIZYOU_SENTOUKI:int = 45;
      
      public static const SLOTITEM_ICON_11_DENTAN:int = 11;
      
      public static const SLOTITEM_ICON_16_HI_ANGLE:int = 16;
      
      public static const SLOTITEM_ICON_20:int = 20;
      
      public static const SLOTITEM_ICON_21:int = 21;
      
      public static const SLOTITEM_ICON_22:int = 22;
      
      public static const SLOTITEM_ICON_23:int = 23;
      
      public static const SLOTITEM_ICON_24:int = 24;
      
      public static const SLOTITEM_ICON_25:int = 25;
      
      public static const SLOTITEM_ICON_26:int = 26;
      
      public static const SLOTITEM_ICON_27:int = 27;
      
      public static const SLOTITEM_ICON_28:int = 28;
      
      public static const SLOTITEM_ICON_29:int = 29;
      
      public static const SLOTITEM_ICON_30:int = 30;
      
      public static const NOT_EXIST_SHIP:int = -1;
      
      public static const MAX_DECK_COUNT:int = 4;
      
      public static const MAX_SHIP_COUNT_IN_DECK:int = 6;
      
      public static const MAX_SLOT_COUNT_PER_SHIP:int = 5;
      
      public static const NO_DOCK:int = -1;
      
      public static const NO_SHIP_IN_DOCK:int = 0;
      
      public static const ENEMY_FIRST_ID:int = 501;
      
      public static const XMAS_FIRST_ID:int = 901;
      
      public static const FURNITURE_TYPE_FLOOR:int = 0;
      
      public static const FURNITURE_TYPE_WALL:int = 1;
      
      public static const FURNITURE_TYPE_WINDOW:int = 2;
      
      public static const FURNITURE_TYPE_OBJECT:int = 3;
      
      public static const FURNITURE_TYPE_CHEST:int = 4;
      
      public static const FURNITURE_TYPE_DESK:int = 5;
      
      public static const SEASON_ALL:int = 0;
      
      public static const SEASON_SPRING:int = 1;
      
      public static const SEASON_SUMMER:int = 2;
      
      public static const SEASON_AUTUMN:int = 3;
      
      public static const SEASON_WINTER:int = 4;
      
      public static const SEASON_THE_NEWYEAR:int = 11;
      
      public static const SEASON_XMAS:int = 12;
      
      public static const EVT_ANIMATION_END:String = "EVT_ANIMATION_END";
      
      public static const CELLCOLOR_1:int = 1;
      
      public static const CELLCOLOR_2:int = 2;
      
      public static const CELLCOLOR_3:int = 3;
      
      public static const CELLCOLOR_4:int = 4;
      
      public static const CELLCOLOR_5:int = 5;
      
      public static const CELL_E_FLG_01_NONE:int = 1;
      
      public static const CELL_E_FLG_02_ITEMGET:int = 2;
      
      public static const CELL_E_FLG_03_SWIRLING_CURRENT:int = 3;
      
      public static const CELL_E_FLG_04_BATTLE:int = 4;
      
      public static const CELL_E_FLG_05_BATTLE_BOSS:int = 5;
      
      public static const CELL_E_FLG_06_MEREFANCY:int = 6;
      
      public static const CELL_E_FLG_07_AIR_RECONNAISSANCE:int = 7;
      
      public static const CELL_E_FLG_08_SUPPLY_END:int = 8;
      
      public static const CELL_E_FLG_09_LANDING:int = 9;
      
      public static const CELL_E_FLG_99_SPECIAL:int = 99;
      
      public static const CELL_E_KIND_01_BATTLE:int = 1;
      
      public static const CELL_E_KIND_02_BATTLE_NIGHTONLY:int = 2;
      
      public static const CELL_E_KIND_03_BATTLE_NIGHTDAY:int = 3;
      
      public static const CELL_E_KIND_04_BATTLE_AERIAL_WARFARE:int = 4;
      
      public static const CELL_E_KIND_05_BATTLE_vs12:int = 5;
      
      public static const CELL_E_KIND_06_BATTLE_LONGDISTANCE_AIRRAID:int = 6;
      
      public static const CELL_E_KIND_00_MEREFANCY:int = 0;
      
      public static const CELL_E_KIND_01_MEREFANCY_NOENEMY:int = 1;
      
      public static const CELL_E_KIND_02_MEREFANCY_NONE:int = 2;
      
      public static const CELL_E_KIND_03_MEREFANCY_CALM_SEA:int = 3;
      
      public static const enemySlotitemImage:Object = {
         "550":3,
         "551":128,
         "552":76,
         "553":3,
         "563":162,
         "565":78,
         "567":13
      };
      
      public static const SHIP_ICON_TYPE_NORMAL:int = 0;
      
      public static const SHIP_ICON_TYPE_GROUND:int = 1;
      
      public static const SUPER_AA_ITEM_IDs:Array = [3,9,10,35,48];
      
      public static const ENEMY_PLANETYPES:Array = [[517,520,524],[518,521,525,526,544,546],[547,566],[548],[549,564],[554],[555],[556],[557],[558],[561],[562],[571],[572],[573]];
      
      public static const ANIMATION_TYPE_NORMAL:int = 0;
      
      public static const ANIMATION_TYPE_LOW:int = 1;
      
      public static const MEDAL_EXCHANGE_RATE:int = 4;
      
      public static const MISSION_TYPE_SUPPORT:Array = [33,34,205,206];
      
      public static const MISSION_TYPE_SUPPORT_EVENT:Array = [];
      
      public static const SLOTITEM_SPECIAL_FLAGS:Object = {
         128:{"eqType":38},
         142:{"eqType":43}
      };
      
      public static const SLOTITEM_CANNOT_EQUIP_TYPE3:Array = [47,48];
      
      private static const _PRESET_MAX_NUM:int = 9;
      
      private static var _USE_COMBINE_FLEET:Boolean = true;
      
      public static const EXTRA_SLOT_LEVEL:int = 30;
       
      
      public function Consts()
      {
         super();
      }
      
      public static function get CENTER_W() : Number
      {
         return 800 / 2;
      }
      
      public static function get CENTER_H() : Number
      {
         return 480 / 2;
      }
      
      public static function getSlotitemRarityName(param1:int) : String
      {
         if(param1 < SLOTITEM_RARITY_NAMES.length)
         {
            return SLOTITEM_RARITY_NAMES[param1];
         }
         return "";
      }
      
      public static function isEnemyCharacter(param1:int) : Boolean
      {
         return 501 <= param1 && param1 < 901;
      }
      
      public static function existTaihaImage(param1:int) : Boolean
      {
         return param1 < 501 || 901 <= param1;
      }
      
      public static function get PRESET_MAX_NUM() : int
      {
         return 9;
      }
      
      public static function get USE_COMBINE_FLEET() : Boolean
      {
         return _USE_COMBINE_FLEET;
      }
      
      public static function get USEITEM_FROM_SLOTITEM() : Object
      {
         return {
            50:42,
            51:43,
            66:145,
            67:146,
            69:150
         };
      }
   }
}
