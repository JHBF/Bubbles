package core.baseClasses 
{
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class View extends Sprite implements IView
	{
		public var view:Sprite;
		
		public var model:IModel;
		
		public var controller:IController;
		
		public function View() 
		{
			super();
			
		}
		
		//--------------------------------------------------------------------------
		//
		// PUBLIC SECTION
		//
		//--------------------------------------------------------------------------
		
		public function initialize(controller:IController, model:IModel):void
		{
			this.controller = controller;
			this.model = model;
			
			scrceenIn();
			addListeners();
		}
		
		public function scrceenIn():void
		{
			
		}
		
		public function addListeners():void
		{
			
		}
		
		public function removeListeners():void
		{
			
		}
		
		public function disposeView():void
		{
			removeListeners();
			view = null;
			model = null;
			controller = null;
		}
		
		
	}

}