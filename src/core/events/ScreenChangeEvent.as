package core.events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class ScreenChangeEvent extends Event 
	{
		public static const SCREEN_CHANGE:String = "screenChange";
		
		public var screenConstant:String;
		
		public function ScreenChangeEvent(type:String, screenConstant:String, bubbles:Boolean = false, data:Object = null) 
		{
			this.screenConstant = screenConstant;
			
			super(type, bubbles, data);
			
		}
		
	}

}