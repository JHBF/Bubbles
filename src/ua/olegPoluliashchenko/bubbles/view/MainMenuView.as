package ua.olegPoluliashchenko.bubbles.view 
{
	import core.baseClasses.IView;
	import core.baseClasses.View;
	import ua.olegPoluliashchenko.bubbles.controller.MainMenuController;
	import ua.olegPoluliashchenko.bubbles.model.MainMenuModel;
	import ua.olegPoluliashchenko.bubbles.view.sprites.MainMenuSprite;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class MainMenuView extends View implements IView 
	{
		private var _currentModel:MainMenuModel;
		private var _currentController:MainMenuController;
		private var _currentSprite:MainMenuSprite;
		
		public function MainMenuView() 
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
			_currentSprite = new MainMenuSprite();
			view = _currentSprite;
			
			addChild(_currentSprite);
			
			super.scrceenIn();
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
			view.dispose();
			removeChild(_currentSprite);
			
			_currentModel = null;
			_currentController = null;
			_currentSprite = null;
			
			super.disposeView();
		}
		
		//--------------------------------------------------------------------------
		//
		// PUBLIC SECTION
		//
		//--------------------------------------------------------------------------
		
		public function get currentSprite():MainMenuSprite
		{
			return _currentSprite;
		}
		
		//--------------------------------------------------------------------------
		//
		// PRIVATE SECTION
		//
		//--------------------------------------------------------------------------
		
		private function get currentModel():MainMenuModel
		{
			if (!_currentModel)
			{
				_currentModel = MainMenuModel(model);
			}
			
			return _currentModel;
		}
		
		private function get currentController():MainMenuController
		{
			if (!_currentController)
			{
				_currentController = MainMenuController(controller);
			}
			
			return _currentController;
		}
		
	}

}