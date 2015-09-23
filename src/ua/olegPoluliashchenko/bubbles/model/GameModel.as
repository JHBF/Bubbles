package ua.olegPoluliashchenko.bubbles.model 
{
	import core.baseClasses.IModel;
	import core.baseClasses.Model;
	import core.embeddedAssets.EmbeddedAssets;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import ua.olegPoluliashchenko.bubbles.constants.Constants;
	import ua.olegPoluliashchenko.bubbles.events.ModelEvent;
	import ua.olegPoluliashchenko.bubbles.vo.BubbleVO;
	import ua.olegPoluliashchenko.bubbles.vo.LargeBubbleVO;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class GameModel extends Model implements IModel 
	{
		private static const MIN_BUBBLES_SPEED:int = 3;
		private static const MAX_BUBBLES_SPEED:int = 7;
		
		private var bornTime:Number;
		private var lifeTime:Number;
		private var countPoints:Number;
		
		private var _bubblesVOVector:Vector.<BubbleVO>;
		private var _largeBubblesVOVector:Vector.<LargeBubbleVO>;
		private var largeBubblesTimerObjects:Vector.<Timer>;
		
		private var bornTimer:Timer;
		
		private var _smallBubbleRadius:Number;
		private var _largeBubbleRadius:Number;
		
		private var loadedSettings:String;
		
		public function GameModel() 
		{
			super();
			
		}
		
		//--------------------------------------------------------------------------
		//
		// OVERRIDDEN METHODS
		//
		//--------------------------------------------------------------------------
		
		override public function destroy():void
		{
			while (largeBubblesTimerObjects.length > 0)
			{
				largeBubblesTimerObjects[0].removeEventListener(TimerEvent.TIMER, bornTimer_timerHandler);
				largeBubblesTimerObjects[0].removeEventListener(TimerEvent.TIMER, lifeTimer_timerHandler);
				largeBubblesTimerObjects[0].removeEventListener(TimerEvent.TIMER, destroyTimer_timerHandler);
				
				largeBubblesTimerObjects.splice(0, 1);
			}
			
			bornTimer = null;
			largeBubblesTimerObjects = null;
			_bubblesVOVector = null;
			_largeBubblesVOVector = null;
			
			super.destroy();
		}
		
		//--------------------------------------------------------------------------
		//
		// PUBLIC SECTION
		//
		//--------------------------------------------------------------------------
		
		public function set smallBubbleRadius(value:Number):void 
		{
			_smallBubbleRadius = value;
		}
		
		public function set largeBubbleRadius(value:Number):void 
		{
			_largeBubbleRadius = value;
		}
		
		public function get bubblesVOVector():Vector.<BubbleVO> 
		{
			return _bubblesVOVector;
		}
		
		public function get largeBubblesVOVector():Vector.<LargeBubbleVO> 
		{
			return _largeBubblesVOVector;
		}
		
		public function loadSettings(url:String):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loader_completeHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loader_io_errorHandler);
			loader.load(new URLRequest(url));
		}
		
		public function createBubbles():void
		{
			_bubblesVOVector = new Vector.<BubbleVO>();
			_largeBubblesVOVector = new Vector.<LargeBubbleVO>();
			largeBubblesTimerObjects = new Vector.<Timer>();
			
			var i:int;
			var length:int = countPoints;
			var bubbleVO:BubbleVO;
			for (i = 0; i < length; i++)
			{
				bubbleVO = new BubbleVO();
				bubbleVO.x = Math.random() * Constants.STAGE_WIDTH;
				bubbleVO.y = Math.random() * Constants.STAGE_HEIGHT;
				bubbleVO.type = Math.floor(Math.random() * Constants.MAX_BUBBLE_TYPE) + Constants.MIN_BUBBLE_TYPE;
				bubbleVO.radius = _smallBubbleRadius;
				
				var dx:Number = Math.random() * Constants.STAGE_WIDTH - bubbleVO.x;
				var dy:Number = Math.random() * Constants.STAGE_HEIGHT - bubbleVO.y;
				var angle:Number = Math.atan2(dy, dx);
				
				bubbleVO.rotation = angle;
				bubbleVO.cos = Math.cos(angle);
				bubbleVO.sin = Math.sin(angle);
				bubbleVO.speed = (Math.random() * MAX_BUBBLES_SPEED) + MIN_BUBBLES_SPEED;
				_bubblesVOVector.push(bubbleVO);
			}
		}
		
		public function checkBorder():void
		{
			var i:int;
			var length:int = _bubblesVOVector.length;
			var bubbleVO:BubbleVO;
			for (i = 0; i < length; i++)
			{
				bubbleVO = _bubblesVOVector[i];
				
				if (bubbleVO.x <= 0 || bubbleVO.x >= Constants.STAGE_WIDTH)
				{
					bubbleVO.cos *= -1;
				}
				if (bubbleVO.y <= 0 || bubbleVO.y >= Constants.STAGE_HEIGHT)
				{
					bubbleVO.sin *= -1;
				}
			}
		}
		
		public function updateBubblesPosition():void
		{
			var i:int;
			var length:int = _bubblesVOVector.length;
			var bubbleVO:BubbleVO;
			
			var X:Number;
			var Y:Number;
			
			for (i = 0; i < length; i++)
			{
				bubbleVO = _bubblesVOVector[i];
				
				X = bubbleVO.x;
				Y = bubbleVO.y;
				
				bubbleVO.x += bubbleVO.speed * bubbleVO.cos;
				bubbleVO.y += bubbleVO.speed * bubbleVO.sin;
				
				var dx:Number = bubbleVO.x - X;
				var dy:Number = bubbleVO.y - Y;
				var angle:Number = Math.atan2(dy, dx);
				
				bubbleVO.rotation = angle;
			}
		}
		
		public function createLargeBubble(mouseX:Number, mouseY:Number, type:Number = 0):void
		{
			var bubbleType:int;
			if (type == 0)
			{
				bubbleType = Math.floor(Math.random() * Constants.MAX_BUBBLE_TYPE) + Constants.MIN_BUBBLE_TYPE;
			}
			else
			{
				bubbleType = type;
			}
			
			var i:int;
			var largeBubbleVO:LargeBubbleVO = new LargeBubbleVO();
			largeBubbleVO.x = mouseX;
			largeBubbleVO.y = mouseY;
			largeBubbleVO.type = bubbleType;
			largeBubbleVO.radius = _largeBubbleRadius;
			largeBubbleVO.scale = 1 / (bornTime / Constants.TIME_UPDATE_FOR_LARGE_BUBBLE);
			largeBubbleVO.stepScale = largeBubbleVO.scale;
			
			_largeBubblesVOVector.push(largeBubbleVO);
			
			this.dispatchEvent(new ModelEvent(ModelEvent.CREATE_LARGE_BUBBLE));
			
			bornTimer = new Timer(Constants.TIME_UPDATE_FOR_LARGE_BUBBLE);
			bornTimer.addEventListener(TimerEvent.TIMER, bornTimer_timerHandler);
			bornTimer.start();
			largeBubblesTimerObjects.push(bornTimer);
		}
		
		public function checkCollision():void
		{
			var dx:Number;
			var dy:Number;
			var dist:Number;
			
			var i:int;
			var largeBubbleVO:LargeBubbleVO;
			
			var j:int;
			var bubbleVO:BubbleVO;
			
			for (i = _largeBubblesVOVector.length - 1; i > -1; i--)
			{
				largeBubbleVO = _largeBubblesVOVector[i];
				
				for (j = _bubblesVOVector.length - 1; j > -1; j--)
				{
					bubbleVO = _bubblesVOVector[j];
					
					dx = bubbleVO.x - largeBubbleVO.x;
					dy = bubbleVO.y - largeBubbleVO.y;
					
					dist = Math.sqrt(dx * dx + dy * dy);
					
					if (dist <= bubbleVO.radius + (largeBubbleVO.radius * largeBubbleVO.scale))
					{
						_bubblesVOVector.splice(j, 1);
						this.dispatchEvent(new ModelEvent(ModelEvent.OCCURRED_COLLISION, false, { x:bubbleVO.x, y:bubbleVO.y, type:bubbleVO.type }));
						this.dispatchEvent(new ModelEvent(ModelEvent.REMOVE_BUBBLE, false, { id:j }));
					}
				}
			}
		}
		
		public function checkGameOver():void
		{
			if (_bubblesVOVector.length == 0 && _largeBubblesVOVector.length == 0 && largeBubblesTimerObjects.length == 0)
			{
				this.dispatchEvent(new ModelEvent(ModelEvent.GAME_OVER));
			}
		}
		
		//--------------------------------------------------------------------------
		//
		// PRIVATE SECTION
		//
		//--------------------------------------------------------------------------
		
		private function loader_io_errorHandler(event:IOErrorEvent):void 
		{
			var loader:URLLoader = URLLoader(event.target);
			
			loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_io_errorHandler);
			
			countPoints = EmbeddedAssets.COUNT_POINTS;
			bornTime = EmbeddedAssets.BORN_TIME;
			lifeTime = EmbeddedAssets.LIFE_TIME;
			
			this.dispatchEvent(new ModelEvent(ModelEvent.READY));
		}
		
		private function loader_completeHandler(event:Event):void 
		{
			var loader:URLLoader = URLLoader(event.target);
			
			loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_io_errorHandler);
			
			loadedSettings = String(loader.data);
			
			parseLoadedSettings();
		}
		
		private function parseLoadedSettings():void
		{
			var countPointsString:String = Constants.COUNT_POINTS_NAME;
			var result:Number;
			var index:int = loadedSettings.indexOf(countPointsString);
			index += countPointsString.length;
			
			result = parseValue(index);
			if (!isNaN(result))
			{
				countPoints = int(result);
			}
			else
			{
				countPoints = EmbeddedAssets.COUNT_POINTS;
			}
			
			var bornTimeString:String = Constants.BORN_TIME_NAME;
			index = loadedSettings.indexOf(bornTimeString);
			index += bornTimeString.length;
			
			result = parseValue(index);
			if (!isNaN(result))
			{
				bornTime = result * Constants.CONVERT_COEF_FROM_SEC_TO_MS;
			}
			else
			{
				bornTime = EmbeddedAssets.BORN_TIME;
			}
			
			var lifeTimeString:String = Constants.LIFE_TIME_NAME;
			index = loadedSettings.indexOf(lifeTimeString);
			index += lifeTimeString.length;
			
			result = parseValue(index);
			if (!isNaN(result))
			{
				lifeTime = result * Constants.CONVERT_COEF_FROM_SEC_TO_MS;
			}
			else
			{
				lifeTime = EmbeddedAssets.LIFE_TIME;
			}
			
			this.dispatchEvent(new ModelEvent(ModelEvent.READY));
		}
		
		private function parseValue(index:int):Number 
		{
			var stringValue:String = "";
			
			for (var i:int = index; i < loadedSettings.length; i++)
			{
				if (loadedSettings.charAt(i) != Constants.DIVIDER_FOR_PARSE_STRINGS)
				{
					stringValue += loadedSettings.charAt(i);
				}
				else 
				{
					break;
				}
			}
			
			return Number(stringValue);
		}
		
		private function bornTimer_timerHandler(event:TimerEvent):void 
		{
			var i:int;
			var length:int = largeBubblesTimerObjects.length;
			var largeBubbleVO:LargeBubbleVO;
			
			for (i = 0; i < length; i++)
			{
				if (largeBubblesTimerObjects[i] == event.target)
				{
					largeBubbleVO = _largeBubblesVOVector[i];
					
					if (largeBubbleVO.scale < 1)
					{
						largeBubbleVO.scale += largeBubbleVO.stepScale;
					}
					else
					{
						largeBubblesTimerObjects[i].reset();
						largeBubblesTimerObjects[i].removeEventListener(TimerEvent.TIMER, bornTimer_timerHandler);
						
						largeBubblesTimerObjects[i] = new Timer(lifeTime);
						largeBubblesTimerObjects[i].start();
						largeBubblesTimerObjects[i].addEventListener(TimerEvent.TIMER, lifeTimer_timerHandler);
					}
					
					break;
				}
			}
		}
		
		private function lifeTimer_timerHandler(event:TimerEvent):void 
		{
			var i:int;
			var length:int = largeBubblesTimerObjects.length;
			
			for (i = 0; i < length; i++)
			{
				if (largeBubblesTimerObjects[i] == event.target)
				{
					largeBubblesTimerObjects[i].stop();
					largeBubblesTimerObjects[i].removeEventListener(TimerEvent.TIMER, lifeTimer_timerHandler);
					largeBubblesTimerObjects[i] = new Timer(Constants.TIME_UPDATE_FOR_LARGE_BUBBLE);
					largeBubblesTimerObjects[i].addEventListener(TimerEvent.TIMER, destroyTimer_timerHandler);
					largeBubblesTimerObjects[i].start();
					
					break;
				}
			}
		}
		
		private function destroyTimer_timerHandler(event:TimerEvent):void 
		{
			var i:int;
			var length:int = largeBubblesTimerObjects.length;
			var largeBubbleVO:LargeBubbleVO;
			
			for (i = length - 1; i > -1; i--)
			{
				if (largeBubblesTimerObjects[i] == event.target)
				{
					largeBubbleVO = _largeBubblesVOVector[i];
					
					if (largeBubbleVO.scale > largeBubbleVO.stepScale)
					{
						largeBubbleVO.scale -= largeBubbleVO.stepScale;
					}
					else
					{
						largeBubblesTimerObjects[i].stop();
						largeBubblesTimerObjects[i].removeEventListener(TimerEvent.TIMER, destroyTimer_timerHandler);
						
						_largeBubblesVOVector.splice(i, 1);
						largeBubblesTimerObjects.splice(i, 1);
						
						this.dispatchEvent(new ModelEvent(ModelEvent.REMOVE_LARGE_BUBBLE, false, { id:i }));
					}
					
					break;
				}
			}
		}
		
	}

}