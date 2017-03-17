package vo
{
   import common.models.JukeBGMObject;
   import common.models.PortBGMObject;
   import flash.utils.Dictionary;
   
   public class MasterBGMData
   {
       
      
      private var _dic:Dictionary;
      
      private var _list_jukebox:Vector.<JukeBGMObject> = null;
      
      public function MasterBGMData()
      {
         super();
         _dic = new Dictionary();
      }
      
      public function getIDList() : Array
      {
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _dic;
         for(var _loc1_ in _dic)
         {
            _loc2_.push(parseInt(_loc1_));
         }
         return _loc2_;
      }
      
      public function setData(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         _dic = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = new PortBGMObject(param1[_loc4_]);
            _loc2_ = _loc3_.id;
            _dic[_loc2_] = _loc3_;
            _loc4_++;
         }
      }
      
      public function getData(param1:String) : PortBGMObject
      {
         if(_dic.hasOwnProperty(param1))
         {
            return _dic[param1];
         }
         return null;
      }
      
      public function hasJukeBoxMusicData() : Boolean
      {
         return _list_jukebox != null;
      }
      
      public function setJukeBoxMusicData(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _list_jukebox = new Vector.<JukeBGMObject>();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new JukeBGMObject(param1[_loc3_]);
            _list_jukebox.push(_loc2_);
            _loc3_++;
         }
      }
      
      public function getJukeBoxMusicData() : Vector.<JukeBGMObject>
      {
         if(_list_jukebox == null)
         {
            return new Vector.<JukeBGMObject>();
         }
         return _list_jukebox.concat();
      }
   }
}
