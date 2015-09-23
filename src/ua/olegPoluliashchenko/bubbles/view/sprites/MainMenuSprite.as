package ua.olegPoluliashchenko.bubbles.view.sprites 
{
	import starling.display.Sprite;
	import ua.olegPoluliashchenko.bubbles.constants.Constants;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class MainMenuSprite extends Sprite 
	{
		private var _button:Button;
		
		public function MainMenuSprite() 
		{
			super();
			
			createButton();
		}
		
		//--------------------------------------------------------------------------
		//
		// PUBLIC SECTION
		//
		//--------------------------------------------------------------------------
		
		public function get button():Button 
		{
			return _button;
		}
		
		//--------------------------------------------------------------------------
		//
		// PRIVATE SECTION
		//
		//--------------------------------------------------------------------------
		
		private function createButton():void 
		{
			_button = new Button(Constants.BUTTON_UP_TEXTURE, Constants.BUTTON_OVER_TEXTURE, Constants.BUTTON_LABEL_START);
			_button.x = (720 - _button.width) / 2;
			_button.y = (480 - _button.height) / 2;
			this.addChild(_button);
		}
		
	}

}