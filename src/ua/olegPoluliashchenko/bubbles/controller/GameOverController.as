package ua.olegPoluliashchenko.bubbles.controller 
{
	import core.baseClasses.Controller;
	import core.baseClasses.IController;
	import core.events.ScreenChangeEvent;
	import core.screens.ScreensConstants;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import ua.olegPoluliashchenko.bubbles.model.GameOverModel;
	import ua.olegPoluliashchenko.bubbles.view.GameOverView;
	import ua.olegPoluliashchenko.bubbles.view.sprites.Button;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class GameOverController extends Controller implements IController 
	{
		private var _currentModel:GameOverModel;
		private var _currentView:GameOverView;
		
		public function GameOverController() 
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
			_currentModel = null;
			_currentView = null;
			
			super.destroy();
		}
		
		override public function addListeners():void
		{
			currentView.currentSprite.buttonMenu.addEventListener(TouchEvent.TOUCH, currentView_touchHandler);
			currentView.currentSprite.buttonRestart.addEventListener(TouchEvent.TOUCH, currentView_touchHandler);
			
			super.addListeners();
		}
		
		override public function removeListeners():void
		{
			currentView.currentSprite.buttonMenu.removeEventListener(TouchEvent.TOUCH, currentView_touchHandler);
			currentView.currentSprite.buttonRestart.removeEventListener(TouchEvent.TOUCH, currentView_touchHandler);
			
			super.removeListeners();
		}
		
		//--------------------------------------------------------------------------
		//
		// PRIVATE SECTION
		//
		//--------------------------------------------------------------------------
		
		private function currentView_touchHandler(event:TouchEvent):void 
		{
			var button:Button = Button(event.currentTarget);
			
			var touch:Touch = event.getTouch(button);
			
			if (touch && (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.BEGAN))
			{
				button.isButtonOver = true;
			}
			else if (touch && touch.phase == TouchPhase.ENDED)
			{
				button.isButtonOver = true;
				
				event.stopPropagation();
				
				if (button == currentView.currentSprite.buttonMenu)
				{
					currentView.dispatchEvent(new ScreenChangeEvent(ScreenChangeEvent.SCREEN_CHANGE, ScreensConstants.MAIN_MENU_SCREEN));
				}
				else if(button == currentView.currentSprite.buttonRestart)
				{
					currentView.dispatchEvent(new ScreenChangeEvent(ScreenChangeEvent.SCREEN_CHANGE, ScreensConstants.GAME_SCREEN));
				}
			}
			else
			{
				button.isButtonOver = false;
			}
		}
		
		private function get currentModel():GameOverModel
		{
			if (!_currentModel)
			{
				_currentModel = GameOverModel(model);
			}
			
			return _currentModel;
		}
		
		private function get currentView():GameOverView
		{
			if (!_currentView)
			{
				_currentView = GameOverView(view);
			}
			
			return _currentView;
		}
	}

}