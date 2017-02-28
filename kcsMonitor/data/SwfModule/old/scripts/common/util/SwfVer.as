package common.util
{
   public class SwfVer
   {
      
      private static var _o:Object;
       
      
      public function SwfVer(param1:Object)
      {
         super();
         _o = param1;
         _o = _o == null?{}:_o;
      }
      
      public static function get CORE() : String
      {
         return Util.getString(_o,"mm_core","0.0.0");
      }
      
      public static function get TITLE() : String
      {
         return Util.getString(_o,"mm_title","0.0.0");
      }
      
      public static function get COMMONASSETS() : String
      {
         return Util.getString(_o,"mm_common","0.0.0");
      }
      
      public static function get PORT() : String
      {
         return Util.getString(_o,"mm_port","0.0.0");
      }
      
      public static function get BATTLE() : String
      {
         return Util.getString(_o,"mm_battle","0.0.0");
      }
      
      public static function get BATTLE_RESULT() : String
      {
         return Util.getString(_o,"mm_battleresult","0.0.0");
      }
      
      public static function get FONTASSET() : String
      {
         return Util.getString(_o,"rm_font","0.0.0");
      }
      
      public static function get ICONASSET() : String
      {
         return Util.getString(_o,"rm_icon","0.0.0");
      }
      
      public static function get UITEM_ICONASSET() : String
      {
         return Util.getString(_o,"rm_itemicon","0.0.0");
      }
      
      public static function get STYPE_ASSET() : String
      {
         return Util.getString(_o,"rm_stype","");
      }
      
      public static function get SOUND_BGM_ASSET() : String
      {
         return Util.getString(_o,"rm_sound_bgm","0.0.0");
      }
      
      public static function get SOUND_SE_ASSET() : String
      {
         return Util.getString(_o,"rm_sound_se","0.0.0");
      }
      
      public static function get BATTLEBGM() : Array
      {
         return Util.getArray(_o,"rm_battlebgm",[]);
      }
      
      public static function getBGM_P_Ver(param1:String) : String
      {
         var _loc2_:Object = Util.getObject(_o,"rm_bgm_p",{});
         return Util.getString(_loc2_,param1);
      }
      
      public static function get U_RECORD() : String
      {
         return Util.getString(_o,"um_record","0.0.0");
      }
      
      public static function get U_ALBUM() : String
      {
         return Util.getString(_o,"um_album","0.0.0");
      }
      
      public static function get U_ITEM() : String
      {
         return Util.getString(_o,"um_itemlist","0.0.0");
      }
      
      public static function get U_INTERIOR() : String
      {
         return Util.getString(_o,"um_interior","0.0.0");
      }
      
      public static function get U_DUTY() : String
      {
         return Util.getString(_o,"um_duty","0.0.0");
      }
      
      public static function get L_ORGANIZE() : String
      {
         return Util.getString(_o,"lm_organize","0.0.0");
      }
      
      public static function get L_SUPPLY() : String
      {
         return Util.getString(_o,"lm_supply","0.0.0");
      }
      
      public static function get L_REMODEL() : String
      {
         return Util.getString(_o,"lm_remodel","0.0.0");
      }
      
      public static function get L_REPAIR() : String
      {
         return Util.getString(_o,"lm_repair","0.0.0");
      }
      
      public static function get L_ARSENAL() : String
      {
         return Util.getString(_o,"lm_arsenal","0.0.0");
      }
      
      public static function get L_SALLY() : String
      {
         return Util.getString(_o,"lm_sally","0.0.0");
      }
      
      public static function get X_WEDDING() : String
      {
         return Util.getString(_o,"xm_wedding","0.0.0");
      }
      
      public static function get X_REVAMP() : String
      {
         return Util.getString(_o,"xm_revamp","0.0.0");
      }
      
      public static function get MAP() : Object
      {
         return Util.getObject(_o,"maps",{});
      }
      
      public static function toString() : String
      {
         return JSON.stringify(_o);
      }
   }
}
