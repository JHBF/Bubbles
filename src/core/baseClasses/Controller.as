package core.baseClasses 
{
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class Controller implements IController
	{
		public var model:IModel;
		
		public var view:IView;
		
		public function Controller()
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		// PUBLIC SECTION
		//
		//--------------------------------------------------------------------------
		
		public function initialize(model:IModel, view:IView):void
		{
			this.model = model;
			this.view = view;
			
			this.model.initialize();
			this.view.initialize(this, model);
			controllerIn();
			addListeners();
		}
		
		public function controllerIn():void
		{
			
		}
		
		public function destroy():void
		{
			removeListeners();
			view.disposeView();
			model.destroy();
			view = null;
			model = null;
		}
		
		public function addListeners():void
		{
			
		}
		
		public function removeListeners():void
		{
			
		}
	}

}