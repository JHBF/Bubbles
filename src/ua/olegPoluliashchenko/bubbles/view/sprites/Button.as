package ua.olegPoluliashchenko.bubbles.view.sprites 
{
	import core.embeddedAssets.EmbeddedAssets;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class Button extends Sprite 
	{
		private var textureButtonUp:Texture;
		private var textureButtonOver:Texture;
		
		private var imageButtonUp:Image;
		private var imageButtonOver:Image;
		private var textField:TextField;
		
		private var _isButtonOver:Boolean;
		private var label:String
		
		public function Button(buttonUpTextureName:String, buttonOverTextureName:String, label:String) 
		{
			super();
			
			this.textureButtonUp = EmbeddedAssets.textureAtlas.getTexture(buttonUpTextureName);
			this.textureButtonOver = EmbeddedAssets.textureAtlas.getTexture(buttonOverTextureName);
			this.label = label;
			
			createButton();
		}
		
		//--------------------------------------------------------------------------
		//
		// PUBLIC SECTION
		//
		//--------------------------------------------------------------------------
		
		public function set isButtonOver(value:Boolean):void 
		{
			_isButtonOver = value;
			
			imageButtonUp.visible = !_isButtonOver;
			imageButtonOver.visible = _isButtonOver;
		}
		
		//--------------------------------------------------------------------------
		//
		// PRIVATE SECTION
		//
		//--------------------------------------------------------------------------
		
		private function createButton():void
		{
			_isButtonOver = false;
			
			imageButtonUp = new Image(textureButtonUp);
			imageButtonOver = new Image(textureButtonOver);
			
			imageButtonUp.visible = !_isButtonOver;
			imageButtonOver.visible = _isButtonOver;
			
			textField = new TextField(imageButtonUp.width, imageButtonUp.height, label, "Verdana", 24, 0xFFFFFF);
			
			this.addChild(imageButtonOver);
			this.addChild(imageButtonUp);
			this.addChild(textField);
		}
		
	}

}