package a24.tween
{
   import a24.tween.core.plugins.PluginTween24Property;
   import a24.tween.core.plugins.PulginTween24;
   import a24.tween.core.updaters.ObjectUpdater;
   import a24.tween.core.updaters.colors.BrightUpdater;
   import a24.tween.core.updaters.colors.ColorReversalUpdater;
   import a24.tween.core.updaters.colors.ColorUpdater;
   import a24.tween.core.updaters.colors.ContrastUpdater;
   import a24.tween.core.updaters.display.DisplayObjectUpdater;
   import a24.tween.core.updaters.display.TimelineUpdater;
   import a24.tween.core.updaters.filters.BlurFilterUpdater;
   import a24.tween.core.updaters.filters.DropShadowFilterUpdater;
   import a24.tween.core.updaters.filters.GlowFilterUpdater;
   import a24.tween.core.updaters.filters.SaturationUpdater;
   import a24.tween.core.updaters.filters.SharpUpdater;
   import a24.tween.events.Tween24Event;
   import a24.tween.plugins.proxy.PluginProxy;
   import a24.util.Align24;
   import a24.util.Util24;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.filters.BitmapFilter;
   import flash.filters.BlurFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.ConvolutionFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class Tween24 implements IEventDispatcher
   {
      
      public static const VERSION:String = "2.1α";
      
      private static var _numTotalTween:int;
      
      private static var _numPlayingTween:int;
      
      private static var _numPlayedTween:int;
      
      private static var _numTotalManualTween:int;
      
      private static var _engine:Sprite;
      
      private static var _runing:Boolean;
      
      private static var _stage:Stage;
      
      private static var _globalTimeScale:Number;
      
      private static var _debugMode:Boolean;
      
      private static var _ease:Ease24 = new Ease24();
      
      private static var _defaultEasing:Function = Ease24._Linear;
      
      private static var _plugin:PluginProxy = new PluginProxy();
      
      private static var _aligin:Align24 = new Align24();
      
      private static var _nowTime:Number;
      
      private static var _tweensById:Array;
      
      private static var _tweensByGroup:Array;
      
      private static var _playingTweensByTarget:Dictionary;
      
      private static var _pausingTweensByTarget:Dictionary;
      
      private static var _pausingAllTweens:Dictionary;
      
      private static var _manualTweens:Dictionary;
      
      private static var _firstTween:Tween24;
      
      private static var _endTween:Tween24;
      
      private static const _TYPE_TWEEN:String = "tween";
      
      private static const _TYPE_SERIAL:String = "serial";
      
      private static const _TYPE_PARALLEL:String = "parallel";
      
      private static const _TYPE_LOOP:String = "loop";
      
      private static const _TYPE_LAG:String = "lag";
      
      private static const _TYPE_PROP:String = "prop";
      
      private static const _TYPE_WAIT:String = "wait";
      
      private static const _TYPE_JUMP:String = "jump";
      
      private static const _TYPE_TWEEN_FUNC:String = "tweenFunc";
      
      private static const _TYPE_IF_CASE:String = "ifCase";
      
      private static const _TYPE_TWEEN_COUNT:String = "tweenCount";
      
      private static const _TYPE_WAIT_COUNT:String = "waitCount";
      
      private static const _TYPE_FUNC_COUNT:String = "funcCount";
      
      private static const _TYPE_ACTION:String = "action";
      
      private static const _TYPE_FUNC:String = "func";
      
      private static const _TYPE_FUNC_AND_WAIT:String = "funcAndWait";
      
      private static const _TYPE_WAIT_EVENT:String = "waitEvent";
      
      private static const _TYPE_ALL_PAUSE:String = "pauseAllTweens";
      
      private static const _TYPE_RANDOM:String = "randome";
      
      private static const _TRACE_PLAY:Boolean = false;
      
      private static const _TRACE_PAUSE:Boolean = false;
      
      private static const _TRACE_STOP:Boolean = false;
      
      private static const _TRACE_INIT:Boolean = false;
      
      private static const _TRACE_UPDATE:Boolean = false;
      
      private static const _TRACE_NEXT:Boolean = false;
      
      private static const _TRACE_REMOVE:Boolean = false;
       
      
      private var _target:Array;
      
      private var _targetSingle:Object;
      
      private var _time:Number;
      
      private var _easing:Function;
      
      private var _totalTime:Number;
      
      private var _delayTime:Number;
      
      private var _startTime:Number;
      
      private var _completeTime:Number;
      
      private var _timeScale:Number;
      
      private var _totalTimeScale:Number;
      
      private var _progress:Number;
      
      private var _progressDelay:Number;
      
      private var _uniqueId:int;
      
      private var _manualPlayId:int;
      
      private var _type:String;
      
      private var _actionName:String;
      
      private var _loopCount:int;
      
      private var _loopCurrent:int;
      
      private var _serialTween:Tween24;
      
      private var _parallelTweens:Array;
      
      private var _randomTween:Tween24;
      
      private var _randomTweens:Array;
      
      private var _action:Function;
      
      private var _id:String;
      
      private var _group:Array;
      
      private var _level:int;
      
      private var _velocity:Number;
      
      private var _numChildren:int;
      
      private var _numCompleteChildren:int;
      
      private var _prevList:Tween24;
      
      private var _nextList:Tween24;
      
      private var _parentTrigger:Boolean;
      
      private var _playing:Boolean;
      
      private var _delaying:Boolean;
      
      private var _pausing:Boolean;
      
      private var _inited:Boolean;
      
      private var _played:Boolean;
      
      private var _completed:Boolean;
      
      private var _skipped:Boolean;
      
      private var _actioned:Boolean;
      
      private var _nextTweenPlayed:Boolean;
      
      private var _isJump:Boolean;
      
      private var _isFilter:Boolean;
      
      private var _isRemoveParent:Boolean;
      
      private var _isDebug:Boolean;
      
      private var _nextTween:Tween24;
      
      private var _rootTween:Tween24;
      
      private var _parentTween:Tween24;
      
      private var _playingChildTweens:Dictionary;
      
      private var _pausingChildTweens:Dictionary;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _dispatchPlay:Boolean;
      
      private var _dispatchDelay:Boolean;
      
      private var _dispatchInit:Boolean;
      
      private var _dispatchPause:Boolean;
      
      private var _dispatchSkip:Boolean;
      
      private var _dispatchStop:Boolean;
      
      private var _dispatchUpdate:Boolean;
      
      private var _dispatchComplete:Boolean;
      
      private var _onPlay:Function;
      
      private var _onPlayArgs:Array;
      
      private var _onDelay:Function;
      
      private var _onDelayArgs:Array;
      
      private var _onInit:Function;
      
      private var _onInitArgs:Array;
      
      private var _onUpdate:Function;
      
      private var _onUpdateArgs:Array;
      
      private var _onPause:Function;
      
      private var _onPauseArgs:Array;
      
      private var _onSkip:Function;
      
      private var _onSkipArgs:Array;
      
      private var _onStop:Function;
      
      private var _onStopArgs:Array;
      
      private var _onComp:Function;
      
      private var _onCompArgs:Array;
      
      private var _displayUpdater:DisplayObjectUpdater;
      
      private var _displayUpdaters:Dictionary;
      
      private var _objectUpdater:ObjectUpdater;
      
      private var _objectUpdaters:Dictionary;
      
      private var _blurUpdater:BlurFilterUpdater;
      
      private var _blurUpdaters:Dictionary;
      
      private var _glowUpdater:GlowFilterUpdater;
      
      private var _glowUpdaters:Dictionary;
      
      private var _dropShadowUpdater:DropShadowFilterUpdater;
      
      private var _dropShadowUpdaters:Dictionary;
      
      private var _brightUpdater:BrightUpdater;
      
      private var _brightUpdaters:Dictionary;
      
      private var _contrastUpdater:ContrastUpdater;
      
      private var _contrastUpdaters:Dictionary;
      
      private var _colorUpdater:ColorUpdater;
      
      private var _colorUpdaters:Dictionary;
      
      private var _saturationUpdater:SaturationUpdater;
      
      private var _saturationUpdaters:Dictionary;
      
      private var _timelineUpdater:TimelineUpdater;
      
      private var _timelineUpdaters:Dictionary;
      
      private var _colorReversalUpdater:ColorReversalUpdater;
      
      private var _colorReversalUpdaters:Dictionary;
      
      private var _sharpUpdater:SharpUpdater;
      
      private var _sharpUpdaters:Dictionary;
      
      private var _dispatcher:IEventDispatcher;
      
      private var _eventType:String;
      
      private var _tweenFunc:Function;
      
      private var _tweenStartArgs:Array;
      
      private var _tweenDeltaArgs:Array;
      
      private var _tweenCompArgs:Array;
      
      private var _useIfCase:Boolean;
      
      private var _ifCaseChildTween:Tween24;
      
      private var _ifCaseTrueTween:Tween24;
      
      private var _ifCaseFalseTween:Tween24;
      
      private var _ifCaseBoolean:Boolean;
      
      private var _ifCaseTarget:Object;
      
      private var _ifCasePropName:String;
      
      private var _pluginProperty:PluginTween24Property;
      
      private var _isManual:Boolean;
      
      private var _totalCount:int;
      
      private var _currentCount:int;
      
      private var _delayCount:int;
      
      private var _delayCurrentCount:int;
      
      public function Tween24(param1:* = null, param2:Number = 0, param3:Function = null, param4:Object = null)
      {
         var _loc5_:* = null;
         super();
         if(param1 is Array)
         {
            _target = param1.concat();
         }
         else
         {
            _targetSingle = param1;
         }
         _time = param2;
         _easing = param3 || _defaultEasing;
         _delayTime = 0;
         _totalTime = _time;
         _progress = 0;
         _progressDelay = 0;
         _timeScale = 1;
         _totalTimeScale = 1;
         _uniqueId = _numTotalTween;
         _numTotalTween = Number(_numTotalTween) + 1;
         if(param4)
         {
            if(_targetSingle)
            {
               _objectUpdater = new ObjectUpdater(_targetSingle);
               _objectUpdater.setProp(param4);
            }
            else
            {
               _objectUpdaters = new Dictionary();
               var _loc8_:int = 0;
               var _loc7_:* = _target;
               for each(var _loc6_ in _target)
               {
                  _loc5_ = new ObjectUpdater(_loc6_);
                  _loc5_.setProp(param4);
                  _objectUpdaters[_loc6_] = _loc5_;
               }
            }
         }
         if(param1 is PluginTween24Property)
         {
            _pluginProperty = param1 as PluginTween24Property;
         }
         if(!_engine)
         {
            _engine = new Sprite();
            _pausingAllTweens = new Dictionary();
            _tweensById = [];
            _tweensByGroup = [];
            _playingTweensByTarget = new Dictionary();
            _pausingTweensByTarget = new Dictionary();
            _manualTweens = new Dictionary();
            if(!_globalTimeScale)
            {
               _globalTimeScale = 1;
            }
         }
      }
      
      public static function tween(param1:Object, param2:Number, param3:Function = null, param4:Object = null) : Tween24
      {
         var _loc5_:Tween24 = new Tween24(param1,param2,param3,param4);
         _loc5_._type = "tween";
         _loc5_._actionName = "tween";
         return _loc5_;
      }
      
      public static function prop(param1:Object, param2:Object = null) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(param1,0,null,param2);
         _loc3_._type = "prop";
         _loc3_._actionName = "prop";
         return _loc3_;
      }
      
      public static function tweenFunc(param1:Function, param2:Number, param3:Array, param4:Array, param5:Function = null) : Tween24
      {
         var _loc8_:int = 0;
         var _loc6_:Tween24 = new Tween24(null,param2,param5);
         _loc6_._type = "tweenFunc";
         _loc6_._actionName = "tweenFunc";
         _loc6_._tweenFunc = param1;
         _loc6_._tweenStartArgs = param3;
         _loc6_._tweenCompArgs = param4;
         _loc6_._tweenDeltaArgs = [];
         var _loc7_:int = param3.length;
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc6_._tweenDeltaArgs.push(param4[_loc8_] - param3[_loc8_]);
            _loc8_++;
         }
         return _loc6_;
      }
      
      public static function tweenVelocity(param1:Object, param2:Number, param3:Function = null, param4:Object = null) : Tween24
      {
         var _loc5_:Tween24 = new Tween24(param1,999,param3,param4);
         _loc5_._type = "tween";
         _loc5_._actionName = "tweenVelocity";
         _loc5_._velocity = param2;
         return _loc5_;
      }
      
      public static function tweenCount(param1:Object, param2:int, param3:Function = null, param4:Object = null) : Tween24
      {
         var _loc5_:Tween24 = new Tween24(param1,NaN,param3);
         _loc5_._type = "tweenCount";
         _loc5_._actionName = "tweenCount";
         _loc5_._totalCount = param2;
         return _loc5_;
      }
      
      public static function waitCount(param1:uint) : Tween24
      {
         var _loc2_:Tween24 = new Tween24();
         _loc2_._type = "waitCount";
         _loc2_._actionName = "waitCount";
         _loc2_._totalCount = param1;
         return _loc2_;
      }
      
      public static function funcCount(param1:Function, param2:uint, param3:Array, param4:Array, param5:Function = null) : Tween24
      {
         var _loc8_:int = 0;
         var _loc6_:Tween24 = new Tween24(null,NaN,param5);
         _loc6_._type = "funcCount";
         _loc6_._actionName = "funcCount";
         _loc6_._tweenFunc = param1;
         _loc6_._tweenStartArgs = param3;
         _loc6_._tweenCompArgs = param4;
         _loc6_._tweenDeltaArgs = [];
         _loc6_._totalCount = param2;
         var _loc7_:int = param3.length;
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc6_._tweenDeltaArgs.push(param4[_loc8_] - param3[_loc8_]);
            _loc8_++;
         }
         return _loc6_;
      }
      
      public static function serial(... rest) : Tween24
      {
         var _loc7_:Boolean = false;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = "serial";
         _loc3_._actionName = "serial";
         rest = replacePlugin(rest);
         var _loc5_:* = 0;
         var _loc4_:int = rest.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc2_ = rest[_loc6_];
            _loc2_._nextTween = rest[_loc6_ + 1];
            _loc2_._parentTween = _loc3_;
            if(_loc2_._isJump)
            {
               _loc5_ = Number(_loc2_._totalTime + _loc2_._delayTime);
               _loc2_._parentTrigger = true;
               _loc7_ = true;
            }
            else if(!_loc7_)
            {
               _loc5_ = Number(_loc5_ + _loc2_._totalTime);
            }
            _loc6_++;
         }
         if(!_loc7_)
         {
            _loc2_._parentTrigger = true;
         }
         _loc3_._totalTime = _loc5_;
         _loc3_._serialTween = rest[0];
         _loc3_._numChildren = rest.length;
         return _loc3_;
      }
      
      public static function parallel(... rest) : Tween24
      {
         var _loc4_:Tween24 = new Tween24();
         _loc4_._type = "parallel";
         _loc4_._actionName = "parallel";
         rest = replacePlugin(rest);
         var _loc2_:* = 0;
         var _loc6_:int = 0;
         var _loc5_:* = rest;
         for each(var _loc3_ in rest)
         {
            _loc3_._parentTween = _loc4_;
            if(_loc3_._isJump)
            {
               _loc2_ = Number(_loc3_._totalTime + _loc3_._delayTime);
               _loc3_._parentTrigger = true;
            }
         }
         _loc4_._totalTime = _loc2_;
         _loc4_._parallelTweens = rest;
         _loc4_._numChildren = rest.length;
         return _loc4_;
      }
      
      public static function lag(param1:Number, ... rest) : Tween24
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc17_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc4_:* = null;
         var _loc19_:* = null;
         var _loc7_:* = null;
         var _loc10_:* = null;
         var _loc15_:* = null;
         var _loc12_:* = null;
         var _loc16_:* = null;
         var _loc9_:* = null;
         var _loc6_:* = null;
         rest = replacePlugin(rest);
         var _loc18_:Array = [];
         var _loc21_:int = 0;
         var _loc20_:* = rest;
         for each(var _loc3_ in rest)
         {
            _loc5_ = _loc3_._target.length;
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               _loc17_ = _loc3_._target[_loc8_];
               _loc13_ = new Tween24(_loc17_,_loc3_._time,_loc3_._easing);
               _loc13_._type = _loc3_._type;
               _loc13_.delay(_loc3_._delayTime + param1 * _loc8_);
               if(_loc3_._displayUpdaters)
               {
                  _loc13_._displayUpdater = _loc3_._displayUpdaters[_loc17_];
               }
               _loc14_ = _loc3_._blurUpdater;
               _loc4_ = _loc3_._glowUpdater;
               _loc19_ = _loc3_._dropShadowUpdater;
               _loc7_ = _loc3_._brightUpdater;
               _loc10_ = _loc3_._contrastUpdater;
               _loc15_ = _loc3_._colorUpdater;
               _loc12_ = _loc3_._saturationUpdater;
               _loc16_ = _loc3_._timelineUpdater;
               _loc9_ = _loc3_._colorReversalUpdater;
               _loc6_ = _loc3_._sharpUpdater;
               if(_loc14_)
               {
                  _loc13_.blur(_loc14_.blurX,_loc14_.blurY,_loc14_.quality);
               }
               if(_loc4_)
               {
                  _loc13_.glow(_loc4_.color,_loc4_.alpha,_loc4_.blurX,_loc4_.blurY,_loc4_.strength,_loc4_.quality);
               }
               if(_loc19_)
               {
                  _loc13_.dropShadow(_loc19_.distance,_loc19_.angle,_loc19_.color,_loc19_.alpha,_loc19_.blurX,_loc19_.blurY,_loc19_.strength,_loc19_.quality);
               }
               if(_loc7_)
               {
                  _loc13_.bright(_loc7_.brightness);
               }
               if(_loc10_)
               {
                  _loc13_.contrast(_loc10_.contrast);
               }
               if(_loc15_)
               {
                  _loc13_.color(_loc15_.color,_loc15_.alpha);
               }
               if(_loc12_)
               {
                  _loc13_.saturation(_loc12_.saturation);
               }
               if(_loc16_)
               {
                  _loc13_.frame(_loc16_.frame);
               }
               if(_loc9_)
               {
                  _loc13_.colorReversal(_loc9_.value);
               }
               if(_loc6_)
               {
                  _loc13_.sharp(_loc6_.sharpness);
               }
               if(_loc3_._onPlay != null)
               {
                  _loc13_.onPlay(_loc3_._onPlay,_loc3_._onPlayArgs);
               }
               if(_loc3_._onDelay != null)
               {
                  _loc13_.onDelay(_loc3_._onDelay,_loc3_._onDelayArgs);
               }
               if(_loc3_._onInit != null)
               {
                  _loc13_.onInit(_loc3_._onInit,_loc3_._onInitArgs);
               }
               if(_loc3_._onUpdate != null)
               {
                  _loc13_.onUpdate(_loc3_._onUpdate,_loc3_._onUpdateArgs);
               }
               if(_loc3_._onPause != null)
               {
                  _loc13_.onPause(_loc3_._onPause,_loc3_._onPauseArgs);
               }
               if(_loc3_._onStop != null)
               {
                  _loc13_.onStop(_loc3_._onStop,_loc3_._onStopArgs);
               }
               if(_loc3_._onSkip != null)
               {
                  _loc13_.onSkip(_loc3_._onSkip,_loc3_._onSkipArgs);
               }
               if(_loc3_._onComp != null)
               {
                  _loc13_.onComplete(_loc3_._onComp,_loc3_._onCompArgs);
               }
               if(_loc3_._isRemoveParent)
               {
                  _loc13_.andRemoveChild();
               }
               _loc18_.push(_loc13_);
               _loc8_++;
            }
         }
         var _loc11_:Tween24 = Tween24.parallel(_loc18_);
         _loc11_._type = "lag";
         _loc11_._actionName = "lag";
         return _loc11_;
      }
      
      public static function loop(param1:int, ... rest) : Tween24
      {
         var _loc8_:Boolean = false;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc4_:Tween24 = new Tween24();
         _loc4_._type = "loop";
         _loc4_._actionName = "loop";
         rest = replacePlugin(rest);
         var _loc6_:* = 0;
         var _loc5_:int = rest.length;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc3_ = rest[_loc7_];
            _loc3_._nextTween = rest[_loc7_ + 1];
            _loc3_._parentTween = _loc4_;
            _loc6_ = Number(_loc6_ + _loc3_._totalTime);
            _loc7_++;
         }
         _loc4_._totalTime = _loc6_;
         _loc4_._serialTween = rest[0];
         _loc4_._numChildren = rest.length;
         _loc4_._loopCount = param1;
         return _loc4_;
      }
      
      public static function ifCase(param1:*, param2:* = null, param3:* = null) : Tween24
      {
         var _loc4_:Tween24 = new Tween24();
         _loc4_._type = "ifCase";
         _loc4_._actionName = "ifCase";
         _loc4_._useIfCase = true;
         _loc4_._numChildren = 1;
         _loc4_._ifCaseBoolean = Boolean(param1);
         _loc4_._ifCaseTrueTween = param2 is PulginTween24?PulginTween24(param2).getTween24():param2;
         _loc4_._ifCaseFalseTween = param3 is PulginTween24?PulginTween24(param3).getTween24():param3;
         _loc4_._ifCaseTrueTween._parentTween = _loc4_;
         if(param3)
         {
            _loc4_._ifCaseFalseTween._parentTween = _loc4_;
         }
         return _loc4_;
      }
      
      public static function ifCaseByProp(param1:*, param2:String, param3:Tween24 = null, param4:Tween24 = null) : Tween24
      {
         var _loc5_:Tween24 = new Tween24();
         _loc5_._type = "ifCase";
         _loc5_._actionName = "ifCaseByProp";
         _loc5_._useIfCase = true;
         _loc5_._numChildren = 1;
         _loc5_._ifCaseTarget = param1;
         _loc5_._ifCasePropName = param2;
         _loc5_._ifCaseTrueTween = param3;
         _loc5_._ifCaseFalseTween = param4;
         _loc5_._ifCaseTrueTween._parentTween = _loc5_;
         _loc5_._ifCaseTrueTween._parentTrigger = true;
         if(param4)
         {
            _loc5_._ifCaseFalseTween._parentTween = _loc5_;
            _loc5_._ifCaseFalseTween._parentTrigger = true;
         }
         return _loc5_;
      }
      
      public static function random(... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = "randome";
         _loc3_._actionName = "random";
         _loc3_._randomTweens = rest;
         _loc3_._numChildren = 1;
         var _loc5_:int = 0;
         var _loc4_:* = rest;
         for each(var _loc2_ in rest)
         {
            _loc2_._parentTween = _loc3_;
         }
         return _loc3_;
      }
      
      private static function eachFuncInPlayingTweens(param1:String, ... rest) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(_firstTween)
         {
            _loc3_ = _firstTween;
            do
            {
               _loc4_ = _loc3_._nextList;
               if(!rest.length)
               {
                  _loc3_[param1]();
               }
               else
               {
                  _loc3_[param1].apply(_loc3_,rest);
               }
               _loc3_ = _loc4_;
            }
            while(_loc3_ != null);
            
         }
      }
      
      private static function eachFuncInPausingTweens(param1:String, ... rest) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _pausingAllTweens;
         for each(var _loc3_ in _pausingAllTweens)
         {
            if(!rest.length)
            {
               _loc3_[param1]();
            }
            else
            {
               _loc3_[param1].apply(_loc3_,rest);
            }
         }
      }
      
      private static function getControlTween(param1:String, param2:Array, param3:String, ... rest) : Tween24
      {
         actionName = param1;
         tweens = param2;
         funcName = param3;
         args = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = actionName;
         tween._action = function():void
         {
            var _loc3_:int = 0;
            var _loc2_:* = tweens;
            for each(var _loc1_ in tweens)
            {
               if(!args.length)
               {
                  _loc1_[funcName]();
               }
               else
               {
                  _loc1_[funcName].apply(_loc1_,args);
               }
            }
         };
         return tween;
      }
      
      private static function getControlTweenBy(param1:String, param2:Function, param3:Array, param4:String, ... rest) : Tween24
      {
         actionName = param1;
         getFunc = param2;
         getArgs = param3;
         funcName = param4;
         args = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = actionName;
         tween._action = function():void
         {
            var _loc3_:int = 0;
            var _loc2_:* = getFunc.apply(this,getArgs);
            for each(var _loc1_ in getFunc.apply(this,getArgs))
            {
               if(!args.length)
               {
                  _loc1_[funcName]();
               }
               else
               {
                  _loc1_[funcName].apply(_loc1_,args);
               }
            }
         };
         return tween;
      }
      
      public static function playById(... rest) : Tween24
      {
         return getControlTweenBy("playById",getTweenArrayById,rest,"play");
      }
      
      public static function pauseById(... rest) : Tween24
      {
         return getControlTweenBy("pauseById",getTweenArrayById,rest,"pause");
      }
      
      public static function skipById(... rest) : Tween24
      {
         return getControlTweenBy("skipById",getTweenArrayById,rest,"skip");
      }
      
      public static function stopById(... rest) : Tween24
      {
         return getControlTweenBy("stopById",getTweenArrayById,rest,"stop");
      }
      
      public static function setGlobalTimeScaleById(param1:Number, ... rest) : Tween24
      {
         return getControlTweenBy("setGlobalTimeScaleById",getTweenArrayById,rest,"setTimeScale",param1);
      }
      
      public static function manualPlayById(... rest) : Tween24
      {
         return getControlTweenBy("manualPlayById",getTweenArrayById,rest,"manualPlay");
      }
      
      public static function manualUpdateById(... rest) : Tween24
      {
         return getControlTweenBy("manualUpdateById",getTweenArrayById,rest,"manualUpdate");
      }
      
      public static function disposeIdTween(... rest) : Tween24
      {
         id = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "disposeIdTween";
         tween._action = function():void
         {
            var _loc3_:int = 0;
            var _loc2_:* = id;
            for each(var _loc1_ in id)
            {
               delete _tweensById[_loc1_];
            }
         };
         return tween;
      }
      
      public static function playByGroup(... rest) : Tween24
      {
         return getControlTweenBy("playByGroup",getTweenArrayByGroup,rest,"play");
      }
      
      public static function pauseByGroup(... rest) : Tween24
      {
         return getControlTweenBy("pauseByGroup",getTweenArrayByGroup,rest,"pause");
      }
      
      public static function skipByGroup(... rest) : Tween24
      {
         return getControlTweenBy("skipByGroup",getTweenArrayByGroup,rest,"skip");
      }
      
      public static function stopByGroup(... rest) : Tween24
      {
         return getControlTweenBy("stopByGroup",getTweenArrayByGroup,rest,"stop");
      }
      
      public static function setGlobalTimeScaleByGroup(param1:Number, ... rest) : Tween24
      {
         return getControlTweenBy("setGlobalTimeScaleByGroup",getTweenArrayByGroup,rest,"setTimeScale",param1);
      }
      
      public static function manualPlayByGroup(... rest) : Tween24
      {
         return getControlTweenBy("manualPlayByGroup",getTweenArrayByGroup,rest,"manualPlay");
      }
      
      public static function manualUpdateByGroup(... rest) : Tween24
      {
         return getControlTweenBy("manualUpdateByGroup",getTweenArrayByGroup,rest,"manualUpdate");
      }
      
      public static function disposeGroupTweens(... rest) : Tween24
      {
         id = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "disposeGroupTweens";
         tween._action = function():void
         {
            var _loc3_:int = 0;
            var _loc2_:* = id;
            for each(var _loc1_ in id)
            {
               delete _tweensByGroup[_loc1_];
            }
         };
         return tween;
      }
      
      public static function pauseByTarget(... rest) : Tween24
      {
         return getControlTweenBy("pauseByTarget",getPlayingTweenArrayByTarget,rest,"pause");
      }
      
      public static function stopByTarget(... rest) : Tween24
      {
         return getControlTweenBy("stopByTarget",getTweenArrayByTarget,rest,"stop");
      }
      
      public static function setGlobalTimeScaleByTarget(param1:Number, ... rest) : Tween24
      {
         return getControlTweenBy("setGlobalTimeScaleByTarget",getTweenArrayByTarget,rest,"setTimeScale",param1);
      }
      
      public static function pauseChildTweens(... rest) : Tween24
      {
         container = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "pauseChildTweens";
         tween._action = function():void
         {
            var _loc5_:* = null;
            var _loc3_:* = null;
            container = Util24.array.compressAndClean(container);
            var _loc11_:int = 0;
            var _loc10_:* = container;
            for each(var _loc4_ in container)
            {
               _loc5_ = Util24.display.getAllChildren(_loc4_);
               var _loc9_:int = 0;
               var _loc8_:* = _loc5_;
               for each(var _loc2_ in _loc5_)
               {
                  _loc3_ = getTweenArrayByTarget(_loc2_);
                  var _loc7_:int = 0;
                  var _loc6_:* = _loc3_;
                  for each(var _loc1_ in _loc3_)
                  {
                     _loc1_.pause();
                  }
               }
            }
         };
         return tween;
      }
      
      public static function resumeChildTweens(... rest) : Tween24
      {
         container = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "resumeChildTweens";
         tween._action = function():void
         {
            var _loc5_:* = null;
            var _loc3_:* = null;
            container = Util24.array.compressAndClean(container);
            var _loc11_:int = 0;
            var _loc10_:* = container;
            for each(var _loc4_ in container)
            {
               _loc5_ = Util24.display.getAllChildren(_loc4_);
               var _loc9_:int = 0;
               var _loc8_:* = _loc5_;
               for each(var _loc2_ in _loc5_)
               {
                  _loc3_ = getTweenArrayByTarget(_loc2_);
                  var _loc7_:int = 0;
                  var _loc6_:* = _loc3_;
                  for each(var _loc1_ in _loc3_)
                  {
                     if(_loc1_.pausing)
                     {
                        _loc1_.play2();
                     }
                  }
               }
            }
         };
         return tween;
      }
      
      public static function skipChildTweens(... rest) : Tween24
      {
         container = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "skipChildTweens";
         tween._action = function():void
         {
            var _loc3_:int = 0;
            var _loc2_:* = getAllChildrenTweens(container);
            for each(var _loc1_ in getAllChildrenTweens(container))
            {
               _loc1_.skip();
            }
         };
         return tween;
      }
      
      public static function stopChildTweens(... rest) : Tween24
      {
         container = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "stopChildTweens";
         tween._action = function():void
         {
            var _loc5_:* = null;
            var _loc3_:* = null;
            container = Util24.array.compressAndClean(container);
            var _loc11_:int = 0;
            var _loc10_:* = container;
            for each(var _loc4_ in container)
            {
               _loc5_ = Util24.display.getAllChildren(_loc4_);
               var _loc9_:int = 0;
               var _loc8_:* = _loc5_;
               for each(var _loc2_ in _loc5_)
               {
                  _loc3_ = getTweenArrayByTarget(_loc2_);
                  var _loc7_:int = 0;
                  var _loc6_:* = _loc3_;
                  for each(var _loc1_ in _loc3_)
                  {
                     _loc1_.stop();
                  }
               }
            }
         };
         return tween;
      }
      
      private static function getAllChildrenTweens(param1:Array) : Array
      {
         var _loc4_:* = null;
         param1 = Util24.array.compressAndClean(param1);
         var _loc3_:Array = [];
         var _loc2_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc5_ in param1)
         {
            _loc4_ = getChildrenTween(_loc5_);
            if(_loc4_)
            {
               _loc3_.push(_loc4_);
            }
         }
         _loc2_ = _loc2_.concat.apply(_loc2_,_loc3_);
         return !!_loc2_.length?_loc2_:null;
      }
      
      private static function getChildrenTween(param1:DisplayObjectContainer) : Array
      {
         var _loc6_:* = null;
         var _loc5_:Array = [];
         var _loc2_:Array = [];
         var _loc4_:Array = Util24.display.getAllChildren(param1);
         var _loc8_:int = 0;
         var _loc7_:* = _loc4_;
         for each(var _loc3_ in _loc4_)
         {
            if(_loc3_ is DisplayObjectContainer)
            {
               _loc6_ = getChildrenTween(_loc3_ as DisplayObjectContainer);
            }
            else
            {
               _loc6_ = getTweenArrayByTarget(_loc3_);
            }
            if(_loc6_)
            {
               _loc5_.push(_loc6_);
            }
         }
         _loc6_ = getTweenArrayByTarget(param1);
         if(_loc6_)
         {
            _loc5_.push(_loc6_);
         }
         _loc2_ = _loc2_.concat.apply(_loc2_,_loc5_);
         return _loc2_;
      }
      
      public static function playByArray(... rest) : Tween24
      {
         return getControlTween("playByArray",Util24.array.compressAndClean(rest),"play");
      }
      
      public static function pauseByArray(... rest) : Tween24
      {
         return getControlTween("pauseByArray",Util24.array.compressAndClean(rest),"pause");
      }
      
      public static function skipByArray(... rest) : Tween24
      {
         return getControlTween("skipByArray",Util24.array.compressAndClean(rest),"skip");
      }
      
      public static function stopByArray(... rest) : Tween24
      {
         return getControlTween("stopByArray",Util24.array.compressAndClean(rest),"stop");
      }
      
      public static function setGlobalTimeScaleByArray(param1:Number, ... rest) : Tween24
      {
         return getControlTween("setGlobalTimeScaleByArray",Util24.array.compressAndClean(rest),"setTimeScale",param1);
      }
      
      public static function manualPlayByArray(... rest) : Tween24
      {
         return getControlTween("manualPlayByArray",Util24.array.compressAndClean(rest),"manualPlay");
      }
      
      public static function manualUpdateByArray(... rest) : Tween24
      {
         return getControlTween("manualUpdateByArray",Util24.array.compressAndClean(rest),"manualUpdate");
      }
      
      public static function pauseAllTweens() : Tween24
      {
         var tween:Tween24 = new Tween24();
         tween._type = "pauseAllTweens";
         tween._actionName = "pauseAllTweens";
         tween._action = function():void
         {
            eachFuncInPlayingTweens("pause");
         };
         return tween;
      }
      
      public static function resumeAllTweens() : Tween24
      {
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "resumeAllTweens";
         tween._action = function():void
         {
            eachFuncInPausingTweens("play2");
         };
         return tween;
      }
      
      public static function skipAllTweens() : Tween24
      {
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "skipAllTweens";
         tween._action = function():void
         {
            eachFuncInPlayingTweens("skip");
            eachFuncInPausingTweens("skip");
         };
         return tween;
      }
      
      public static function stopAllTweens() : Tween24
      {
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "stopAllTweens";
         tween._action = function():void
         {
            eachFuncInPlayingTweens("stop");
            eachFuncInPausingTweens("stop");
         };
         return tween;
      }
      
      public static function manualUpdateAllTweens(param1:uint = 1) : Tween24
      {
         num = param1;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "manualUpdateAllTweens";
         tween._action = function():void
         {
            var _loc3_:int = 0;
            var _loc2_:* = _manualTweens;
            for each(var _loc1_ in _manualTweens)
            {
               _loc1_.manualUpdate(num);
            }
         };
         return tween;
      }
      
      public static function skipCountAllManualTweens(param1:uint = 1) : Tween24
      {
         num = param1;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "skipCountAllManualTweens";
         tween._action = function():void
         {
            var _loc3_:int = 0;
            var _loc2_:* = _manualTweens;
            for each(var _loc1_ in _manualTweens)
            {
               _loc1_.skipCount(num);
            }
         };
         return tween;
      }
      
      public static function getTweenById(param1:String) : Tween24
      {
         return _tweensById[param1];
      }
      
      public static function getTweenArrayById(... rest) : Array
      {
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = rest;
         for each(var _loc3_ in rest)
         {
            _loc2_.push(_tweensById[_loc3_]);
         }
         return Util24.array.clean(_loc2_);
      }
      
      public static function getGroupTween(param1:String) : Tween24
      {
         return parallel.apply(parallel,_tweensByGroup[param1]);
      }
      
      public static function getTweenArrayByGroup(... rest) : Array
      {
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = rest;
         for each(var _loc3_ in rest)
         {
            _loc2_ = _loc2_.concat(_tweensByGroup[_loc3_]);
         }
         return Util24.array.clean(_loc2_);
      }
      
      public static function getPlayingTweenArrayByTarget(... rest) : Array
      {
         var _loc2_:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = rest;
         for each(var _loc3_ in rest)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _playingTweensByTarget[_loc3_];
            for each(var _loc4_ in _playingTweensByTarget[_loc3_])
            {
               _loc2_.push(_loc4_);
            }
         }
         return !!_loc2_.length?Util24.array.clean(_loc2_):null;
      }
      
      public static function getPausingTweenArrayByTarget(... rest) : Array
      {
         var _loc2_:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = rest;
         for each(var _loc3_ in rest)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _pausingTweensByTarget[_loc3_];
            for each(var _loc4_ in _pausingTweensByTarget[_loc3_])
            {
               _loc2_.push(_loc4_);
            }
         }
         return !!_loc2_.length?Util24.array.clean(_loc2_):null;
      }
      
      private static function getTweenArrayByTarget(... rest) : Array
      {
         var _loc4_:* = null;
         var _loc2_:Array = [];
         var _loc10_:int = 0;
         var _loc9_:* = rest;
         for each(var _loc3_ in rest)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _playingTweensByTarget[_loc3_];
            for each(_loc4_ in _playingTweensByTarget[_loc3_])
            {
               _loc2_.push(_loc4_);
            }
            var _loc8_:int = 0;
            var _loc7_:* = _pausingTweensByTarget[_loc3_];
            for each(_loc4_ in _pausingTweensByTarget[_loc3_])
            {
               _loc2_.push(_loc4_);
            }
         }
         return !!_loc2_.length?Util24.array.clean(_loc2_):null;
      }
      
      public static function addChild(param1:DisplayObjectContainer, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = "action";
         _loc3_._actionName = "addChild";
         return setSyncAddTween(_loc3_,rest,Util24.display.addChild,param1,Util24.array.compressAndClean(rest));
      }
      
      public static function addChildAt(param1:DisplayObjectContainer, param2:DisplayObject, param3:int) : Tween24
      {
         var _loc4_:Tween24 = new Tween24();
         _loc4_._type = "action";
         _loc4_._actionName = "addChildAt";
         return setSyncAddTween(_loc4_,[param2],Util24.display.addChildAt,param1,param2,param3);
      }
      
      public static function addChildAtFront(param1:DisplayObject, param2:DisplayObject) : Tween24
      {
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = "action";
         _loc3_._actionName = "addChildAtFront";
         return setSyncAddTween(_loc3_,[param1],Util24.display.addChildAtFront,param1,param2);
      }
      
      public static function addChildAtBack(param1:DisplayObject, param2:DisplayObject) : Tween24
      {
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = "action";
         _loc3_._actionName = "addChildAtBack";
         return setSyncAddTween(_loc3_,[param1],Util24.display.addChildAtBack,param1,param2);
      }
      
      private static function setSyncAddTween(param1:Tween24, param2:Array, param3:Function, ... rest) : Tween24
      {
         tween = param1;
         children = param2;
         func = param3;
         args = rest;
         tween.addEventListener("init",function():void
         {
            arguments = arguments;
            tween.removeEventListener("init",arguments.callee);
            children = Util24.array.compressAndClean(children);
            var _loc4_:int = 0;
            var _loc3_:* = children;
            for each(child in children)
            {
               var eventTween:EventTween24 = EventTween24.hasInstance(child);
               var syncTween:Tween24 = !!eventTween?eventTween.addChildSyncTween:null;
               if(syncTween)
               {
                  if(!syncTweens)
                  {
                     syncTweens = [];
                  }
                  syncTweens.push(syncTween);
               }
            }
            if(syncTweens)
            {
               var waitTween:Tween24 = parallel.apply(parallel,syncTweens);
               waitTween._dispatchComplete = true;
               tween._dispatcher = waitTween.getDispatcher();
               tween._eventType = "complete";
            }
            tween._action = function():void
            {
               func.apply(func,args);
               if(waitTween)
               {
                  waitTween.play();
               }
            };
         });
         return tween;
      }
      
      public static function removeChild(... rest) : Tween24
      {
         var _loc2_:Tween24 = new Tween24();
         _loc2_._type = "action";
         _loc2_._actionName = "removeChild";
         return setSyncRemoveTween(_loc2_,Util24.array.compressAndClean(rest));
      }
      
      public static function removeChildByName(param1:DisplayObjectContainer, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = "action";
         _loc3_._actionName = "removeChildByName";
         return setSyncRemoveTween(_loc3_,null,Util24.display.getChildrenByName,param1,Util24.array.compressAndClean(rest));
      }
      
      public static function removeChildAt(param1:DisplayObjectContainer, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = "action";
         _loc3_._actionName = "removeChildAt";
         return setSyncRemoveTween(_loc3_,null,Util24.display.getChildrenAt,param1,Util24.array.compressAndClean(rest));
      }
      
      public static function removeAllChildren(... rest) : Tween24
      {
         var _loc2_:Tween24 = new Tween24();
         _loc2_._type = "action";
         _loc2_._actionName = "removeAllChildren";
         return setSyncRemoveTween(_loc2_,null,Util24.display.getAllChildren,rest);
      }
      
      private static function setSyncRemoveTween(param1:Tween24, param2:Array, param3:Function = null, ... rest) : Tween24
      {
         tween = param1;
         children = param2;
         getChildFunc = param3;
         args = rest;
         tween.addEventListener("init",function():void
         {
            arguments = arguments;
            tween.removeEventListener("init",arguments.callee);
            if(!children)
            {
               children = getChildFunc.apply(getChildFunc,args);
            }
            children = Util24.array.compressAndClean(children);
            var _loc4_:int = 0;
            var _loc3_:* = children;
            for each(child in children)
            {
               var eventTween:EventTween24 = EventTween24.hasInstance(child);
               var syncTween:Tween24 = !!eventTween?eventTween.removeChildSyncTween:null;
               if(syncTween)
               {
                  if(!syncTweens)
                  {
                     syncTweens = [];
                  }
                  syncTweens.push(syncTween);
                  syncTween.addEventListener("complete",function():void
                  {
                     Util24.display.removeChild(child);
                     syncTween.removeEventListener("complete",arguments.callee);
                  });
               }
            }
            if(syncTweens)
            {
               var waitTween:Tween24 = parallel.apply(parallel,syncTweens);
               waitTween._dispatchComplete = true;
               tween._dispatcher = waitTween.getDispatcher();
               tween._eventType = "complete";
            }
            tween._action = function():void
            {
               if(waitTween)
               {
                  waitTween.play();
               }
               else
               {
                  Util24.display.removeChild(children);
               }
            };
         });
         return tween;
      }
      
      public static function setFrontChild(param1:DisplayObject) : Tween24
      {
         child = param1;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "swapFrontChild";
         tween._action = function():void
         {
            Util24.display.setFrontChild(child);
         };
         return tween;
      }
      
      public static function setChildIndex(param1:DisplayObject, param2:int) : Tween24
      {
         child = param1;
         index = param2;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "swapChildIndex";
         tween._action = function():void
         {
            Util24.display.setChildIndex(child,index);
         };
         return tween;
      }
      
      public static function removeFilters(... rest) : Tween24
      {
         target = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "removeFilters";
         tween._action = function():void
         {
            Util24.display.removeFilters(target);
         };
         return tween;
      }
      
      public static function visible(param1:Boolean, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(Util24.array.compressAndClean(rest));
         _loc3_._type = "prop";
         _loc3_._actionName = "visible";
         _loc3_.visible(param1);
         return _loc3_;
      }
      
      public static function gotoAndPlay(param1:*, ... rest) : Tween24
      {
         frame = param1;
         target = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "gotoAndPlay";
         tween._action = function():void
         {
            Util24.timeline.gotoAndPlay(frame,Util24.array.compress(target));
         };
         return tween;
      }
      
      public static function gotoAndStop(param1:*, ... rest) : Tween24
      {
         frame = param1;
         target = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "gotoAndStop";
         tween._action = function():void
         {
            Util24.timeline.gotoAndStop(frame,Util24.array.compress(target));
         };
         return tween;
      }
      
      public static function addMask(param1:DisplayObject, param2:DisplayObject) : Tween24
      {
         target = param1;
         masker = param2;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "addMask";
         tween._action = function():void
         {
            Util24.display.addMask(target,masker);
         };
         return tween;
      }
      
      public static function removeMask(param1:DisplayObject) : Tween24
      {
         target = param1;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "removeMask";
         tween._action = function():void
         {
            Util24.display.removeMask(target);
         };
         return tween;
      }
      
      public static function func(param1:Function, ... rest) : Tween24
      {
         func = param1;
         args = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "func";
         tween._actionName = "func";
         tween._action = function():void
         {
            func.apply(func,args);
         };
         return tween;
      }
      
      public static function funcAndWaitEvent(param1:IEventDispatcher, param2:String, param3:Function, ... rest) : Tween24
      {
         dispatcher = param1;
         eventType = param2;
         func = param3;
         args = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "funcAndWait";
         tween._actionName = "funcAndWaitEvent";
         tween._action = function():void
         {
            func.apply(func,args);
         };
         tween._dispatcher = dispatcher;
         tween._eventType = eventType;
         return tween;
      }
      
      public static function wait(param1:Number) : Tween24
      {
         var _loc2_:Tween24 = new Tween24(null,param1);
         _loc2_._type = "wait";
         _loc2_._actionName = "wait";
         return _loc2_;
      }
      
      public static function waitEvent(param1:IEventDispatcher, param2:String) : Tween24
      {
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = "waitEvent";
         _loc3_._actionName = "waitEvent";
         _loc3_._dispatcher = param1;
         _loc3_._eventType = param2;
         return _loc3_;
      }
      
      public static function mouseEnabled(param1:Boolean, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(Util24.array.compressAndClean(rest));
         _loc3_._type = "prop";
         _loc3_._actionName = "mouseEnabled";
         _loc3_.addParam("mouseEnabled",param1);
         return _loc3_;
      }
      
      public static function mouseChildren(param1:Boolean, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(Util24.array.compressAndClean(rest));
         _loc3_._type = "prop";
         _loc3_._actionName = "mouseChildren";
         _loc3_.addParam("mouseChildren",param1);
         return _loc3_;
      }
      
      public static function buttonEnabled(param1:Boolean, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(Util24.array.compressAndClean(rest));
         _loc3_._type = "prop";
         _loc3_._actionName = "buttonEnabled";
         _loc3_.addParam("mouseEnabled",param1);
         _loc3_.addParam("mouseChildren",param1);
         return _loc3_;
      }
      
      public static function buttonMode(param1:Boolean, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(Util24.array.compressAndClean(rest));
         _loc3_._type = "prop";
         _loc3_._actionName = "buttonMode";
         _loc3_.addParam("buttonMode",param1);
         return _loc3_;
      }
      
      public static function blendMode(param1:String, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(Util24.array.compressAndClean(rest));
         _loc3_._type = "prop";
         _loc3_._actionName = "blendMode";
         _loc3_.setDisplayObjectUpdater("blendMode",param1);
         return _loc3_;
      }
      
      public static function traceLog(... rest) : Tween24
      {
         messages = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "traceLog";
         tween._action = function():void
         {
            trace.apply(trace,messages);
         };
         return tween;
      }
      
      public static function traceProp(param1:Object, param2:String, ... rest) : Tween24
      {
         target = param1;
         label = param2;
         propNames = rest;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "traceProp";
         tween._action = function():void
         {
            var _loc4_:int = 0;
            var _loc3_:* = null;
            var _loc1_:String = " [";
            var _loc2_:int = propNames.length;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = propNames[_loc4_];
               _loc1_ = _loc1_ + (_loc3_ + ":" + target[_loc3_] + ", ");
               _loc4_++;
            }
         };
         return tween;
      }
      
      public static function jump(param1:Number) : Tween24
      {
         var _loc2_:Tween24 = new Tween24(null,param1).jump();
         _loc2_._type = "jump";
         _loc2_._actionName = "jump";
         return _loc2_;
      }
      
      public static function eventDispatch(param1:IEventDispatcher, param2:Event) : Tween24
      {
         target = param1;
         event = param2;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "eventDispatch";
         tween._action = function():void
         {
            target.dispatchEvent(event);
         };
         return tween;
      }
      
      public static function getURL(param1:String, param2:String = "_self") : Tween24
      {
         url = param1;
         window = param2;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "getURL";
         tween._action = function():void
         {
         };
         return tween;
      }
      
      public static function setFocus(param1:InteractiveObject) : Tween24
      {
         target = param1;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "setFocus";
         tween._action = function():void
         {
            var _loc1_:* = null;
            if(target.stage)
            {
               target.stage.focus = target;
               if(target is TextField)
               {
                  _loc1_ = target as TextField;
                  _loc1_.setSelection(_loc1_.length,_loc1_.length);
               }
            }
         };
         return tween;
      }
      
      public static function stageQuality(param1:Stage, param2:String) : Tween24
      {
         stage = param1;
         quality = param2;
         _stage = stage || _stage;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "stageQuality";
         tween._action = function():void
         {
            if(_stage)
            {
               _stage.quality = quality;
            }
         };
         return tween;
      }
      
      public static function changeGlobalTimeScale(param1:Number) : Tween24
      {
         scale = param1;
         var tween:Tween24 = new Tween24();
         tween._type = "action";
         tween._actionName = "changeGlobalTimeScale";
         tween._action = function():void
         {
            globalTimeScale = scale;
         };
         return tween;
      }
      
      private static function startEngine() : void
      {
         _runing = true;
         _engine.addEventListener("enterFrame",rendering);
      }
      
      private static function stopEngine() : void
      {
         _runing = false;
         _engine.removeEventListener("enterFrame",rendering);
      }
      
      private static function rendering(param1:Event = null) : void
      {
         var _loc2_:* = null;
         if(!_firstTween)
         {
            _endTween = null;
            stopEngine();
            return;
         }
         _loc2_ = _firstTween;
         var _loc3_:Tween24 = _loc2_._nextList;
         _nowTime = getTimer();
         do
         {
            _loc3_ = _loc2_._nextList;
            _loc2_.update();
            _loc2_ = _loc3_;
         }
         while(_loc2_ != null);
         
      }
      
      private static function removeFromDictionaryInDictionary(param1:Dictionary, param2:*, param3:*) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:Dictionary = param1[param2];
         if(_loc5_)
         {
            delete _loc5_[param3];
         }
         var _loc8_:int = 0;
         var _loc7_:* = _loc5_;
         for(var _loc6_ in _loc5_)
         {
            _loc4_ = true;
         }
         if(!_loc4_)
         {
            delete param1[param2];
         }
      }
      
      private static function replacePlugin(param1:Array) : Array
      {
         param1 = Util24.array.compressAndClean(param1);
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            if(_loc3_ is PulginTween24)
            {
               _loc2_.push(PulginTween24(_loc3_).getTween24());
            }
            else if(_loc3_ is Function)
            {
               _loc2_.push(Tween24.func(_loc3_));
            }
            else
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private static function clone(param1:Object) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function get ease() : Ease24
      {
         return _ease;
      }
      
      public static function get defaultEasing() : Function
      {
         return _defaultEasing;
      }
      
      public static function set defaultEasing(param1:Function) : void
      {
         _defaultEasing = param1;
      }
      
      public static function get globalTimeScale() : Number
      {
         return _globalTimeScale;
      }
      
      public static function set globalTimeScale(param1:Number) : void
      {
         _globalTimeScale = param1;
         eachFuncInPlayingTweens("updateTime");
      }
      
      public static function get plugin() : PluginProxy
      {
         return _plugin;
      }
      
      public static function get aligin() : Align24
      {
         return _aligin;
      }
      
      public static function get debugMode() : Boolean
      {
         return _debugMode;
      }
      
      public static function set debugMode(param1:Boolean) : void
      {
         _debugMode = param1;
      }
      
      public function play(param1:Boolean = false) : void
      {
         _isDebug = param1;
         _rootTween = this;
         _parentTween = null;
         if(_pluginProperty)
         {
            _pluginProperty.atPlay();
         }
         if(!_firstTween)
         {
            _nowTime = getTimer();
         }
         play2();
      }
      
      public function manualPlay() : void
      {
         if(_playing)
         {
            return;
         }
         _isManual = true;
         _manualPlayId = _numTotalManualTween;
         _manualTweens[_manualPlayId] = this;
         _numTotalManualTween = Number(_numTotalManualTween) + 1;
         play();
      }
      
      private function play2() : void
      {
         if(_playing)
         {
            stop2();
         }
         if(!_pausing)
         {
            _numCompleteChildren = 0;
         }
         _playing = true;
         _skipped = false;
         _completed = false;
         _numPlayingTween = Number(_numPlayingTween) + 1;
         _numPlayedTween = Number(_numPlayedTween) + 1;
         if(!_rootTween)
         {
            _level = 0;
            if(_parentTween)
            {
               _rootTween = _parentTween._rootTween || _parentTween;
            }
         }
         if(_targetSingle)
         {
            var _loc4_:* = _targetSingle;
            _playingTweensByTarget[_loc4_] = _playingTweensByTarget[_loc4_] || new Dictionary();
            _playingTweensByTarget[_targetSingle][_uniqueId] = this;
         }
         else
         {
            var _loc6_:int = 0;
            var _loc5_:* = _target;
            for each(var _loc3_ in _target)
            {
               _loc4_ = _loc3_;
               _playingTweensByTarget[_loc4_] = _playingTweensByTarget[_loc4_] || new Dictionary();
               _playingTweensByTarget[_loc3_][_uniqueId] = this;
            }
         }
         if(_parentTween)
         {
            _level = _parentTween._level + 1;
            _parentTween._playingChildTweens = _parentTween._playingChildTweens || new Dictionary();
            _parentTween._playingChildTweens[_uniqueId] = this;
         }
         if(_pausing)
         {
            _pausing = false;
            delete _pausingAllTweens[this];
            if(_pausingChildTweens)
            {
               var _loc8_:int = 0;
               var _loc7_:* = _pausingChildTweens;
               for each(var _loc2_ in _pausingChildTweens)
               {
                  if(_loc2_ != this)
                  {
                     _loc2_.play2();
                     delete _pausingChildTweens[_loc2_._uniqueId];
                  }
               }
            }
            if(_targetSingle)
            {
               removeFromDictionaryInDictionary(_pausingTweensByTarget,_targetSingle,_uniqueId);
            }
            else
            {
               var _loc10_:int = 0;
               var _loc9_:* = _target;
               for each(var _loc1_ in _target)
               {
                  removeFromDictionaryInDictionary(_pausingTweensByTarget,_loc1_,_uniqueId);
               }
            }
         }
         if(!_rootTween._isManual && this == _rootTween)
         {
            if(!_firstTween)
            {
               _firstTween = this;
            }
            _prevList = _endTween;
            if(_endTween && _endTween != this)
            {
               _endTween._nextList = this;
            }
            _endTween = this;
         }
         updateTime();
         updateEventTrigger();
         if(debugMode || _rootTween._isDebug)
         {
            debugTrace("play");
         }
         if(_onPlay != null)
         {
            if(_onPlayArgs)
            {
               _onPlay.apply(_onPlay,_onPlayArgs);
            }
            else
            {
               _onPlay();
            }
         }
         if(_dispatchPlay)
         {
            _eventDispatcher.dispatchEvent(new Tween24Event(this,"play"));
         }
         if(_rootTween._isManual)
         {
            if(_type != "tween" && _type != "tweenFunc" && _type != "tweenCount" && _type != "wait" && _type != "waitCount")
            {
               update();
            }
         }
         else if(_type != "tweenCount" && _type != "funcCount" && _type != "waitCount")
         {
            update();
         }
         if(!_runing)
         {
            startEngine();
         }
      }
      
      private function updateTime() : void
      {
         _totalTimeScale = _timeScale;
         if(_parentTween)
         {
            _totalTimeScale = _totalTimeScale * _parentTween._totalTimeScale;
         }
         var _loc2_:Number = _totalTimeScale * _globalTimeScale;
         var _loc3_:Number = _delayTime * (1 - _progressDelay) * 1000 * _loc2_;
         var _loc4_:* = _type;
         if("tween" !== _loc4_)
         {
            if("prop" !== _loc4_)
            {
               if("tweenFunc" !== _loc4_)
               {
                  if("wait" !== _loc4_)
                  {
                     if("jump" !== _loc4_)
                     {
                        if("serial" !== _loc4_)
                        {
                           if("loop" !== _loc4_)
                           {
                              if("parallel" !== _loc4_)
                              {
                                 if("randome" !== _loc4_)
                                 {
                                    _startTime = _nowTime + _loc3_;
                                    _completeTime = 0;
                                 }
                              }
                              addr61:
                              _startTime = _nowTime + _loc3_;
                              _completeTime = 0;
                           }
                           addr60:
                           §§goto(addr61);
                        }
                        §§goto(addr60);
                     }
                     addr113:
                     if(_playingChildTweens)
                     {
                        var _loc6_:int = 0;
                        var _loc5_:* = _playingChildTweens;
                        for each(var _loc1_ in _playingChildTweens)
                        {
                           _loc1_.updateTime();
                        }
                     }
                     return;
                  }
                  addr38:
                  _completeTime = _time * 1000 * _loc2_;
                  _startTime = _nowTime + _loc3_ - _completeTime * _progress;
                  §§goto(addr113);
               }
               addr37:
               §§goto(addr38);
            }
            addr36:
            §§goto(addr37);
         }
         §§goto(addr36);
      }
      
      public function pause() : void
      {
         if(!_playing)
         {
            return;
         }
         if(_rootTween == this)
         {
            removeFromLinkedList();
         }
         pause2();
      }
      
      private function pause2() : void
      {
         if(_type == "pauseAllTweens")
         {
            return;
         }
         _numPlayingTween = Number(_numPlayingTween) - 1;
         _playing = false;
         _pausing = true;
         if(_rootTween != this)
         {
            delete _parentTween._playingChildTweens[_uniqueId];
            _parentTween._pausingChildTweens = _parentTween._pausingChildTweens || new Dictionary();
            _parentTween._pausingChildTweens[_uniqueId] = this;
         }
         if(_playingChildTweens)
         {
            var _loc4_:* = 0;
            var _loc3_:* = _playingChildTweens;
            for each(var _loc1_ in _playingChildTweens)
            {
               _loc1_.pause2();
            }
         }
         if(_targetSingle)
         {
            removeFromDictionaryInDictionary(_playingTweensByTarget,_targetSingle,_uniqueId);
            _loc4_ = _targetSingle;
            _pausingTweensByTarget[_loc4_] = _pausingTweensByTarget[_loc4_] || new Dictionary();
            _pausingTweensByTarget[_targetSingle][_uniqueId] = this;
         }
         else if(_target)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _target;
            for each(var _loc2_ in _target)
            {
               removeFromDictionaryInDictionary(_playingTweensByTarget,_loc2_,_uniqueId);
               _loc3_ = _loc2_;
               _pausingTweensByTarget[_loc3_] = _pausingTweensByTarget[_loc3_] || new Dictionary();
               _pausingTweensByTarget[_loc2_][_uniqueId] = this;
            }
         }
         _pausingAllTweens[this] = this;
         if(_pluginProperty)
         {
            _pluginProperty.atPause();
         }
         if(_onPause != null)
         {
            if(_onPauseArgs)
            {
               _onPause.apply(_onPause,_onPauseArgs);
            }
            else
            {
               _onPause();
            }
         }
         if(_dispatchPause)
         {
            _eventDispatcher.dispatchEvent(new Tween24Event(this,"pause"));
         }
      }
      
      public function stop() : void
      {
         stop2();
         if(_pluginProperty)
         {
            _pluginProperty.atStop();
         }
         if(_onStop != null)
         {
            if(_onStopArgs)
            {
               _onStop.apply(_onStop,_onStopArgs);
            }
            else
            {
               _onStop();
            }
         }
         if(_dispatchStop)
         {
            _eventDispatcher.dispatchEvent(new Tween24Event(this,"stop"));
         }
      }
      
      private function stop2() : void
      {
         removeTweens();
         if(this == _rootTween)
         {
            stopByDictionary(_playingChildTweens);
            stopByDictionary(_pausingChildTweens);
         }
      }
      
      private function stopByDictionary(param1:Dictionary) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc2_.stop2();
         }
      }
      
      public function skip() : void
      {
         _skipped = true;
         update();
      }
      
      public function skipCount(param1:uint = 1) : void
      {
         if(_isManual)
         {
            if(_delayCount)
            {
               if(_delayCurrentCount != _delayCount)
               {
                  _delayCurrentCount = _delayCurrentCount + param1;
                  if(_delayCurrentCount > _delayCount)
                  {
                     _currentCount = _currentCount + (_delayCurrentCount - _delayCount);
                     _delayCurrentCount = _delayCount;
                  }
               }
               else
               {
                  _currentCount = _currentCount + param1;
               }
            }
            else
            {
               _currentCount = _currentCount + param1;
            }
         }
      }
      
      public function setTimeScale(param1:Number) : void
      {
         _timeScale = param1;
         updateTime();
      }
      
      private function removeTweens() : void
      {
         _numPlayingTween = Number(_numPlayingTween) - 1;
         if(_isManual)
         {
            delete _manualTweens[_manualPlayId];
         }
         _isManual = false;
         _nextTweenPlayed = false;
         _actioned = false;
         _pausing = false;
         _inited = false;
         _playing = false;
         _played = false;
         _progressDelay = 0;
         _progress = 0;
         _currentCount = 0;
         _delayCurrentCount = 0;
         if(_dispatcher)
         {
            _dispatcher.removeEventListener(_eventType,funcComplete);
         }
         if(_targetSingle)
         {
            removeFromDictionaryInDictionary(_playingTweensByTarget,_targetSingle,_uniqueId);
            removeFromDictionaryInDictionary(_pausingTweensByTarget,_targetSingle,_uniqueId);
         }
         else
         {
            var _loc3_:int = 0;
            var _loc2_:* = _target;
            for each(var _loc1_ in _target)
            {
               removeFromDictionaryInDictionary(_playingTweensByTarget,_loc1_,_uniqueId);
               removeFromDictionaryInDictionary(_pausingTweensByTarget,_loc1_,_uniqueId);
            }
         }
         if(_rootTween == this)
         {
            removeFromLinkedList();
         }
         else if(_parentTween)
         {
            delete _parentTween._playingChildTweens[_uniqueId];
         }
      }
      
      private function removeFromLinkedList() : void
      {
         if(_prevList)
         {
            _prevList._nextList = _nextList;
         }
         if(_nextList)
         {
            _nextList._prevList = _prevList;
         }
         if(_firstTween == this)
         {
            _firstTween = _nextList;
         }
         if(_endTween == this)
         {
            _endTween = _prevList;
         }
         _nextList = null;
         _prevList = null;
      }
      
      private function initParams() : void
      {
         initParams2 = function(param1:Object):void
         {
            var _loc8_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc3_:* = null;
            var _loc7_:* = null;
            var _loc6_:* = null;
            if(_displayUpdater)
            {
               _displayUpdater.init();
            }
            else if(_displayUpdaters)
            {
               _displayUpdaters[param1].init();
            }
            if(_objectUpdater)
            {
               _objectUpdater.init();
            }
            else if(_objectUpdaters)
            {
               _objectUpdaters[param1].init();
            }
            if(_isFilter)
            {
               if(param1 is DisplayObject)
               {
                  _loc8_ = param1.filters;
                  if(_loc8_)
                  {
                     var _loc10_:int = 0;
                     var _loc9_:* = _loc8_;
                     for each(var _loc2_ in _loc8_)
                     {
                        if(_loc2_ is BlurFilter)
                        {
                           _loc4_ = _loc2_ as BlurFilter;
                        }
                        else if(_loc2_ is GlowFilter)
                        {
                           _loc5_ = _loc2_ as GlowFilter;
                        }
                        else if(_loc2_ is DropShadowFilter)
                        {
                           _loc3_ = _loc2_ as DropShadowFilter;
                        }
                        else if(_loc2_ is ColorMatrixFilter)
                        {
                           _loc7_ = _loc2_ as ColorMatrixFilter;
                        }
                        else if(_loc2_ is ConvolutionFilter)
                        {
                           _loc6_ = _loc2_ as ConvolutionFilter;
                        }
                     }
                  }
                  if(_targetSingle)
                  {
                     if(_blurUpdater)
                     {
                        _blurUpdater.init(_targetSingle,_loc4_ || new BlurFilter(0,0,1));
                     }
                     if(_glowUpdater)
                     {
                        _glowUpdater.init(_targetSingle,_loc5_ || new GlowFilter(0));
                     }
                     if(_dropShadowUpdater)
                     {
                        _dropShadowUpdater.init(_targetSingle,_loc3_ || new DropShadowFilter());
                     }
                     if(_sharpUpdater)
                     {
                        _sharpUpdater.init(_targetSingle,_loc6_ || new ConvolutionFilter());
                     }
                     if(_saturationUpdater)
                     {
                        _saturationUpdater.init(_targetSingle,_loc7_ || new ColorMatrixFilter());
                     }
                  }
                  else
                  {
                     if(_blurUpdater)
                     {
                        if(!_blurUpdaters)
                        {
                           _blurUpdaters = new Dictionary();
                        }
                        _blurUpdaters[param1] = _blurUpdater.clone().init(param1,_loc4_ || new BlurFilter(0,0,1));
                     }
                     if(_glowUpdater)
                     {
                        if(!_glowUpdaters)
                        {
                           _glowUpdaters = new Dictionary();
                        }
                        _glowUpdaters[param1] = _glowUpdater.clone().init(param1,_loc5_ || new GlowFilter(0));
                     }
                     if(_dropShadowUpdater)
                     {
                        if(!_dropShadowUpdaters)
                        {
                           _dropShadowUpdaters = new Dictionary();
                        }
                        _dropShadowUpdaters[param1] = _dropShadowUpdater.clone().init(param1,_loc3_ || new DropShadowFilter());
                     }
                     if(_saturationUpdater)
                     {
                        if(!_saturationUpdaters)
                        {
                           _saturationUpdaters = new Dictionary();
                        }
                        _saturationUpdaters[param1] = _saturationUpdater.clone().init(param1,_loc7_ || new ColorMatrixFilter());
                     }
                     if(_sharpUpdater)
                     {
                        if(!_sharpUpdaters)
                        {
                           _sharpUpdaters = new Dictionary();
                        }
                        _sharpUpdaters[param1] = _sharpUpdater.clone().init(param1,_loc6_ || new ConvolutionFilter());
                     }
                  }
               }
               if(param1 is DisplayObject)
               {
                  if(_targetSingle)
                  {
                     if(_brightUpdater)
                     {
                        _brightUpdater.init(_targetSingle as DisplayObject);
                     }
                     if(_contrastUpdater)
                     {
                        _contrastUpdater.init(_targetSingle as DisplayObject);
                     }
                     if(_colorUpdater)
                     {
                        _colorUpdater.init(_targetSingle as DisplayObject);
                     }
                     if(_colorReversalUpdater)
                     {
                        _colorReversalUpdater.init(_targetSingle as DisplayObject);
                     }
                     if(_timelineUpdater)
                     {
                        _timelineUpdater.init(_targetSingle as MovieClip);
                     }
                  }
                  else
                  {
                     if(_brightUpdater)
                     {
                        if(!_brightUpdaters)
                        {
                           _brightUpdaters = new Dictionary();
                        }
                        _brightUpdaters[param1] = _brightUpdater.clone().init(param1 as DisplayObject);
                     }
                     if(_contrastUpdater)
                     {
                        if(!_contrastUpdaters)
                        {
                           _contrastUpdaters = new Dictionary();
                        }
                        _contrastUpdaters[param1] = _contrastUpdater.clone().init(param1 as DisplayObject);
                     }
                     if(_colorUpdater)
                     {
                        if(!_colorUpdaters)
                        {
                           _colorUpdaters = new Dictionary();
                        }
                        _colorUpdaters[param1] = _colorUpdater.clone().init(param1 as DisplayObject);
                     }
                     if(_colorReversalUpdater)
                     {
                        if(!_colorReversalUpdaters)
                        {
                           _colorReversalUpdaters = new Dictionary();
                        }
                        _colorReversalUpdaters[param1] = _colorReversalUpdater.clone().init(param1 as DisplayObject);
                     }
                     if(_timelineUpdater && param1 is MovieClip)
                     {
                        if(!_timelineUpdaters)
                        {
                           _timelineUpdaters = new Dictionary();
                        }
                        _timelineUpdaters[param1] = _timelineUpdater.clone().init(param1 as MovieClip);
                     }
                  }
               }
            }
         };
         _inited = true;
         if(_targetSingle)
         {
            initParams2(_targetSingle);
         }
         else
         {
            var _loc2_:int = 0;
            var _loc1_:* = _target;
            for each(t in _target)
            {
               initParams2(t);
            }
         }
         overwrite();
      }
      
      private function overwrite() : void
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         if(_targetSingle)
         {
            _loc3_ = _playingTweensByTarget[_targetSingle];
            var _loc5_:int = 0;
            var _loc4_:* = _loc3_;
            for each(_loc1_ in _loc3_)
            {
               if(_loc1_ != this)
               {
                  if(_displayUpdater && _loc1_._displayUpdater)
                  {
                     _loc1_._displayUpdater.overwrite(_displayUpdater);
                  }
                  if(_blurUpdater && _loc1_._blurUpdater)
                  {
                     _loc1_._blurUpdater.overwrite(_blurUpdater);
                  }
                  if(_glowUpdater && _loc1_._glowUpdater)
                  {
                     _loc1_._glowUpdater.overwrite(_glowUpdater);
                  }
                  if(_dropShadowUpdater && _loc1_._dropShadowUpdater)
                  {
                     _loc1_._dropShadowUpdater.overwrite(_dropShadowUpdater);
                  }
                  if(_sharpUpdater && _loc1_._sharpUpdater)
                  {
                     _loc1_._sharpUpdater.overwrite(_sharpUpdater);
                  }
                  if(_saturationUpdater && _loc1_._saturationUpdater)
                  {
                     _loc1_._saturationUpdater.overwrite(_saturationUpdater);
                  }
                  if(_brightUpdater && _loc1_._brightUpdater)
                  {
                     _loc1_._brightUpdater.overwrite(_brightUpdater);
                  }
                  if(_contrastUpdater && _loc1_._contrastUpdater)
                  {
                     _loc1_._contrastUpdater.overwrite(_contrastUpdater);
                  }
                  if(_colorUpdater && _loc1_._colorUpdater)
                  {
                     _loc1_._colorUpdater.overwrite(_colorUpdater);
                  }
                  if(_colorReversalUpdater && _loc1_._colorReversalUpdater)
                  {
                     _loc1_._colorReversalUpdater.overwrite(_colorReversalUpdater);
                  }
                  if(_timelineUpdater && _loc1_._timelineUpdater)
                  {
                     _loc1_._timelineUpdater.overwrite(_timelineUpdater);
                  }
                  if(_objectUpdater && _loc1_._objectUpdater)
                  {
                     _loc1_._objectUpdater.overwrite(_objectUpdater);
                  }
               }
            }
            return;
         }
         var _loc9_:int = 0;
         var _loc8_:* = _target;
         for each(var _loc2_ in _target)
         {
            _loc3_ = _playingTweensByTarget[_loc2_];
            var _loc7_:int = 0;
            var _loc6_:* = _loc3_;
            for each(_loc1_ in _loc3_)
            {
               if(_loc1_ != this)
               {
                  if(_displayUpdaters && _loc1_._displayUpdaters && _displayUpdaters[_loc2_])
                  {
                     _loc1_._displayUpdaters[_loc2_].overwrite(_displayUpdaters[_loc2_]);
                  }
                  if(_objectUpdaters && _loc1_._objectUpdaters && _objectUpdaters[_loc2_])
                  {
                     _loc1_._objectUpdaters[_loc2_].overwrite(_objectUpdaters[_loc2_]);
                  }
                  if(_isFilter)
                  {
                     if(_blurUpdaters && _loc1_._blurUpdaters && _blurUpdaters[_loc2_])
                     {
                        _loc1_._blurUpdaters[_loc2_] = null;
                     }
                     if(_glowUpdaters && _loc1_._glowUpdaters && _glowUpdaters[_loc2_])
                     {
                        _loc1_._glowUpdaters[_loc2_] = null;
                     }
                     if(_dropShadowUpdaters && _loc1_._dropShadowUpdaters && _dropShadowUpdaters[_loc2_])
                     {
                        _loc1_._dropShadowUpdaters[_loc2_] = null;
                     }
                     if(_sharpUpdaters && _loc1_._sharpUpdaters && _sharpUpdaters[_loc2_])
                     {
                        _loc1_._sharpUpdaters[_loc2_] = null;
                     }
                     if(_brightUpdaters && _loc1_._brightUpdaters && _brightUpdaters[_loc2_])
                     {
                        _loc1_._brightUpdaters[_loc2_] = null;
                     }
                     if(_contrastUpdaters && _loc1_._contrastUpdaters && _contrastUpdaters[_loc2_])
                     {
                        _loc1_._contrastUpdaters[_loc2_] = null;
                     }
                     if(_colorUpdaters && _loc1_._colorUpdaters && _colorUpdaters[_loc2_])
                     {
                        _loc1_._colorUpdaters[_loc2_] = null;
                     }
                     if(_saturationUpdaters && _loc1_._saturationUpdaters && _saturationUpdaters[_loc2_])
                     {
                        _loc1_._saturationUpdaters[_loc2_] = null;
                     }
                     if(_colorReversalUpdaters && _loc1_._colorReversalUpdaters && _colorReversalUpdaters[_loc2_])
                     {
                        _loc1_._colorReversalUpdaters[_loc2_] = null;
                     }
                     if(_timelineUpdaters && _loc1_._timelineUpdaters && _timelineUpdaters[_loc2_])
                     {
                        _loc1_._timelineUpdaters[_loc2_] = null;
                     }
                  }
               }
            }
         }
      }
      
      public function manualUpdate(param1:int = 1) : void
      {
         if(_isManual && _playing)
         {
            _nowTime = getTimer();
            update();
         }
      }
      
      private function update() : void
      {
         var _loc11_:* = null;
         var _loc8_:Number = NaN;
         var _loc13_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc12_:* = null;
         var _loc14_:* = null;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:Number = _nowTime - _startTime;
         if(_skipped || _parentTween && _parentTween._skipped || _rootTween && _rootTween._skipped)
         {
            _progressDelay = 1;
            _progress = 1;
            _skipped = true;
            if(_onSkip != null)
            {
               if(_onSkipArgs)
               {
                  _onSkip.apply(_onSkip,_onSkipArgs);
               }
               else
               {
                  _onSkip();
               }
            }
            if(_dispatchSkip)
            {
               _eventDispatcher.dispatchEvent(new Tween24Event(this,"skip"));
            }
         }
         else if(_type == "tweenCount" || _type == "waitCount" || _type == "funcCount")
         {
            if(!_delayCount)
            {
               _progressDelay = 1;
            }
            else if(_progressDelay < 1)
            {
               _delayCurrentCount = Number(_delayCurrentCount) + 1;
               _progress = 0;
               _progressDelay = _delayCurrentCount / _delayCount;
               if(_progressDelay > 1)
               {
                  _progressDelay = 1;
               }
               else if(_progressDelay < 0)
               {
                  _progressDelay = 0;
               }
            }
            if(_progressDelay == 1)
            {
               _currentCount = Number(_currentCount) + 1;
               if(_totalCount == 0)
               {
                  _progress = 1;
               }
               else
               {
                  _progress = _currentCount / _totalCount;
                  if(_progress > 1)
                  {
                     _progress = 1;
                  }
                  else if(_progress < 0)
                  {
                     _progress = 0;
                  }
               }
            }
         }
         else
         {
            if(!_delayTime || _type == "loop" && _loopCurrent > 0)
            {
               _progressDelay = 1;
            }
            else if(_progressDelay < 1)
            {
               _progress = 0;
               _progressDelay = !!_delayTime?1 + _loc9_ / (_delayTime * 1000):1;
               if(_progressDelay > 1)
               {
                  _progressDelay = 1;
               }
               else if(_progressDelay < 0)
               {
                  _progressDelay = 0;
               }
            }
            if(_progressDelay == 1)
            {
               if(_completeTime == 0)
               {
                  _progress = 1;
               }
               else
               {
                  _progress = _loc9_ / _completeTime;
                  if(_progress > 1)
                  {
                     _progress = 1;
                  }
                  else if(_progress < 0)
                  {
                     _progress = 0;
                  }
               }
            }
         }
         if(_progressDelay < 1)
         {
            _delaying = true;
            if(_pluginProperty)
            {
               _pluginProperty.atDelay();
            }
            if(_onDelay != null)
            {
               if(_onDelayArgs)
               {
                  _onDelay.apply(_onDelay,_onDelayArgs);
               }
               else
               {
                  _onDelay();
               }
            }
            if(_dispatchDelay)
            {
               _eventDispatcher.dispatchEvent(new Tween24Event(this,"delay"));
            }
            return;
         }
         _delaying = false;
         if(!_inited)
         {
            if(_pluginProperty)
            {
               _pluginProperty.atInit();
            }
            initParams();
            if(_onInit != null)
            {
               if(_onInitArgs)
               {
                  _onInit.apply(_onInit,_onInitArgs);
               }
               else
               {
                  _onInit();
               }
            }
            if(!isNaN(_velocity))
            {
               _time = _displayUpdater.getDistance() / _velocity;
               updateTime();
               update();
               return;
            }
            if(_dispatchInit)
            {
               _eventDispatcher.dispatchEvent(new Tween24Event(this,"init"));
            }
         }
         if(_targetSingle)
         {
            if(_progress < 1)
            {
               _loc8_ = _easing(_progress,0,1,1);
               if(_objectUpdater)
               {
                  _objectUpdater.update(_loc8_);
               }
               if(_displayUpdater)
               {
                  _displayUpdater.update(_loc8_);
               }
               if(_isFilter)
               {
                  if(_blurUpdater)
                  {
                     _blurUpdater.update(_loc8_);
                  }
                  if(_glowUpdater)
                  {
                     _glowUpdater.update(_loc8_);
                  }
                  if(_dropShadowUpdater)
                  {
                     _dropShadowUpdater.update(_loc8_);
                  }
                  if(_sharpUpdater)
                  {
                     _sharpUpdater.update(_loc8_);
                  }
                  if(_brightUpdater)
                  {
                     _brightUpdater.update(_loc8_);
                  }
                  if(_contrastUpdater)
                  {
                     _contrastUpdater.update(_loc8_);
                  }
                  if(_colorUpdater)
                  {
                     _colorUpdater.update(_loc8_);
                  }
                  if(_saturationUpdater)
                  {
                     _saturationUpdater.update(_loc8_);
                  }
                  if(_colorReversalUpdater)
                  {
                     _colorReversalUpdater.update(_loc8_);
                  }
                  if(_timelineUpdater)
                  {
                     _timelineUpdater.update(_loc8_);
                  }
               }
               if(_pluginProperty)
               {
                  _pluginProperty.atUpdate();
               }
               if(_onUpdate != null)
               {
                  if(_onUpdateArgs)
                  {
                     _onUpdate.apply(_onUpdate,_onUpdateArgs);
                  }
                  else
                  {
                     _onUpdate();
                  }
               }
               if(_dispatchUpdate)
               {
                  _eventDispatcher.dispatchEvent(new Tween24Event(this,"update"));
               }
            }
            else if(_type == "tween" || _type == "prop" || _type == "tweenCount")
            {
               tweenComplete();
            }
         }
         else if(_target)
         {
            if(_progress < 1)
            {
               var _loc16_:int = 0;
               var _loc15_:* = _target;
               for each(_loc14_ in _target)
               {
                  _loc8_ = _easing(_progress,0,1,1);
                  if(_objectUpdaters && _objectUpdaters[_loc14_])
                  {
                     _objectUpdaters[_loc14_].update();
                  }
                  if(_displayUpdaters && _displayUpdaters[_loc14_])
                  {
                     _displayUpdaters[_loc14_].update(_loc8_);
                  }
                  if(_isFilter)
                  {
                     if(_blurUpdaters && _blurUpdaters[_loc14_])
                     {
                        _blurUpdaters[_loc14_].update(_loc8_);
                     }
                     if(_glowUpdaters && _glowUpdaters[_loc14_])
                     {
                        _glowUpdaters[_loc14_].update(_loc8_);
                     }
                     if(_dropShadowUpdaters && _dropShadowUpdaters[_loc14_])
                     {
                        _dropShadowUpdaters[_loc14_].update(_loc8_);
                     }
                     if(_sharpUpdaters && _sharpUpdaters[_loc14_])
                     {
                        _sharpUpdaters[_loc14_].update(_loc8_);
                     }
                     if(_brightUpdaters && _brightUpdaters[_loc14_])
                     {
                        _brightUpdaters[_loc14_].update(_loc8_);
                     }
                     if(_contrastUpdaters && _contrastUpdaters[_loc14_])
                     {
                        _contrastUpdaters[_loc14_].update(_loc8_);
                     }
                     if(_colorUpdaters && _colorUpdaters[_loc14_])
                     {
                        _colorUpdaters[_loc14_].update(_loc8_);
                     }
                     if(_saturationUpdaters && _saturationUpdaters[_loc14_])
                     {
                        _saturationUpdaters[_loc14_].update(_loc8_);
                     }
                     if(_colorReversalUpdaters && _colorReversalUpdaters[_loc14_])
                     {
                        _colorReversalUpdaters[_loc14_].update(_loc8_);
                     }
                     if(_timelineUpdaters && _timelineUpdaters[_loc14_])
                     {
                        _timelineUpdaters[_loc14_].update(_loc8_);
                     }
                  }
                  if(_onUpdate != null)
                  {
                     if(_onUpdateArgs)
                     {
                        _onUpdate.apply(_onUpdate,_onUpdateArgs);
                     }
                     else
                     {
                        _onUpdate();
                     }
                  }
                  if(_dispatchUpdate)
                  {
                     _eventDispatcher.dispatchEvent(new Tween24Event(this,"update"));
                  }
               }
            }
            else
            {
               tweenComplete();
            }
         }
         else if(_type == "tween" || _type == "tweenCount")
         {
            if(_progress < 1)
            {
               if(_onUpdate != null)
               {
                  if(_onUpdateArgs)
                  {
                     _onUpdate.apply(_onUpdate,_onUpdateArgs);
                  }
                  else
                  {
                     _onUpdate();
                  }
               }
               if(_dispatchUpdate)
               {
                  _eventDispatcher.dispatchEvent(new Tween24Event(this,"update"));
               }
            }
            else
            {
               tweenComplete();
            }
         }
         else if(_type == "serial" || _type == "loop")
         {
            if(!_played)
            {
               _played = true;
               _serialTween.play2();
            }
            else
            {
               var _loc18_:int = 0;
               var _loc17_:* = _playingChildTweens;
               for each(var _loc10_ in _playingChildTweens)
               {
                  _loc10_.update();
               }
            }
            if(_onUpdate != null)
            {
               if(_onUpdateArgs)
               {
                  _onUpdate.apply(_onUpdate,_onUpdateArgs);
               }
               else
               {
                  _onUpdate();
               }
            }
            if(_dispatchUpdate)
            {
               _eventDispatcher.dispatchEvent(new Tween24Event(this,"update"));
            }
            if(_numChildren == _numCompleteChildren)
            {
               actionComplete();
            }
         }
         else if(_type == "parallel" || _type == "lag")
         {
            if(!_played)
            {
               _played = true;
               var _loc20_:int = 0;
               var _loc19_:* = _parallelTweens;
               for each(_loc2_ in _parallelTweens)
               {
                  _loc2_.play2();
               }
            }
            else
            {
               var _loc22_:int = 0;
               var _loc21_:* = _playingChildTweens;
               for each(_loc2_ in _playingChildTweens)
               {
                  _loc2_.update();
               }
            }
            if(_onUpdate != null)
            {
               if(_onUpdateArgs)
               {
                  _onUpdate.apply(_onUpdate,_onUpdateArgs);
               }
               else
               {
                  _onUpdate();
               }
            }
            if(_dispatchUpdate)
            {
               _eventDispatcher.dispatchEvent(new Tween24Event(this,"update"));
            }
            if(_numChildren == _numCompleteChildren)
            {
               actionComplete();
            }
         }
         else if(_type == "ifCase")
         {
            if(_onUpdate != null)
            {
               if(_onUpdateArgs)
               {
                  _onUpdate.apply(_onUpdate,_onUpdateArgs);
               }
               else
               {
                  _onUpdate();
               }
            }
            if(_dispatchUpdate)
            {
               _eventDispatcher.dispatchEvent(new Tween24Event(this,"update"));
            }
            if(!_played)
            {
               _played = true;
               if(_ifCaseTarget)
               {
                  _ifCaseBoolean = _ifCaseTarget[_ifCasePropName];
               }
               if(_ifCaseBoolean)
               {
                  if(_ifCaseTrueTween)
                  {
                     _ifCaseTrueTween.play2();
                  }
                  else
                  {
                     actionComplete();
                  }
               }
               else if(_ifCaseFalseTween)
               {
                  _ifCaseFalseTween.play2();
               }
               else
               {
                  actionComplete();
               }
            }
            else if(_ifCaseBoolean)
            {
               if(_ifCaseTrueTween)
               {
                  _ifCaseTrueTween.update();
               }
            }
            else if(_ifCaseFalseTween)
            {
               _ifCaseFalseTween.update();
            }
            if(_numChildren == _numCompleteChildren)
            {
               actionComplete();
            }
         }
         else if(_type == "randome")
         {
            if(!_played)
            {
               _played = true;
               _loc1_ = _randomTweens.length * Math.random();
               _randomTween = _randomTweens[_loc1_];
               _randomTween.play2();
            }
            else
            {
               _randomTween.update();
            }
            if(_onUpdate != null)
            {
               if(_onUpdateArgs)
               {
                  _onUpdate.apply(_onUpdate,_onUpdateArgs);
               }
               else
               {
                  _onUpdate();
               }
            }
            if(_dispatchUpdate)
            {
               _eventDispatcher.dispatchEvent(new Tween24Event(this,"update"));
            }
            if(_numChildren == _numCompleteChildren)
            {
               actionComplete();
            }
         }
         else if(_type == "wait" || _type == "jump" || _type == "waitCount")
         {
            if(_onUpdate != null)
            {
               if(_onUpdateArgs)
               {
                  _onUpdate.apply(_onUpdate,_onUpdateArgs);
               }
               else
               {
                  _onUpdate();
               }
            }
            if(_dispatchUpdate)
            {
               _eventDispatcher.dispatchEvent(new Tween24Event(this,"update"));
            }
            if(_progress == 1)
            {
               actionComplete();
            }
         }
         else if(_type == "tweenFunc" || _type == "funcCount")
         {
            _loc4_ = [];
            _loc6_ = _tweenStartArgs.length;
            _loc8_ = _easing(_progress,0,1,1);
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc4_.push(_tweenStartArgs[_loc7_] + _tweenDeltaArgs[_loc7_] * _loc8_);
               _loc7_++;
            }
            _tweenFunc.apply(_tweenFunc,_loc4_);
            if(_onUpdate != null)
            {
               if(_onUpdateArgs)
               {
                  _onUpdate.apply(_onUpdate,_onUpdateArgs);
               }
               else
               {
                  _onUpdate();
               }
            }
            if(_dispatchUpdate)
            {
               _eventDispatcher.dispatchEvent(new Tween24Event(this,"update"));
            }
            if(_progress == 1)
            {
               tweenComplete();
            }
         }
         else if(!_actioned)
         {
            _actioned = true;
            if(_onUpdate != null)
            {
               if(_onUpdateArgs)
               {
                  _onUpdate.apply(_onUpdate,_onUpdateArgs);
               }
               else
               {
                  _onUpdate();
               }
            }
            if(_dispatchUpdate)
            {
               _eventDispatcher.dispatchEvent(new Tween24Event(this,"update"));
            }
            if(_progress == 1)
            {
               actionComplete();
            }
         }
         else if(_type == "funcAndWait" || _type == "waitEvent")
         {
            if(_parentTween && _parentTween._skipped || _rootTween && _rootTween._skipped)
            {
               funcComplete(null);
            }
         }
      }
      
      private function tweenComplete() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         if(_targetSingle)
         {
            if(_displayUpdater)
            {
               _displayUpdater.complete();
            }
            if(_objectUpdater)
            {
               _objectUpdater.complete();
            }
            if(_isFilter)
            {
               if(_blurUpdater)
               {
                  _blurUpdater.complete();
               }
               if(_glowUpdater)
               {
                  _glowUpdater.complete();
               }
               if(_dropShadowUpdater)
               {
                  _dropShadowUpdater.complete();
               }
               if(_sharpUpdater)
               {
                  _sharpUpdater.complete();
               }
               if(_brightUpdater)
               {
                  _brightUpdater.complete();
               }
               if(_contrastUpdater)
               {
                  _contrastUpdater.complete();
               }
               if(_colorUpdater)
               {
                  _colorUpdater.complete();
               }
               if(_saturationUpdater)
               {
                  _saturationUpdater.complete();
               }
               if(_timelineUpdater)
               {
                  _timelineUpdater.complete();
               }
               if(_colorReversalUpdater)
               {
                  _colorReversalUpdater.complete();
               }
            }
         }
         else
         {
            var _loc7_:int = 0;
            var _loc6_:* = _target;
            for each(var _loc4_ in _target)
            {
               if(_displayUpdaters && _displayUpdaters[_loc4_])
               {
                  _displayUpdaters[_loc4_].complete();
               }
               if(_objectUpdaters && _objectUpdaters[_loc4_])
               {
                  _objectUpdaters[_loc4_].complete();
               }
               if(_isFilter)
               {
                  if(_blurUpdaters && _blurUpdaters[_loc4_])
                  {
                     _blurUpdaters[_loc4_].complete();
                  }
                  if(_glowUpdaters && _glowUpdaters[_loc4_])
                  {
                     _glowUpdaters[_loc4_].complete();
                  }
                  if(_dropShadowUpdaters && _dropShadowUpdaters[_loc4_])
                  {
                     _dropShadowUpdaters[_loc4_].complete();
                  }
                  if(_sharpUpdaters && _sharpUpdaters[_loc4_])
                  {
                     _sharpUpdaters[_loc4_].complete();
                  }
                  if(_brightUpdaters && _brightUpdaters[_loc4_])
                  {
                     _brightUpdaters[_loc4_].complete();
                  }
                  if(_contrastUpdaters && _contrastUpdaters[_loc4_])
                  {
                     _contrastUpdaters[_loc4_].complete();
                  }
                  if(_colorUpdaters && _colorUpdaters[_loc4_])
                  {
                     _colorUpdaters[_loc4_].complete();
                  }
                  if(_saturationUpdaters && _saturationUpdaters[_loc4_])
                  {
                     _saturationUpdaters[_loc4_].complete();
                  }
                  if(_timelineUpdaters && _timelineUpdaters[_loc4_])
                  {
                     _timelineUpdaters[_loc4_].complete();
                  }
                  if(_colorReversalUpdaters && _colorReversalUpdaters[_loc4_])
                  {
                     _colorReversalUpdaters[_loc4_].complete();
                  }
               }
            }
         }
         if(_action != null)
         {
            _action();
         }
         if(_pluginProperty)
         {
            _pluginProperty.atComplete();
         }
         if(_onUpdate != null)
         {
            if(_onUpdateArgs)
            {
               _onUpdate.apply(_onUpdate,_onUpdateArgs);
            }
            else
            {
               _onUpdate();
            }
         }
         if(_dispatchUpdate)
         {
            _eventDispatcher.dispatchEvent(new Tween24Event(this,"update"));
         }
         playNextTween();
      }
      
      private function actionComplete() : void
      {
         if(_dispatcher)
         {
            _dispatcher.addEventListener(_eventType,funcComplete);
         }
         if(_action != null)
         {
            _action();
         }
         if(!_dispatcher)
         {
            playNextTween();
         }
      }
      
      private function funcComplete(param1:*) : void
      {
         _dispatcher.removeEventListener(_eventType,funcComplete);
         playNextTween();
      }
      
      private function playNextTween() : void
      {
         var _loc1_:Boolean = false;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_type == "loop")
         {
            _loopCurrent = Number(_loopCurrent) + 1;
            if(!_loopCount || _loopCount != _loopCurrent)
            {
               _nextTweenPlayed = false;
               _actioned = false;
               _played = false;
               _progress = 0;
               play2();
            }
            else
            {
               if(debugMode || _rootTween._isDebug)
               {
                  trace("[comp] " + this);
               }
               _completed = true;
               if(_parentTween && _parentTween._numChildren > _parentTween._numCompleteChildren)
               {
                  _parentTween._numCompleteChildren++;
               }
               stop2();
               _loopCurrent = 0;
               if(_onCompArgs && _onCompArgs.length)
               {
                  _onComp.apply(_onComp,_onCompArgs);
               }
               else if(_onComp != null)
               {
                  _onComp();
               }
               if(_dispatchComplete)
               {
                  _eventDispatcher.dispatchEvent(new Tween24Event(this,"complete"));
               }
               if(_nextTween)
               {
                  _nextTweenPlayed = true;
                  _nextTween.play2();
               }
            }
         }
         else
         {
            if(debugMode || _rootTween && _rootTween._isDebug)
            {
               debugTrace("comp");
            }
            _completed = true;
            if(_parentTween && _parentTween._numChildren > _parentTween._numCompleteChildren)
            {
               _parentTween._numCompleteChildren++;
            }
            if(_onCompArgs && _onCompArgs.length)
            {
               _onComp.apply(_onComp,_onCompArgs);
            }
            else if(_onComp != null)
            {
               _onComp();
            }
            if(_dispatchComplete)
            {
               _eventDispatcher.dispatchEvent(new Tween24Event(this,"complete"));
            }
            _loc3_ = !_nextTweenPlayed && _nextTween?_nextTween:null;
            removeTweens();
            if(_loc3_)
            {
               _loc3_.play2();
            }
            if(_parentTrigger)
            {
               _loc2_ = !!_parentTween?_parentTween._nextTween:null;
               if(_loc2_ && !_parentTween._completed)
               {
                  _parentTween._nextTweenPlayed = true;
                  if(_loc2_._type != "loop")
                  {
                     _loc2_.play2();
                  }
               }
            }
         }
      }
      
      public function getDispatcher() : EventDispatcher
      {
         return _eventDispatcher || new EventDispatcher();
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         getDispatcher().addEventListener(param1,param2,param3,param4,param5);
         updateEventTrigger();
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         getDispatcher().removeEventListener(param1,param2,param3);
         updateEventTrigger();
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return getDispatcher().hasEventListener(param1);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return getDispatcher().dispatchEvent(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return getDispatcher().willTrigger(param1);
      }
      
      private function updateEventTrigger() : void
      {
         if(!_eventDispatcher)
         {
            return;
         }
         _dispatchPlay = _eventDispatcher.willTrigger("play");
         _dispatchDelay = _eventDispatcher.willTrigger("delay");
         _dispatchInit = _eventDispatcher.willTrigger("init");
         _dispatchUpdate = _eventDispatcher.willTrigger("update");
         _dispatchPause = _eventDispatcher.willTrigger("pause");
         _dispatchSkip = _eventDispatcher.willTrigger("skip");
         _dispatchStop = _eventDispatcher.willTrigger("stop");
         _dispatchComplete = _eventDispatcher.willTrigger("complete");
      }
      
      private function setDisplayObjectUpdater2(param1:String, param2:String, param3:*, param4:*) : Tween24
      {
         return setDisplayObjectUpdater(param1,param3).setDisplayObjectUpdater(param2,param4);
      }
      
      private function setDisplayObjectUpdater3(param1:String, param2:String, param3:String, param4:*, param5:*, param6:*) : Tween24
      {
         return setDisplayObjectUpdater(param1,param4).setDisplayObjectUpdater(param2,param5).setDisplayObjectUpdater(param3,param6);
      }
      
      private function setDisplayObjectUpdater(param1:String, param2:*) : Tween24
      {
         propName = param1;
         value = param2;
         setValue = function(param1:DisplayObjectUpdater, param2:Object):void
         {
            var _loc3_:* = propName;
            if("x" !== _loc3_)
            {
               if("y" !== _loc3_)
               {
                  if("z" !== _loc3_)
                  {
                     if("$x" !== _loc3_)
                     {
                        if("$y" !== _loc3_)
                        {
                           if("$y" !== _loc3_)
                           {
                              if("$$x" !== _loc3_)
                              {
                                 if("$$y" !== _loc3_)
                                 {
                                    if("$$z" !== _loc3_)
                                    {
                                       if("alpha" !== _loc3_)
                                       {
                                          if("$alpha" !== _loc3_)
                                          {
                                             if("$$alpha" !== _loc3_)
                                             {
                                                if("rotation" !== _loc3_)
                                                {
                                                   if("rotationX" !== _loc3_)
                                                   {
                                                      if("rotationY" !== _loc3_)
                                                      {
                                                         if("rotationZ" !== _loc3_)
                                                         {
                                                            if("$rotation" !== _loc3_)
                                                            {
                                                               if("$rotationX" !== _loc3_)
                                                               {
                                                                  if("$rotationY" !== _loc3_)
                                                                  {
                                                                     if("$rotationZ" !== _loc3_)
                                                                     {
                                                                        if("$$rotation" !== _loc3_)
                                                                        {
                                                                           if("$$rotationX" !== _loc3_)
                                                                           {
                                                                              if("$$rotationY" !== _loc3_)
                                                                              {
                                                                                 if("$$rotationZ" !== _loc3_)
                                                                                 {
                                                                                    if("width" !== _loc3_)
                                                                                    {
                                                                                       if("height" !== _loc3_)
                                                                                       {
                                                                                          if("$width" !== _loc3_)
                                                                                          {
                                                                                             if("$height" !== _loc3_)
                                                                                             {
                                                                                                if("$$width" !== _loc3_)
                                                                                                {
                                                                                                   if("$$height" !== _loc3_)
                                                                                                   {
                                                                                                      if("scaleX" !== _loc3_)
                                                                                                      {
                                                                                                         if("scaleY" !== _loc3_)
                                                                                                         {
                                                                                                            if("scaleZ" !== _loc3_)
                                                                                                            {
                                                                                                               if("$scaleX" !== _loc3_)
                                                                                                               {
                                                                                                                  if("$scaleY" !== _loc3_)
                                                                                                                  {
                                                                                                                     if("$scaleZ" !== _loc3_)
                                                                                                                     {
                                                                                                                        if("$$scaleX" !== _loc3_)
                                                                                                                        {
                                                                                                                           if("$$scaleY" !== _loc3_)
                                                                                                                           {
                                                                                                                              if("$$scaleZ" !== _loc3_)
                                                                                                                              {
                                                                                                                                 if("globalX" !== _loc3_)
                                                                                                                                 {
                                                                                                                                    if("globalY" !== _loc3_)
                                                                                                                                    {
                                                                                                                                       if("fadeIn" !== _loc3_)
                                                                                                                                       {
                                                                                                                                          if("fadeOut" !== _loc3_)
                                                                                                                                          {
                                                                                                                                             if("align" !== _loc3_)
                                                                                                                                             {
                                                                                                                                                if("alignX" !== _loc3_)
                                                                                                                                                {
                                                                                                                                                   if("alignY" !== _loc3_)
                                                                                                                                                   {
                                                                                                                                                      if("alignScaleX" !== _loc3_)
                                                                                                                                                      {
                                                                                                                                                         if("alignScaleY" !== _loc3_)
                                                                                                                                                         {
                                                                                                                                                            if("localX" !== _loc3_)
                                                                                                                                                            {
                                                                                                                                                               if("localY" !== _loc3_)
                                                                                                                                                               {
                                                                                                                                                                  if("localXTarget" !== _loc3_)
                                                                                                                                                                  {
                                                                                                                                                                     if("localYTarget" !== _loc3_)
                                                                                                                                                                     {
                                                                                                                                                                        if("localTarget" !== _loc3_)
                                                                                                                                                                        {
                                                                                                                                                                           if("randomMinX" !== _loc3_)
                                                                                                                                                                           {
                                                                                                                                                                              if("randomMaxX" !== _loc3_)
                                                                                                                                                                              {
                                                                                                                                                                                 if("randomMinY" !== _loc3_)
                                                                                                                                                                                 {
                                                                                                                                                                                    if("randomMaxY" !== _loc3_)
                                                                                                                                                                                    {
                                                                                                                                                                                       if("randomMinZ" !== _loc3_)
                                                                                                                                                                                       {
                                                                                                                                                                                          if("randomMaxZ" !== _loc3_)
                                                                                                                                                                                          {
                                                                                                                                                                                             if("randomMinXY" !== _loc3_)
                                                                                                                                                                                             {
                                                                                                                                                                                                if("randomMaxXY" !== _loc3_)
                                                                                                                                                                                                {
                                                                                                                                                                                                   if("randomMinXYZ" !== _loc3_)
                                                                                                                                                                                                   {
                                                                                                                                                                                                      if("randomMaxXYZ" !== _loc3_)
                                                                                                                                                                                                      {
                                                                                                                                                                                                         if("randomRound" !== _loc3_)
                                                                                                                                                                                                         {
                                                                                                                                                                                                            if("blendMode" !== _loc3_)
                                                                                                                                                                                                            {
                                                                                                                                                                                                               if("useLayerBlend" !== _loc3_)
                                                                                                                                                                                                               {
                                                                                                                                                                                                                  if("mouseEnabled" !== _loc3_)
                                                                                                                                                                                                                  {
                                                                                                                                                                                                                     if("mouseChildren" !== _loc3_)
                                                                                                                                                                                                                     {
                                                                                                                                                                                                                        if("buttonEnabled" === _loc3_)
                                                                                                                                                                                                                        {
                                                                                                                                                                                                                           _loc3_ = value;
                                                                                                                                                                                                                           param1.mouseChildren = _loc3_;
                                                                                                                                                                                                                           param1.mouseEnabled = _loc3_;
                                                                                                                                                                                                                        }
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                     else
                                                                                                                                                                                                                     {
                                                                                                                                                                                                                        param1.mouseChildren = value;
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                  }
                                                                                                                                                                                                                  else
                                                                                                                                                                                                                  {
                                                                                                                                                                                                                     param1.mouseEnabled = value;
                                                                                                                                                                                                                  }
                                                                                                                                                                                                               }
                                                                                                                                                                                                               else
                                                                                                                                                                                                               {
                                                                                                                                                                                                                  param1.useLayerBlend = value;
                                                                                                                                                                                                               }
                                                                                                                                                                                                            }
                                                                                                                                                                                                            else
                                                                                                                                                                                                            {
                                                                                                                                                                                                               param1.blendMode = value;
                                                                                                                                                                                                            }
                                                                                                                                                                                                         }
                                                                                                                                                                                                         else
                                                                                                                                                                                                         {
                                                                                                                                                                                                            param1.randomRound = value;
                                                                                                                                                                                                         }
                                                                                                                                                                                                      }
                                                                                                                                                                                                      else
                                                                                                                                                                                                      {
                                                                                                                                                                                                         _loc3_ = value;
                                                                                                                                                                                                         param1.randomMaxZ = _loc3_;
                                                                                                                                                                                                         _loc3_ = _loc3_;
                                                                                                                                                                                                         param1.randomMaxY = _loc3_;
                                                                                                                                                                                                         param1.randomMaxX = _loc3_;
                                                                                                                                                                                                      }
                                                                                                                                                                                                   }
                                                                                                                                                                                                   else
                                                                                                                                                                                                   {
                                                                                                                                                                                                      _loc3_ = value;
                                                                                                                                                                                                      param1.randomMinZ = _loc3_;
                                                                                                                                                                                                      _loc3_ = _loc3_;
                                                                                                                                                                                                      param1.randomMinY = _loc3_;
                                                                                                                                                                                                      param1.randomMinX = _loc3_;
                                                                                                                                                                                                   }
                                                                                                                                                                                                }
                                                                                                                                                                                                else
                                                                                                                                                                                                {
                                                                                                                                                                                                   _loc3_ = value;
                                                                                                                                                                                                   param1.randomMaxY = _loc3_;
                                                                                                                                                                                                   param1.randomMaxX = _loc3_;
                                                                                                                                                                                                }
                                                                                                                                                                                             }
                                                                                                                                                                                             else
                                                                                                                                                                                             {
                                                                                                                                                                                                _loc3_ = value;
                                                                                                                                                                                                param1.randomMinY = _loc3_;
                                                                                                                                                                                                param1.randomMinX = _loc3_;
                                                                                                                                                                                             }
                                                                                                                                                                                          }
                                                                                                                                                                                          else
                                                                                                                                                                                          {
                                                                                                                                                                                             param1.randomMaxZ = value;
                                                                                                                                                                                          }
                                                                                                                                                                                       }
                                                                                                                                                                                       else
                                                                                                                                                                                       {
                                                                                                                                                                                          param1.randomMinZ = value;
                                                                                                                                                                                       }
                                                                                                                                                                                    }
                                                                                                                                                                                    else
                                                                                                                                                                                    {
                                                                                                                                                                                       param1.randomMaxY = value;
                                                                                                                                                                                    }
                                                                                                                                                                                 }
                                                                                                                                                                                 else
                                                                                                                                                                                 {
                                                                                                                                                                                    param1.randomMinY = value;
                                                                                                                                                                                 }
                                                                                                                                                                              }
                                                                                                                                                                              else
                                                                                                                                                                              {
                                                                                                                                                                                 param1.randomMaxX = value;
                                                                                                                                                                              }
                                                                                                                                                                           }
                                                                                                                                                                           else
                                                                                                                                                                           {
                                                                                                                                                                              param1.randomMinX = value;
                                                                                                                                                                           }
                                                                                                                                                                        }
                                                                                                                                                                        else
                                                                                                                                                                        {
                                                                                                                                                                           _loc3_ = value;
                                                                                                                                                                           param1.localYTarget = _loc3_;
                                                                                                                                                                           param1.localXTarget = _loc3_;
                                                                                                                                                                        }
                                                                                                                                                                     }
                                                                                                                                                                     else
                                                                                                                                                                     {
                                                                                                                                                                        param1.localYTarget = value;
                                                                                                                                                                     }
                                                                                                                                                                  }
                                                                                                                                                                  else
                                                                                                                                                                  {
                                                                                                                                                                     param1.localXTarget = value;
                                                                                                                                                                  }
                                                                                                                                                               }
                                                                                                                                                               else
                                                                                                                                                               {
                                                                                                                                                                  param1.localY = value;
                                                                                                                                                               }
                                                                                                                                                            }
                                                                                                                                                            else
                                                                                                                                                            {
                                                                                                                                                               param1.localX = value;
                                                                                                                                                            }
                                                                                                                                                         }
                                                                                                                                                         else
                                                                                                                                                         {
                                                                                                                                                            param1.alignScaleY = value;
                                                                                                                                                            param1.update$xy();
                                                                                                                                                         }
                                                                                                                                                      }
                                                                                                                                                      else
                                                                                                                                                      {
                                                                                                                                                         param1.alignScaleX = value;
                                                                                                                                                         param1.update$xy();
                                                                                                                                                      }
                                                                                                                                                   }
                                                                                                                                                   else
                                                                                                                                                   {
                                                                                                                                                      param1.alignY = value;
                                                                                                                                                      param1.update$xy();
                                                                                                                                                   }
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                   param1.alignX = value;
                                                                                                                                                   param1.update$xy();
                                                                                                                                                }
                                                                                                                                             }
                                                                                                                                             else
                                                                                                                                             {
                                                                                                                                                param1.align = value;
                                                                                                                                                param1.update$xy();
                                                                                                                                             }
                                                                                                                                          }
                                                                                                                                          else
                                                                                                                                          {
                                                                                                                                             param1.fadeOut = value;
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          param1.fadeIn = value;
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       param1.globalY = value;
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 else
                                                                                                                                 {
                                                                                                                                    param1.globalX = value;
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 param1.$$scaleZ = value;
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              param1.$$scaleY = value;
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           param1.$$scaleX = value;
                                                                                                                        }
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        param1.scaleZ = param2.scaleZ + value;
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     param1.scaleY = param2.scaleY + value;
                                                                                                                  }
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  param1.scaleX = param2.scaleX + value;
                                                                                                               }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               param1.scaleZ = value;
                                                                                                            }
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            param1.scaleY = value;
                                                                                                         }
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         param1.scaleX = value;
                                                                                                      }
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      param1.$$height = value;
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   param1.$$width = value;
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                param1.height = param2.height + value;
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             param1.width = param2.width + value;
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          param1.height = value;
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       param1.width = value;
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    param1.$$rotationZ = value;
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 param1.$$rotationY = value;
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              param1.$$rotationX = value;
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           param1.$$rotation = value;
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        param1.rotationZ = param2.rotationZ + value;
                                                                        param1.$rotationZ = value;
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     param1.rotationY = param2.rotationY + value;
                                                                     param1.$rotationY = value;
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  param1.rotationX = param2.rotationX + value;
                                                                  param1.$rotationX = value;
                                                               }
                                                            }
                                                            else
                                                            {
                                                               param1.rotation = param2.rotation + value;
                                                               param1.$rotation = value;
                                                            }
                                                         }
                                                         else
                                                         {
                                                            param1.rotationZ = value;
                                                         }
                                                      }
                                                      else
                                                      {
                                                         param1.rotationY = value;
                                                      }
                                                   }
                                                   else
                                                   {
                                                      param1.rotationX = value;
                                                   }
                                                }
                                                else
                                                {
                                                   param1.rotation = value;
                                                }
                                             }
                                             else
                                             {
                                                param1.$$alpha = value;
                                             }
                                          }
                                          else
                                          {
                                             param1.alpha = param2.alpha + value;
                                          }
                                       }
                                       else
                                       {
                                          param1.alpha = value;
                                       }
                                    }
                                    else
                                    {
                                       param1.$$z = value;
                                    }
                                 }
                                 else
                                 {
                                    param1.$$y = value;
                                 }
                              }
                              else
                              {
                                 param1.$$x = value;
                              }
                           }
                           else
                           {
                              param1.z = param2.z + value;
                           }
                        }
                        else
                        {
                           param1.set$y(value);
                        }
                     }
                     else
                     {
                        param1.set$x(value);
                     }
                  }
                  else
                  {
                     param1.z = value;
                  }
               }
               else
               {
                  param1.y = value;
               }
            }
            else
            {
               param1.x = value;
            }
         };
         if(_targetSingle)
         {
            if(!_displayUpdater)
            {
               _displayUpdater = new DisplayObjectUpdater(_targetSingle);
            }
            setValue(_displayUpdater,_targetSingle);
         }
         else
         {
            if(!_displayUpdaters)
            {
               _displayUpdaters = new Dictionary();
            }
            var _loc6_:int = 0;
            var _loc5_:* = _target;
            for each(tar in _target)
            {
               var updater:DisplayObjectUpdater = _displayUpdaters[tar] || _loc3_;
               setValue(updater,tar);
            }
         }
         return this;
      }
      
      private function setDisplayObjectUpdaterBezier(param1:String, param2:Number, param3:Number) : Tween24
      {
         propName = param1;
         x = param2;
         y = param3;
         setBezier = function(param1:DisplayObjectUpdater, param2:Object):void
         {
            var _loc3_:* = propName;
            if("bezier" !== _loc3_)
            {
               if("$bezier" !== _loc3_)
               {
                  if("$$bezier" === _loc3_)
                  {
                     param1.$$bezier(x,y);
                  }
               }
               else
               {
                  param1.bezier(param2.x + x,param2.y + y);
               }
            }
            else
            {
               param1.bezier(x,y);
            }
         };
         if(_targetSingle)
         {
            if(!_displayUpdater)
            {
               _displayUpdater = new DisplayObjectUpdater(_targetSingle);
            }
            setBezier(_displayUpdater,_targetSingle);
         }
         else
         {
            if(!_displayUpdaters)
            {
               _displayUpdaters = new Dictionary();
            }
            var _loc7_:int = 0;
            var _loc6_:* = _target;
            for each(tar in _target)
            {
               var updater:DisplayObjectUpdater = _displayUpdaters[tar] || _loc4_;
               setBezier(updater,tar);
            }
         }
         return this;
      }
      
      public function x(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("x",param1);
      }
      
      public function $x(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$x",param1);
      }
      
      public function $$x(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$$x",param1);
      }
      
      public function y(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("y",param1);
      }
      
      public function $y(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$y",param1);
      }
      
      public function $$y(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$$y",param1);
      }
      
      public function z(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("z",param1);
      }
      
      public function $z(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$z",param1);
      }
      
      public function $$z(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$$z",param1);
      }
      
      public function xy(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("x","y",param1,param2);
      }
      
      public function $xy(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("$x","$y",param1,param2);
      }
      
      public function $$xy(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("$$x","$$y",param1,param2);
      }
      
      public function xyz(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return setDisplayObjectUpdater3("x","y","z",param1,param2,param3);
      }
      
      public function $xyz(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return setDisplayObjectUpdater3("$x","$y","$z",param1,param2,param3);
      }
      
      public function $$xyz(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return setDisplayObjectUpdater3("$$x","$$y","$$z",param1,param2,param3);
      }
      
      public function alpha(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("alpha",param1);
      }
      
      public function $alpha(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$alpha",param1);
      }
      
      public function $$alpha(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$$alpha",param1);
      }
      
      public function rotation(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("rotation",param1);
      }
      
      public function $rotation(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$rotation",param1);
      }
      
      public function $$rotation(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$$rotation",param1);
      }
      
      public function rotationX(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("rotationX",param1);
      }
      
      public function $rotationX(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$rotationX",param1);
      }
      
      public function $$rotationX(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$$rotationX",param1);
      }
      
      public function rotationY(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("rotationY",param1);
      }
      
      public function $rotationY(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$rotationY",param1);
      }
      
      public function $$rotationY(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$$rotationY",param1);
      }
      
      public function rotationZ(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("rotationZ",param1);
      }
      
      public function $rotationZ(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$rotationZ",param1);
      }
      
      public function $$rotationZ(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$$rotationZ",param1);
      }
      
      public function rotationXY(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("rotationX","rotationY",param1,param2);
      }
      
      public function $rotationXY(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("$rotationX","$rotationY",param1,param2);
      }
      
      public function $$rotationXY(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("$$rotationX","$$rotationY",param1,param2);
      }
      
      public function rotationXYZ(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return setDisplayObjectUpdater3("rotationX","rotationY","rotationZ",param1,param2,param3);
      }
      
      public function $rotationXYZ(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return setDisplayObjectUpdater3("$rotationX","$rotationY","$rotationZ",param1,param2,param3);
      }
      
      public function $$rotationXYZ(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return setDisplayObjectUpdater3("$$rotationX","$$rotationY","$$rotationZ",param1,param2,param3);
      }
      
      public function width(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("width",param1);
      }
      
      public function $width(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$width",param1);
      }
      
      public function $$width(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$$width",param1);
      }
      
      public function height(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("height",param1);
      }
      
      public function $height(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$height",param1);
      }
      
      public function $$height(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$$height",param1);
      }
      
      public function scaleX(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("scaleX",param1);
      }
      
      public function $scaleX(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$scaleX",param1);
      }
      
      public function $$scaleX(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$$scaleX",param1);
      }
      
      public function scaleY(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("scaleY",param1);
      }
      
      public function $scaleY(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$scaleY",param1);
      }
      
      public function $$scaleY(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$$scaleY",param1);
      }
      
      public function scaleZ(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("scaleZ",param1);
      }
      
      public function $scaleZ(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$scaleZ",param1);
      }
      
      public function $$scaleZ(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("$$scaleZ",param1);
      }
      
      public function scaleXY(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("scaleX","scaleY",param1,param2);
      }
      
      public function $scaleXY(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("$scaleX","$scaleY",param1,param2);
      }
      
      public function $$scaleXY(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("$$scaleX","$$scaleY",param1,param2);
      }
      
      public function scale(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater2("scaleX","scaleY",param1,param1);
      }
      
      public function scaleXYZ(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return setDisplayObjectUpdater3("scaleX","scaleY","scaleZ",param1,param2,param3);
      }
      
      public function $scaleXYZ(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return setDisplayObjectUpdater3("$scaleX","$scaleY","$scaleZ",param1,param2,param3);
      }
      
      public function $$scaleXYZ(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return setDisplayObjectUpdater3("$$scaleX","$$scaleY","$$scaleZ",param1,param2,param3);
      }
      
      public function globalX(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("globalX",param1);
      }
      
      public function globalY(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("globalY",param1);
      }
      
      public function globalXY(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("globalX","globalY",param1,param2);
      }
      
      public function localX(param1:DisplayObject, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("localXTarget","localX",param1,param2);
      }
      
      public function localY(param1:DisplayObject, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("localYTarget","localY",param1,param2);
      }
      
      public function localXY(param1:DisplayObject, param2:Number, param3:Number) : Tween24
      {
         return setDisplayObjectUpdater3("localTarget","localX","localY",param1,param2,param3);
      }
      
      public function fadeIn(param1:Boolean = false) : Tween24
      {
         return setDisplayObjectUpdater3("alpha","fadeIn","useLayerBlend",1,true,param1);
      }
      
      public function fadeOut(param1:Boolean = false) : Tween24
      {
         return setDisplayObjectUpdater3("alpha","fadeOut","useLayerBlend",0,true,param1);
      }
      
      public function visible(param1:Boolean) : Tween24
      {
         if(param1)
         {
            setDisplayObjectUpdater("fadeIn",true);
         }
         else
         {
            setDisplayObjectUpdater("fadeOut",true);
         }
         return this;
      }
      
      public function mouseEnabled(param1:Boolean) : Tween24
      {
         return setDisplayObjectUpdater("mouseEnabled",param1);
      }
      
      public function mouseChildren(param1:Boolean) : Tween24
      {
         return setDisplayObjectUpdater("mouseChildren",param1);
      }
      
      public function buttonEnabled(param1:Boolean) : Tween24
      {
         return setDisplayObjectUpdater("buttonEnabled",param1);
      }
      
      public function align(param1:uint) : Tween24
      {
         return setDisplayObjectUpdater("align",param1);
      }
      
      public function alignX(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("alignX",param1);
      }
      
      public function alignY(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("alignY",param1);
      }
      
      public function alignXY(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("alignX","alignY",param1,param2);
      }
      
      public function alignByScaleX(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("alignScaleX",param1);
      }
      
      public function alignByScaleY(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater("alignScaleY",param1);
      }
      
      public function alignByScaleXY(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdater2("alignScaleX","alignScaleY",param1,param2);
      }
      
      public function alignByScale(param1:Number) : Tween24
      {
         return setDisplayObjectUpdater2("alignScaleX","alignScaleY",param1,param1);
      }
      
      public function bezier(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdaterBezier("bezier",param1,param2);
      }
      
      public function $bezier(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdaterBezier("$bezier",param1,param2);
      }
      
      public function $$bezier(param1:Number, param2:Number) : Tween24
      {
         return setDisplayObjectUpdaterBezier("$$bezier",param1,param2);
      }
      
      public function randomX(param1:Number, param2:Number, param3:Boolean = true) : Tween24
      {
         return setDisplayObjectUpdater3("randomMinX","randomMaxX","randomRound",param1,param2,param3);
      }
      
      public function randomY(param1:Number, param2:Number, param3:Boolean = true) : Tween24
      {
         return setDisplayObjectUpdater3("randomMinY","randomMaxY","randomRound",param1,param2,param3);
      }
      
      public function randomZ(param1:Number, param2:Number, param3:Boolean = true) : Tween24
      {
         return setDisplayObjectUpdater3("randomMinZ","randomMaxZ","randomRound",param1,param2,param3);
      }
      
      public function randomXY(param1:Number, param2:Number, param3:Boolean = true) : Tween24
      {
         return setDisplayObjectUpdater3("randomMinXY","randomMaxXY","randomRound",param1,param2,param3);
      }
      
      public function randomXYZ(param1:Number, param2:Number, param3:Boolean = true) : Tween24
      {
         return setDisplayObjectUpdater3("randomMinXYZ","randomMaxXYZ","randomRound",param1,param2,param3);
      }
      
      public function frame(param1:int) : Tween24
      {
         _isFilter = true;
         if(!_timelineUpdaters)
         {
            _timelineUpdaters = new Dictionary();
         }
         if(!_timelineUpdater)
         {
            _timelineUpdater = new TimelineUpdater();
         }
         _timelineUpdater.setProp(param1);
         return this;
      }
      
      public function blur(param1:Number = NaN, param2:Number = NaN, param3:Number = NaN) : Tween24
      {
         _isFilter = true;
         if(!_blurUpdater)
         {
            _blurUpdater = new BlurFilterUpdater();
         }
         _blurUpdater.setProp(param1,param2,param3);
         return this;
      }
      
      public function blurX(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_blurUpdater)
         {
            _blurUpdater = new BlurFilterUpdater();
         }
         _blurUpdater.blurX = param1;
         return this;
      }
      
      public function blurY(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_blurUpdater)
         {
            _blurUpdater = new BlurFilterUpdater();
         }
         _blurUpdater.blurY = param1;
         return this;
      }
      
      public function blurXY(param1:Number, param2:Number) : Tween24
      {
         _isFilter = true;
         if(!_blurUpdater)
         {
            _blurUpdater = new BlurFilterUpdater();
         }
         _blurUpdater.blurX = param1;
         _blurUpdater.blurY = param2;
         return this;
      }
      
      public function blurQuality(param1:int) : Tween24
      {
         _isFilter = true;
         if(!_blurUpdater)
         {
            _blurUpdater = new BlurFilterUpdater();
         }
         _blurUpdater.quality = param1;
         return this;
      }
      
      public function glow(param1:Number = NaN, param2:Number = NaN, param3:Number = NaN, param4:Number = NaN, param5:Number = NaN, param6:Number = NaN) : Tween24
      {
         _isFilter = true;
         if(!_glowUpdater)
         {
            _glowUpdater = new GlowFilterUpdater();
         }
         _glowUpdater.setProp(param1,param2,param3,param4,param5,param6);
         return this;
      }
      
      public function glowColor(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_glowUpdater)
         {
            _glowUpdater = new GlowFilterUpdater();
         }
         _glowUpdater.color = param1;
         return this;
      }
      
      public function glowAlpha(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_glowUpdater)
         {
            _glowUpdater = new GlowFilterUpdater();
         }
         _glowUpdater.alpha = param1;
         return this;
      }
      
      public function glowBlurX(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_glowUpdater)
         {
            _glowUpdater = new GlowFilterUpdater();
         }
         _glowUpdater.blurX = param1;
         return this;
      }
      
      public function glowBlurY(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_glowUpdater)
         {
            _glowUpdater = new GlowFilterUpdater();
         }
         _glowUpdater.blurY = param1;
         return this;
      }
      
      public function glowBlurXY(param1:Number, param2:Number) : Tween24
      {
         _isFilter = true;
         if(!_glowUpdater)
         {
            _glowUpdater = new GlowFilterUpdater();
         }
         _glowUpdater.blurX = param1;
         _glowUpdater.blurY = param2;
         return this;
      }
      
      public function glowStrength(param1:int) : Tween24
      {
         _isFilter = true;
         if(!_glowUpdater)
         {
            _glowUpdater = new GlowFilterUpdater();
         }
         _glowUpdater.strength = param1;
         return this;
      }
      
      public function glowQuality(param1:int) : Tween24
      {
         _isFilter = true;
         if(!_glowUpdater)
         {
            _glowUpdater = new GlowFilterUpdater();
         }
         _glowUpdater.quality = param1;
         return this;
      }
      
      public function glowInner(param1:Boolean) : Tween24
      {
         _isFilter = true;
         if(!_glowUpdater)
         {
            _glowUpdater = new GlowFilterUpdater();
         }
         _glowUpdater.inner = param1;
         return this;
      }
      
      public function glowKnockout(param1:Boolean) : Tween24
      {
         _isFilter = true;
         if(!_glowUpdater)
         {
            _glowUpdater = new GlowFilterUpdater();
         }
         _glowUpdater.knockout = param1;
         return this;
      }
      
      public function dropShadow(param1:Number = NaN, param2:Number = NaN, param3:Number = NaN, param4:Number = NaN, param5:Number = NaN, param6:Number = NaN, param7:Number = NaN, param8:Number = NaN) : Tween24
      {
         _isFilter = true;
         if(!_dropShadowUpdater)
         {
            _dropShadowUpdater = new DropShadowFilterUpdater();
         }
         _dropShadowUpdater.setProp(param1,param2,param3,param4,param5,param6,param7,param8);
         return this;
      }
      
      public function dropShadowDistance(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_dropShadowUpdater)
         {
            _dropShadowUpdater = new DropShadowFilterUpdater();
         }
         _dropShadowUpdater.distance = param1;
         return this;
      }
      
      public function dropShadowAngle(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_dropShadowUpdater)
         {
            _dropShadowUpdater = new DropShadowFilterUpdater();
         }
         _dropShadowUpdater.angle = param1;
         return this;
      }
      
      public function dropShadowColor(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_dropShadowUpdater)
         {
            _dropShadowUpdater = new DropShadowFilterUpdater();
         }
         _dropShadowUpdater.color = param1;
         return this;
      }
      
      public function dropShadowAlpha(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_dropShadowUpdater)
         {
            _dropShadowUpdater = new DropShadowFilterUpdater();
         }
         _dropShadowUpdater.alpha = param1;
         return this;
      }
      
      public function dropShadowBlurX(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_dropShadowUpdater)
         {
            _dropShadowUpdater = new DropShadowFilterUpdater();
         }
         _dropShadowUpdater.blurX = param1;
         return this;
      }
      
      public function dropShadowBlurY(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_dropShadowUpdater)
         {
            _dropShadowUpdater = new DropShadowFilterUpdater();
         }
         _dropShadowUpdater.blurY = param1;
         return this;
      }
      
      public function dropShadowBlurXY(param1:Number, param2:Number) : Tween24
      {
         _isFilter = true;
         if(!_dropShadowUpdater)
         {
            _dropShadowUpdater = new DropShadowFilterUpdater();
         }
         _dropShadowUpdater.blurX = param1;
         _dropShadowUpdater.blurY = param2;
         return this;
      }
      
      public function dropShadowStrength(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_dropShadowUpdater)
         {
            _dropShadowUpdater = new DropShadowFilterUpdater();
         }
         _dropShadowUpdater.strength = param1;
         return this;
      }
      
      public function dropShadowQuality(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_dropShadowUpdater)
         {
            _dropShadowUpdater = new DropShadowFilterUpdater();
         }
         _dropShadowUpdater.quality = param1;
         return this;
      }
      
      public function dropShadowInner(param1:Boolean) : Tween24
      {
         _isFilter = true;
         if(!_dropShadowUpdater)
         {
            _dropShadowUpdater = new DropShadowFilterUpdater();
         }
         _dropShadowUpdater.inner = param1;
         return this;
      }
      
      public function dropShadowKnockout(param1:Boolean) : Tween24
      {
         _isFilter = true;
         if(!_dropShadowUpdater)
         {
            _dropShadowUpdater = new DropShadowFilterUpdater();
         }
         _dropShadowUpdater.knockout = param1;
         return this;
      }
      
      public function bright(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_brightUpdater)
         {
            _brightUpdater = new BrightUpdater();
         }
         _brightUpdater.setProp(param1);
         return this;
      }
      
      public function contrast(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_contrastUpdater)
         {
            _contrastUpdater = new ContrastUpdater();
         }
         _contrastUpdater.setProp(param1);
         return this;
      }
      
      public function saturation(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_saturationUpdater)
         {
            _saturationUpdater = new SaturationUpdater();
         }
         _saturationUpdater.setProp(param1);
         return this;
      }
      
      public function sharp(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_sharpUpdater)
         {
            _sharpUpdater = new SharpUpdater();
         }
         _sharpUpdater.setProp(param1);
         return this;
      }
      
      public function color(param1:Number = NaN, param2:Number = 1) : Tween24
      {
         _isFilter = true;
         var _loc3_:Boolean = isNaN(param1);
         if(_loc3_)
         {
            param2 = 0;
         }
         if(!_colorUpdater)
         {
            _colorUpdater = new ColorUpdater();
         }
         _colorUpdater.setProp(param1,param2,_loc3_);
         return this;
      }
      
      public function colorAlpha(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_colorUpdater)
         {
            _colorUpdater = new ColorUpdater();
         }
         _colorUpdater.setProp(NaN,param1,isNaN(param1));
         return this;
      }
      
      public function colorReversal(param1:Number) : Tween24
      {
         _isFilter = true;
         if(!_colorReversalUpdater)
         {
            _colorReversalUpdater = new ColorReversalUpdater();
         }
         _colorReversalUpdater.setProp(param1);
         return this;
      }
      
      public function onPlay(param1:Function, ... rest) : Tween24
      {
         _onPlay = param1;
         _onPlayArgs = rest;
         return this;
      }
      
      public function onDelay(param1:Function, ... rest) : Tween24
      {
         _onDelay = param1;
         _onDelayArgs = rest;
         return this;
      }
      
      public function onInit(param1:Function, ... rest) : Tween24
      {
         _onInit = param1;
         _onInitArgs = rest;
         return this;
      }
      
      public function onUpdate(param1:Function, ... rest) : Tween24
      {
         _onUpdate = param1;
         _onUpdateArgs = rest;
         return this;
      }
      
      public function onPause(param1:Function, ... rest) : Tween24
      {
         _onPause = param1;
         _onPauseArgs = rest;
         return this;
      }
      
      public function onSkip(param1:Function, ... rest) : Tween24
      {
         _onSkip = param1;
         _onSkipArgs = rest;
         return this;
      }
      
      public function onStop(param1:Function, ... rest) : Tween24
      {
         _onStop = param1;
         _onStopArgs = rest;
         return this;
      }
      
      public function onComplete(param1:Function, ... rest) : Tween24
      {
         _onComp = param1;
         _onCompArgs = rest;
         return this;
      }
      
      public function delay(param1:Number) : Tween24
      {
         _delayTime = _delayTime + param1;
         _totalTime = _totalTime + _delayTime;
         return this;
      }
      
      public function delayCount(param1:uint) : Tween24
      {
         _delayCount = _delayCount + param1;
         return this;
      }
      
      public function jump() : Tween24
      {
         _isJump = true;
         return this;
      }
      
      public function id(param1:String) : Tween24
      {
         _id = param1;
         _tweensById[_id] = this;
         return this;
      }
      
      public function group(... rest) : Tween24
      {
         if(!_group)
         {
            _group = [];
         }
         _group = _group.concat(rest);
         var _loc5_:int = 0;
         var _loc4_:* = rest;
         for each(var _loc2_ in rest)
         {
            var _loc3_:* = _loc2_;
            _tweensByGroup[_loc3_] = _tweensByGroup[_loc3_] || [];
            _tweensByGroup[_loc2_].push(this);
         }
         return this;
      }
      
      public function andRemoveChild() : Tween24
      {
         _isRemoveParent = true;
         _action = function():void
         {
            Util24.display.removeChild(_targetSingle || _target);
         };
         return this;
      }
      
      public function timeScale(param1:Number) : Tween24
      {
         _timeScale = param1;
         return this;
      }
      
      public function addParam(param1:String, param2:*) : void
      {
         var _loc3_:* = null;
         if(_targetSingle)
         {
            if(!_objectUpdater)
            {
               _objectUpdater = new ObjectUpdater(_targetSingle);
            }
            _objectUpdater.addProp(param1,param2);
         }
         else
         {
            if(!_objectUpdaters)
            {
               _objectUpdaters = new Dictionary();
            }
            var _loc6_:int = 0;
            var _loc5_:* = _target;
            for each(var _loc4_ in _target)
            {
               _loc3_ = _objectUpdaters[_loc4_] || new ObjectUpdater(_loc4_);
               _loc3_.addProp(param1,param2);
               _objectUpdaters[_loc4_] = _loc3_;
            }
         }
      }
      
      public function toString() : String
      {
         var _loc1_:String = "";
         _loc1_ = _loc1_ + formatToString("type",_actionName || _type);
         if(_targetSingle)
         {
            _loc1_ = _loc1_ + " target:";
            if(_targetSingle is DisplayObject)
            {
               _loc1_ = _loc1_ + ("\"" + _targetSingle.name + "\"");
            }
            else
            {
               _loc1_ = _loc1_ + _targetSingle;
            }
         }
         else if(_target)
         {
            _loc1_ = _loc1_ + formatToString("target",_target,"name");
         }
         if(_time)
         {
            _loc1_ = _loc1_ + formatToString("time",_time);
         }
         if(_blurUpdater)
         {
            _loc1_ = _loc1_ + _blurUpdater.toString();
         }
         if(_glowUpdater)
         {
            _loc1_ = _loc1_ + _glowUpdater.toString();
         }
         if(_dropShadowUpdater)
         {
            _loc1_ = _loc1_ + _dropShadowUpdater.toString();
         }
         if(_saturationUpdater)
         {
            _loc1_ = _loc1_ + _saturationUpdater.toString();
         }
         if(_brightUpdater)
         {
            _loc1_ = _loc1_ + _brightUpdater.toString();
         }
         if(_colorUpdater)
         {
            _loc1_ = _loc1_ + _colorUpdater.toString();
         }
         if(_contrastUpdater)
         {
            _loc1_ = _loc1_ + _contrastUpdater.toString();
         }
         if(_timelineUpdater)
         {
            _loc1_ = _loc1_ + _timelineUpdater.toString();
         }
         if(_id)
         {
            _loc1_ = _loc1_ + formatToString("id",_id);
         }
         if(_group)
         {
            _loc1_ = _loc1_ + formatToString("group",_group);
         }
         return "[Tween24" + _loc1_ + "]";
      }
      
      private function formatToString(param1:String, param2:*, param3:String = null) : String
      {
         var _loc5_:* = null;
         if(param2 is String)
         {
            param2 = "\"" + param2 + "\"";
         }
         else if(param2 is Array)
         {
            if(param3)
            {
               _loc5_ = [];
               var _loc7_:int = 0;
               var _loc6_:* = param2;
               for each(var _loc4_ in param2)
               {
                  _loc5_.push(_loc4_[param3]);
               }
               if(_loc5_[0] is String)
               {
                  param2 = "[\"" + _loc5_.join("\", \"") + "\"]";
               }
               else
               {
                  param2 = "[" + _loc5_ + "]";
               }
            }
            else if(param2[0] is String)
            {
               param2 = "[\"" + param2.join("\", \"") + "\"]";
            }
         }
         return " " + param1 + ":" + param2;
      }
      
      private function debugTrace(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < _level)
         {
            _loc2_ = _loc2_ + "    ";
            _loc3_++;
         }
      }
      
      public function get playing() : Boolean
      {
         return _playing;
      }
      
      public function get pausing() : Boolean
      {
         return _pausing;
      }
   }
}
