package ua.olegPoluliashchenko.bubbles.view 
{
	import core.baseClasses.IView;
	import core.baseClasses.View;
	import ua.olegPoluliashchenko.bubbles.controller.GameOverController;
	import ua.olegPoluliashchenko.bubbles.model.GameOverModel;
	import ua.olegPoluliashchenko.bubbles.view.sprites.GameOverSprite;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class GameOverView extends View implements IView 
	{
		private var _currentModel:GameOverModel;
		private var _currentController:GameOverController;
		private var _currentSprite:GameOverSprite;
		
		public function GameOverView() 
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
			_currentSprite = new GameOverSprite();
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
		
		public function get currentSprite():GameOverSprite
		{
			return _currentSprite;
		}
		
		//--------------------------------------------------------------------------
		//
		// PRIVATE SECTION
		//
		//--------------------------------------------------------------------------
		
		private function get currentModel():GameOverModel
		{
			if (!_currentModel)
			{
				_currentModel = GameOverModel(model);
			}
			
			return _currentModel;
		}
		
		private function get currentController():GameOverController
		{
			if (!_currentController)
			{
				_currentController = GameOverController(controller);
			}
			
			return _currentController;
		}
	}

}