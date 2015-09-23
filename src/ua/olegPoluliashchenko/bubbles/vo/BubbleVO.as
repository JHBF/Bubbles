package ua.olegPoluliashchenko.bubbles.vo 
{
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class BubbleVO 
	{
		private var _x:Number;
		private var _y:Number;
		private var _type:Number;
		private var _radius:Number;
		private var _rotation:Number;
		private var _cos:Number;
		private var _sin:Number;
		private var _speed:Number;
		
		public function BubbleVO() 
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		// PUBLIC SECTION
		//
		//--------------------------------------------------------------------------
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
		}
		
		public function get type():Number 
		{
			return _type;
		}
		
		public function set type(value:Number):void 
		{
			_type = value;
		}
		
		public function get radius():Number 
		{
			return _radius;
		}
		
		public function set radius(value:Number):void 
		{
			_radius = value;
		}
		
		public function get rotation():Number 
		{
			return _rotation;
		}
		
		public function set rotation(value:Number):void 
		{
			_rotation = value;
		}
		
		public function get cos():Number 
		{
			return _cos;
		}
		
		public function set cos(value:Number):void 
		{
			_cos = value;
		}
		
		public function get sin():Number 
		{
			return _sin;
		}
		
		public function set sin(value:Number):void 
		{
			_sin = value;
		}
		
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
		}
		
	}

}