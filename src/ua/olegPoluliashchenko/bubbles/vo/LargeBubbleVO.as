package ua.olegPoluliashchenko.bubbles.vo 
{
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class LargeBubbleVO extends BubbleVO 
	{
		private var _scale:Number;
		private var _stepScale:Number;
		
		public function LargeBubbleVO() 
		{
			super();
			
		}
		
		//--------------------------------------------------------------------------
		//
		// PUBLIC SECTION
		//
		//--------------------------------------------------------------------------
		
		public function get scale():Number 
		{
			return _scale;
		}
		
		public function set scale(value:Number):void 
		{
			_scale = value;
		}
		
		public function get stepScale():Number 
		{
			return _stepScale;
		}
		
		public function set stepScale(value:Number):void 
		{
			_stepScale = value;
		}
		
	}

}