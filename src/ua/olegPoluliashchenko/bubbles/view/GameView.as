package ua.olegPoluliashchenko.bubbles.view 
{
	import core.baseClasses.IView;
	import core.baseClasses.View;
	import core.embeddedAssets.EmbeddedAssets;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import ua.olegPoluliashchenko.bubbles.constants.Constants;
	import ua.olegPoluliashchenko.bubbles.controller.GameController;
	import ua.olegPoluliashchenko.bubbles.model.GameModel;
	import ua.olegPoluliashchenko.bubbles.vo.BubbleVO;
	import ua.olegPoluliashchenko.bubbles.vo.LargeBubbleVO;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class GameView extends View implements IView 
	{
		private var _currentModel:GameModel;
		private var _currentController:GameController;
		private var _currentSprite:Sprite;
		
		private var bubblesSprite:Vector.<Sprite>;
		private var bubblesLargeImage:Vector.<Image>;
		private var tracesEffects:Vector.<PDParticleSystem>;
		private var collisionEffects:Vector.<PDParticleSystem>;
		
		private var textureAtlas:TextureAtlas;
		private var traceEffect:PDParticleSystem;
		
		public function GameView() 
		{
			super();
			
		}
		
		//--------------------------------------------------------------------------
		//
		// OVERRIDDEN METHODS
		//
		//--------------------------------------------------------------------------
		
		override public function scrceenIn():void
		{
			textureAtlas = EmbeddedAssets.textureAtlas;
			
			_currentSprite = new Sprite();
			view = _currentSprite;
			
			addChild(_currentSprite);
			
			bubblesSprite = new Vector.<Sprite>();
			bubblesLargeImage = new Vector.<Image>();
			tracesEffects = new Vector.<PDParticleSystem>();
			collisionEffects = new Vector.<PDParticleSystem>();
		}
		
		override public function addListeners():void
		{
			
			super.addListeners();
		}
		
		override public function removeListeners():void
		{
			
			super.removeListeners();
		}
		
		override public function disposeView():void
		{
			while (bubblesSprite.length > 0)
			{
				_currentSprite.removeChild(bubblesSprite[0]);
				bubblesSprite.splice(0, 1);
			}
			
			while (bubblesLargeImage.length > 0)
			{
				_currentSprite.removeChild(bubblesLargeImage[0]);
				bubblesLargeImage.splice(0, 1);
			}
			
			while (collisionEffects.length > 0)
			{
				if (collisionEffects[0])
				{
					collisionEffects[0].removeEventListener(Event.COMPLETE, collisionEffect_completeHandler);
					collisionEffects[0].stop();
					collisionEffects[0].removeFromParent();
					Starling.juggler.remove(collisionEffects[0]);
				}
				collisionEffects.splice(0, 1);
			}
			
			while (tracesEffects.length > 0)
			{
				if (tracesEffects[0])
				{
					tracesEffects[0].removeEventListener(Event.COMPLETE, particleSystem_completeHandler);
					tracesEffects[0].stop();
					tracesEffects[0].removeFromParent();
					Starling.juggler.remove(tracesEffects[0]);
				}
				tracesEffects.splice(0, 1);
			}
			
			view.dispose();
			removeChild(_currentSprite);
			
			collisionEffects = null;
			tracesEffects = null;
			bubblesSprite = null;
			bubblesLargeImage = null;
			textureAtlas = null;
			traceEffect = null;
			_currentModel = null;;
			_currentController = null;
			_currentSprite = null;
			
			super.disposeView();
		}
		
		//--------------------------------------------------------------------------
		//
		// PUBLIC SECTION
		//
		//--------------------------------------------------------------------------
		
		public function get currentSprite():Sprite
		{
			return _currentSprite;
		}
		
		public function createBubbles():void
		{
			var bubblesVOVector:Vector.<BubbleVO> = currentModel.bubblesVOVector;
			var i:int;
			var length:int = bubblesVOVector.length;
			var bubbleVO:BubbleVO;
			var texture:Texture;
			var image:Image;
			var bubbleSprite:Sprite;
			
			for (i = 0; i < length; i++)
			{
				bubbleVO = bubblesVOVector[i];
				texture = textureAtlas.getTexture(Constants.BUBBLE_TEXTURE + bubbleVO.type);
				image = new Image(texture);
				image.alignPivot();
				
				bubbleSprite = new Sprite();
				bubbleSprite.x = bubbleVO.x;
				bubbleSprite.y = bubbleVO.y;
				
				traceEffect = new PDParticleSystem(XML(new EmbeddedAssets.TraceEffectConfig()), Texture.fromBitmap(new EmbeddedAssets.TraceEffectTexture()));
				traceEffect.x = image.x;
				traceEffect.y = image.y;
				traceEffect.rotation = bubbleVO.rotation;
				traceEffect.start();
				Starling.juggler.add(traceEffect);
				
				bubbleSprite.addChild(traceEffect);
				bubbleSprite.addChild(image);
				_currentSprite.addChild(bubbleSprite);
				
				bubblesSprite.push(bubbleSprite);
				tracesEffects.push(traceEffect);
			}
		}
		
		public function updateBubblesPosition():void
		{
			var bubblesVOVector:Vector.<BubbleVO> = currentModel.bubblesVOVector;
			
			var i:int;
			var length:int = bubblesVOVector.length;
			var bubbleVO:BubbleVO;
			var sprite:Sprite;
			var effect:PDParticleSystem;
			
			for (i = 0; i < length; i++)
			{
				bubbleVO = bubblesVOVector[i];
				effect = tracesEffects[i];
				sprite = bubblesSprite[i];
				
				sprite.x = bubbleVO.x;
				sprite.y = bubbleVO.y;
				effect.rotation = bubbleVO.rotation;
			}
		}
		
		public function createLargeBubble():void
		{
			var largeBubblesVOVector:Vector.<LargeBubbleVO> = currentModel.largeBubblesVOVector;
			var length:int = largeBubblesVOVector.length;
			var largeBubbleVO:LargeBubbleVO = largeBubblesVOVector[length - 1];
			var texture:Texture;
			var image:Image;
			
			texture = textureAtlas.getTexture(Constants.LARGE_BUBBLE_TEXTURE + largeBubbleVO.type);
			image = new Image(texture);
			image.alignPivot();
			image.x = largeBubbleVO.x;
			image.y = largeBubbleVO.y;
			image.scaleX = largeBubbleVO.scale;
			image.scaleY = largeBubbleVO.scale;
			_currentSprite.addChild(image);
			bubblesLargeImage.push(image);
		}
		
		public function updateScalelargeBubbles():void
		{
			var largeBubblesVOVector:Vector.<LargeBubbleVO> = currentModel.largeBubblesVOVector;
			
			var i:int;
			var length:int = largeBubblesVOVector.length;
			var bubbleObject:Object;
			var image:Image;
			
			for (i = length - 1; i > -1; i--)
			{
				bubbleObject = largeBubblesVOVector[i];
				image = bubblesLargeImage[i];
				image.scaleX = bubbleObject.scale;
				image.scaleY = bubbleObject.scale;
			}
		}
		
		public function removeLargeBubble(bubbleIndex:int):void
		{
			_currentSprite.removeChild(bubblesLargeImage[bubbleIndex]);
			bubblesLargeImage.splice(bubbleIndex, 1);
		}
		
		public function removeBubble(bubbleIndex:int):void
		{
			var collisionEffect:PDParticleSystem = new PDParticleSystem(XML(new EmbeddedAssets.CollisonEffectConfig()), Texture.fromBitmap(new EmbeddedAssets.CollisonEffectTexture()));
			collisionEffect.x = bubblesSprite[bubbleIndex].x;
			collisionEffect.y = bubblesSprite[bubbleIndex].y;
			collisionEffect.start(Constants.REMOVE_BUBBLE_EFFECT_TIME);
			Starling.juggler.add(collisionEffect);
			_currentSprite.addChild(collisionEffect);
			collisionEffects.push(collisionEffect);
			collisionEffect.addEventListener(Event.COMPLETE, collisionEffect_completeHandler);
			
			bubblesSprite[bubbleIndex].removeChildAt(bubblesSprite[bubbleIndex].numChildren - 1);
			bubblesSprite.splice(bubbleIndex, 1);
			
			var particleSystem:PDParticleSystem = tracesEffects[bubbleIndex];
			particleSystem.addEventListener(Event.COMPLETE, particleSystem_completeHandler);
			particleSystem.stop();
			tracesEffects.splice(bubbleIndex, 1);
		}
		
		//--------------------------------------------------------------------------
		//
		// PRIVATE SECTION
		//
		//--------------------------------------------------------------------------
		
		private function particleSystem_completeHandler(event:Event):void 
		{
			var particleSystem:PDParticleSystem = PDParticleSystem(event.target);
			
			_currentSprite.removeChild(particleSystem.parent);
			
			particleSystem.removeEventListener(Event.COMPLETE, particleSystem_completeHandler);
			particleSystem.stop();
			particleSystem.removeFromParent();
			Starling.juggler.remove(particleSystem);
			
		}
		
		private function collisionEffect_completeHandler(event:Event):void 
		{
			var collisionEffect:PDParticleSystem = PDParticleSystem(event.target);
			
			var i:int;
			var length:int = collisionEffects.length - 1;
			var effect:PDParticleSystem;
			
			for (i = length; i > -1; i--)
			{
				effect = collisionEffects[i];
				
				if (effect == collisionEffect)
				{
					collisionEffects.splice(i, 1);
				}
			}
			
			collisionEffect.removeEventListener(Event.COMPLETE, collisionEffect_completeHandler);
			collisionEffect.stop();
			collisionEffect.removeFromParent();
			Starling.juggler.remove(collisionEffect);
		}
		
		private function get currentModel():GameModel
		{
			if (!_currentModel)
			{
				_currentModel = GameModel(model);
			}
			
			return _currentModel;
		}
		
		private function get currentController():GameController
		{
			if (!_currentController)
			{
				_currentController = GameController(controller);
			}
			
			return _currentController;
		}
		
	}

}