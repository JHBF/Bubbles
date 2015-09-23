package ua.olegPoluliashchenko.bubbles.controller 
{
	import core.baseClasses.Controller;
	import core.baseClasses.IController;
	import core.embeddedAssets.EmbeddedAssets;
	import core.events.ScreenChangeEvent;
	import core.screens.ScreensConstants;
	import flash.geom.Point;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import ua.olegPoluliashchenko.bubbles.constants.Constants;
	import ua.olegPoluliashchenko.bubbles.events.ModelEvent;
	import ua.olegPoluliashchenko.bubbles.model.GameModel;
	import ua.olegPoluliashchenko.bubbles.view.GameView;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class GameController extends Controller implements IController 
	{
		private var _currentModel:GameModel;
		private var _currentView:GameView;
		
		private var isModelReady:Boolean;
		
		public function GameController() 
		{
			super();
			
		}
		
		//--------------------------------------------------------------------------
		//
		// OVERRIDDEN METHODS
		//
		//--------------------------------------------------------------------------
		
		override public function controllerIn():void
		{
			currentModel.addEventListener(ModelEvent.READY, currentModel_readyHandler);
			currentModel.loadSettings(EmbeddedAssets.URL_SETTINGS);
			isModelReady = false;
			
			var textureAtlas:TextureAtlas = EmbeddedAssets.textureAtlas;
			var textureSmall:Texture = textureAtlas.getTexture(String(Constants.BUBBLE_TEXTURE + Constants.MIN_BUBBLE_TYPE));
			var textureLarge:Texture = textureAtlas.getTexture(String(Constants.LARGE_BUBBLE_TEXTURE + Constants.MIN_BUBBLE_TYPE));
			
			currentModel.smallBubbleRadius = textureSmall.width / 2;
			currentModel.largeBubbleRadius = textureLarge.width / 2
			
			
			super.controllerIn();
		}
		
		override public function destroy():void
		{
			_currentModel = null;
			_currentView = null;
			
			super.destroy();
		}
		
		override public function addListeners():void
		{
			if (!isModelReady)
			{
				return;
			}
			
			currentView.currentSprite.addEventListener(Event.ENTER_FRAME, currentView_enterFrameHandler);
			currentView.parent.addEventListener(TouchEvent.TOUCH, currentView_touchHandler);
			currentModel.addEventListener(ModelEvent.REMOVE_LARGE_BUBBLE, currentModel_removeLargeBubbleHandler);
			currentModel.addEventListener(ModelEvent.OCCURRED_COLLISION, currentModel_occurredCollisionHandler);
			currentModel.addEventListener(ModelEvent.REMOVE_BUBBLE, currentModel_removeBubbleHandler);
			currentModel.addEventListener(ModelEvent.GAME_OVER, currentModel_gameOverBubbleHandler);
			currentModel.addEventListener(ModelEvent.CREATE_LARGE_BUBBLE, currentModel_createLargeBubbleeHandler);
			
			super.addListeners();
		}
		
		override public function removeListeners():void
		{
			currentView.currentSprite.removeEventListener(Event.ENTER_FRAME, currentView_enterFrameHandler);
			currentView.parent.removeEventListener(TouchEvent.TOUCH, currentView_touchHandler);
			currentModel.removeEventListener(ModelEvent.REMOVE_LARGE_BUBBLE, currentModel_removeLargeBubbleHandler);
			currentModel.removeEventListener(ModelEvent.OCCURRED_COLLISION, currentModel_occurredCollisionHandler);
			currentModel.removeEventListener(ModelEvent.REMOVE_BUBBLE, currentModel_removeBubbleHandler);
			currentModel.removeEventListener(ModelEvent.GAME_OVER, currentModel_gameOverBubbleHandler);
			currentModel.removeEventListener(ModelEvent.CREATE_LARGE_BUBBLE, currentModel_createLargeBubbleeHandler);
			
			super.removeListeners();
		}
		
		//--------------------------------------------------------------------------
		//
		// PRIVATE SECTION
		//
		//--------------------------------------------------------------------------
		
		private function currentModel_readyHandler(event:ModelEvent):void 
		{
			currentModel.removeEventListener(ModelEvent.READY, currentModel_readyHandler);
			
			currentModel.createBubbles();
			currentView.createBubbles();
			
			isModelReady = true;
			addListeners();
		}
		
		private function currentView_enterFrameHandler(event:Event):void 
		{
			currentModel.checkBorder();
			currentModel.checkCollision();
			currentModel.updateBubblesPosition();
			currentView.updateBubblesPosition();
			currentView.updateScalelargeBubbles();
			currentModel.checkGameOver();
		}
		
		private function currentView_touchHandler(event:TouchEvent):void 
		{
			var touch:Touch = event.getTouch(currentView.parent);
			
			if (touch && touch.phase == TouchPhase.ENDED)
			{
				var point:Point = touch.getLocation(currentView.parent);
				currentModel.createLargeBubble(point.x, point.y);
			}
		}
		
		private function currentModel_removeLargeBubbleHandler(event:ModelEvent):void 
		{
			currentView.removeLargeBubble(event.data.id);
		}
		
		private function currentModel_occurredCollisionHandler(event:ModelEvent):void 
		{
			currentModel.createLargeBubble(event.data.x, event.data.y, event.data.type);
		}
		
		private function currentModel_removeBubbleHandler(event:ModelEvent):void 
		{
			currentView.removeBubble(event.data.id);
		}
		
		private function currentModel_gameOverBubbleHandler(event:ModelEvent):void 
		{
			currentView.dispatchEvent(new ScreenChangeEvent(ScreenChangeEvent.SCREEN_CHANGE, ScreensConstants.GAME_OVER_SCREEN));
		}
		
		private function currentModel_createLargeBubbleeHandler(event:ModelEvent):void 
		{
			currentView.createLargeBubble();
		}
		
		private function get currentModel():GameModel
		{
			if (!_currentModel)
			{
				_currentModel = GameModel(model);
			}
			
			return _currentModel;
		}
		
		private function get currentView():GameView
		{
			if (!_currentView)
			{
				_currentView = GameView(view);
			}
			
			return _currentView;
		}
	}

}