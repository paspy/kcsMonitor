package a24.tween.core.updaters
{
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   
   public final class ObjectUpdater extends AbstractUpdater
   {
       
      
      private var _target;
      
      private var _param:Object;
      
      private var _$param:Object;
      
      private var _$$param:Object;
      
      private var _startParam:Object;
      
      private var _deltaParam:Object;
      
      private var _key:Array;
      
      private var _tweenKey:Array;
      
      public function ObjectUpdater(param1:*)
      {
         super();
         _target = param1;
         _param = {};
         _startParam = {};
         _deltaParam = {};
         _key = [];
      }
      
      public function setProp(param1:Object) : void
      {
         _param = param1;
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for(var _loc2_ in param1)
         {
            if(_loc2_.slice(0,2) == "$$")
            {
               _loc2_ = _loc2_.substr(2,_loc2_.length);
               if(!_$$param)
               {
                  _$$param = {};
               }
               _$$param[_loc2_] = _param["$$" + _loc2_];
               delete _param["$$" + _loc2_];
            }
            else if(_loc2_.slice(0,1) == "$")
            {
               _loc2_ = _loc2_.substr(1,_loc2_.length);
               if(!_$param)
               {
                  _$param = {};
               }
               _param[_loc2_] = _target[_loc2_] + param1["$" + _loc2_];
               _$param[_loc2_] = _param["$" + _loc2_];
               delete _param["$" + _loc2_];
            }
            else
            {
               _param[_loc2_] = param1[_loc2_];
            }
            _key.push(_loc2_);
         }
      }
      
      public function addProp(param1:String, param2:*) : void
      {
         var _loc3_:* = param1;
         if(_loc3_.slice(0,2) == "$$")
         {
            _loc3_ = _loc3_.substr(2,_loc3_.length);
            if(!_$$param)
            {
               _$$param = {};
            }
            _$$param[_loc3_] = param2;
         }
         else if(_loc3_.slice(0,1) == "$")
         {
            _loc3_ = _loc3_.substr(1,_loc3_.length);
            if(!_$param)
            {
               _$param = {};
            }
            _param[_loc3_] = _target[_loc3_] + param2;
            _$param[_loc3_] = param2;
         }
         else
         {
            _param[_loc3_] = param2;
         }
         _key.push(_loc3_);
      }
      
      public function init() : AbstractUpdater
      {
         var _loc1_:* = null;
         _tweenKey = _key.concat();
         if(_$$param)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _$$param;
            for(_loc1_ in _$$param)
            {
               _param[_loc1_] = _target[_loc1_] + _$$param[_loc1_];
            }
         }
         var _loc5_:int = 0;
         var _loc4_:* = _key;
         for each(_loc1_ in _key)
         {
            _startParam[_loc1_] = _target[_loc1_];
            _deltaParam[_loc1_] = _param[_loc1_] - _target[_loc1_];
         }
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         var _loc4_:int = 0;
         var _loc3_:* = _tweenKey;
         for each(var _loc2_ in _tweenKey)
         {
            _target[_loc2_] = _startParam[_loc2_] + _deltaParam[_loc2_] * param1;
         }
         return this;
      }
      
      override public function complete() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _tweenKey;
         for each(var _loc1_ in _tweenKey)
         {
            _target[_loc1_] = _param[_loc1_];
         }
      }
      
      override public function overwrite(param1:AbstractUpdater) : void
      {
         var _loc5_:int = 0;
         var _loc3_:ObjectUpdater = param1 as ObjectUpdater;
         var _loc2_:Array = _loc3_._tweenKey;
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(var _loc4_ in _loc2_)
         {
            _loc5_ = _tweenKey.indexOf(_loc4_);
            if(_loc5_ > -1)
            {
               _tweenKey.splice(_loc5_,1);
            }
         }
      }
      
      public function clone() : ObjectUpdater
      {
         var _loc1_:ObjectUpdater = new ObjectUpdater(_target);
         _loc1_.setProp(_param);
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return " param:" + _param;
      }
   }
}
