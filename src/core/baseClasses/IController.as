package core.baseClasses 
{
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public interface IController 
	{
		function initialize(model:IModel, view:IView):void;
		function controllerIn():void;
		function destroy():void;
		function addListeners():void;
		function removeListeners():void;
	}
	
}