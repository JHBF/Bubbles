package core.screenManager 
{
	import core.baseClasses.IController;
	import core.baseClasses.IModel;
	import core.baseClasses.IView;
	import core.embeddedAssets.EmbeddedAssets;
	import core.events.ScreenChangeEvent;
	import core.screens.Screens;
	import core.screens.ScreensConstants;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class ScreenManager extends Sprite 
	{
		private var model:IModel;
		private var controller:IController;
		private var view:IView;
		
		private var currentScreenConstant:String;
		
		public function ScreenManager() 
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, screenManger_addedToStageHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		// PRIVATE SECTION
		//
		//--------------------------------------------------------------------------
		
		private function screenManger_addedToStageHandler(event:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, screenManger_addedToStageHandler);
			
			createMainBackground();
			
			createScreen(ScreensConstants.MAIN_MENU_SCREEN);
			
			addListeners();
		}
		
		private function createMainBackground():void 
		{
			var textureAtlas:TextureAtlas = EmbeddedAssets.textureAtlas;
			var backgroundTexture:Texture = textureAtlas.getTexture("background");
			var backgroundImage:Image = new Image(backgroundTexture);
			
			addChild(backgroundImage);
		}
		
		private function addListeners():void 
		{
			Sprite(view).addEventListener(ScreenChangeEvent.SCREEN_CHANGE, screenManger_screenChangeHandler);
		}
		
		private function removeListeners():void 
		{
			Sprite(view).removeEventListener(ScreenChangeEvent.SCREEN_CHANGE, screenManger_screenChangeHandler);
		}
		
		private function screenManger_screenChangeHandler(event:ScreenChangeEvent):void 
		{
			createScreen(event.screenConstant);
		}
		
		private function createScreen(screensConstants:String):void
		{			
			var screenClassesObject:Object = Screens.getScreensClasses(screensConstants);
			
			if (!screenClassesObject || currentScreenConstant == screensConstants)
			{
				return;
			}
			
			if (controller)
			{
				controller.destroy();
				removeListeners();
			}
			
			currentScreenConstant = screensConstants;
			var newClass:Class;
			
			newClass = Class(screenClassesObject.modelName);
			model = new newClass();
			
			newClass = Class(screenClassesObject.viewName);
			view = new newClass();
			addListeners();
			
			newClass = Class(screenClassesObject.controllerName);
			controller = new newClass();
			
			addChild(Sprite(view));
			controller.initialize(model, view);
		}
	}

}