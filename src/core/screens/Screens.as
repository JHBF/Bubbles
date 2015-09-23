package core.screens 
{
	import flash.utils.Dictionary;
	import ua.olegPoluliashchenko.bubbles.controller.GameController;
	import ua.olegPoluliashchenko.bubbles.controller.GameOverController;
	import ua.olegPoluliashchenko.bubbles.controller.MainMenuController;
	import ua.olegPoluliashchenko.bubbles.model.GameModel;
	import ua.olegPoluliashchenko.bubbles.model.GameOverModel;
	import ua.olegPoluliashchenko.bubbles.model.MainMenuModel;
	import ua.olegPoluliashchenko.bubbles.view.GameOverView;
	import ua.olegPoluliashchenko.bubbles.view.GameView;
	import ua.olegPoluliashchenko.bubbles.view.MainMenuView;
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class Screens 
	{
		private static var _screensClassesList:Dictionary = new Dictionary();
		
		_screensClassesList[ScreensConstants.MAIN_MENU_SCREEN] = { viewName:MainMenuView, controllerName:MainMenuController, modelName:MainMenuModel };
		_screensClassesList[ScreensConstants.GAME_SCREEN] = { viewName:GameView, controllerName:GameController, modelName:GameModel };
		_screensClassesList[ScreensConstants.GAME_OVER_SCREEN] = { viewName:GameOverView, controllerName:GameOverController, modelName:GameOverModel };
		
		//--------------------------------------------------------------------------
		//
		// PUBLIC SECTION
		//
		//--------------------------------------------------------------------------
		
		public static function getScreensClasses(screensConstants:String):Object 
		{
			return _screensClassesList[screensConstants];
		}
		
	}

}