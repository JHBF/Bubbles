package
{
	import core.screenManager.ScreenManager;
	import flash.display.Sprite;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class Main extends Sprite 
	{
		private var mStarling:Starling;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			startStarling();
		}
		
		private function startStarling():void 
		{
			mStarling = new Starling(ScreenManager, stage);
			mStarling.antiAliasing = 1;
			//mStarling.showStats = true;
			mStarling.start();
		}
		
	}
	
}