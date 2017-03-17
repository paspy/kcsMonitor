package common.events
{
   import flash.events.Event;
   
   public class BattleEndEvent extends Event
   {
      
      public static const BATTLE_END:String = "EVENT::BATTLE_END";
       
      
      public var damagedFlagship:Boolean = false;
      
      public var hasYouinAtFlagship:Boolean = false;
      
      public var hasMegamiAtFlagship:Boolean = false;
      
      public var taihiList_Main:Array;
      
      public var taihiList_Sub:Array;
      
      public var option:Object;
      
      public function BattleEndEvent(param1:Boolean = false, param2:Boolean = false)
      {
         option = {};
         super("EVENT::BATTLE_END",param1,param2);
      }
   }
}
