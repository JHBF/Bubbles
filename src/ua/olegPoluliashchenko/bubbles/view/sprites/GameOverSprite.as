package ua.olegPoluliashchenko.bubbles.view.sprites 
{
	import starling.display.Sprite;
	import ua.olegPoluliashchenko.bubbles.constants.Constants;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class GameOverSprite extends Sprite 
	{
		private var _buttonRestart:Button;
		private var _buttonMenu:Button;
		
		public function GameOverSprite() 
		{
			super();
			
			createButtons();
		}
		
		//--------------------------------------------------------------------------
		//
		// PUBLIC SECTION
		//
		//--------------------------------------------------------------------------
		
		public function get buttonRestart():Button 
		{
			return _buttonRestart;
		}
		
		public function get buttonMenu():Button 
		{
			return _buttonMenu;
		}
		
		//--------------------------------------------------------------------------
		//
		// PRIVATE SECTION
		//
		//--------------------------------------------------------------------------
		
		private function createButtons():void 
		{
			var buttinsContainer:Sprite = new Sprite();
			
			_buttonMenu = new Button(Constants.BUTTON_UP_TEXTURE, Constants.BUTTON_OVER_TEXTURE, Constants.BUTTON_LABEL_MENU);
			buttinsContainer.addChild(_buttonMenu);
			
			_buttonRestart = new Button(Constants.BUTTON_UP_TEXTURE, Constants.BUTTON_OVER_TEXTURE, Constants.BUTTON_LABEL_RESTART);
			_buttonRestart.x = _buttonMenu.width + 20;
			buttinsContainer.addChild(_buttonRestart);
			
			buttinsContainer.x = (720 - buttinsContainer.width) / 2;
			buttinsContainer.y = (480 - buttinsContainer.height) / 2;
			this.addChild(buttinsContainer);
			
		}
		
	}

}