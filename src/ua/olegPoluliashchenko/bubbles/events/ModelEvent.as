package ua.olegPoluliashchenko.bubbles.events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class ModelEvent extends Event 
	{
		public static const REMOVE_LARGE_BUBBLE:String = "removeLargeBubble";
		public static const REMOVE_BUBBLE:String = "removeBubble";
		public static const OCCURRED_COLLISION:String = "occurredCollision";
		public static const GAME_OVER:String = "gameOver";
		public static const CREATE_LARGE_BUBBLE:String = "createLargeBubble";
		public static const READY:String = "ready";
		
		public function ModelEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			
		}
		
	}

}