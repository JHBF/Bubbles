package ua.olegPoluliashchenko.bubbles.controller 
{
	import core.baseClasses.Controller;
	import core.baseClasses.IController;
	import core.events.ScreenChangeEvent;
	import core.screens.ScreensConstants;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import ua.olegPoluliashchenko.bubbles.model.MainMenuModel;
	import ua.olegPoluliashchenko.bubbles.view.MainMenuView;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class MainMenuController extends Controller implements IController 
	{
		private var _currentModel:MainMenuModel;
		private var _currentView:MainMenuView;
		
		public function MainMenuController()
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
			currentView.currentSprite.button.addEventListener(TouchEvent.TOUCH, mainMenuSprite_touchHandler);
			
			super.addListeners();
		}
		
		override public function removeListeners():void
		{
			currentView.currentSprite.button.removeEventListener(TouchEvent.TOUCH, mainMenuSprite_touchHandler);
			
			super.removeListeners();
		}
		
		//--------------------------------------------------------------------------
		//
		// PRIVATE SECTION
		//
		//--------------------------------------------------------------------------
		
		private function mainMenuSprite_touchHandler(event:TouchEvent):void 
		{
			var touch:Touch = event.getTouch(currentView.currentSprite.button);
			
			if (touch && (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.BEGAN))
			{
				currentView.currentSprite.button.isButtonOver = true;
			}
			else if (touch && touch.phase == TouchPhase.ENDED)
			{
				currentView.currentSprite.button.isButtonOver = true;
				event.stopPropagation();
				currentView.dispatchEvent(new ScreenChangeEvent(ScreenChangeEvent.SCREEN_CHANGE, ScreensConstants.GAME_SCREEN));
			}
			else
			{
				currentView.currentSprite.button.isButtonOver = false;
			}
		}
		
		private function get currentModel():MainMenuModel
		{
			if (!_currentModel)
			{
				_currentModel = MainMenuModel(model);
			}
			
			return _currentModel;
		}
		
		private function get currentView():MainMenuView
		{
			if (!_currentView)
			{
				_currentView = MainMenuView(view);
			}
			
			return _currentView;
		}
	}

}