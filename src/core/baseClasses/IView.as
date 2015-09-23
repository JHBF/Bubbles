package core.baseClasses 
{
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public interface IView 
	{
		function initialize(controller:IController, model:IModel):void;
		function scrceenIn():void;
		function addListeners():void;
		function removeListeners():void;
		function disposeView():void;
	}
	
}