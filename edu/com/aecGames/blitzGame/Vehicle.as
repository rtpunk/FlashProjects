//  Goat.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/07/15
//  Last Updated:	2012/03/28
//
//  This is the base class for the goat characters.

package aecGames.blitzGame
{
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import aecGames.helpers.Vector2D;
	
	public class Vehicle extends MovieClip
	{
		
		/////  Variable Declaration  /////
		///////////////////////////////////////////////////////////////////////////////////
		//     																		     //
		//	_steeringForce		-	Force that causes goat to move.					 	 //
		//	_maxForce			-	The maximum amount of _steeringForce.			   	 //
		//	_maxSpeed			-	The maximum speed that the goat can have.			 //
		//	_arrivalThreshold	-	How close the goat can be before it starts to slow.	 //
		//	_equalityThreshold	-	How close the goat can be before it has arrived.	 //
		//																				 //
		//	_velocity			-	The velocity vector for the goat.					 //
		//	_position			-	The position vector for the goat.					 //
		//																				 //
		//	_seekPoint			-	The point that the goat is moving toward.			 //
		//																				 //
		///////////////////////////////////////////////////////////////////////////////////
		
		private var _steeringForce:Vector2D;
		private var _maxForce:Number = 1;
		private var _maxSpeed:Number = 5;
		private var _arrivalThreshold:Number = 20;
		private var _equalityThreshold:Number = .5;
		
		private var _velocity:Vector2D;
		private var _position:Vector2D;
		
		private var _seekPoint:Vector2D;
		
		/////  Constructor  /////
		///////////////////////////////
		//							 //
		//  Initialize the vectors.  //
		//							 //
		///////////////////////////////
		
		public function Vehicle()
		{
			
			_position = new Vector2D();
			_velocity = new Vector2D();
			_steeringForce = new Vector2D();
						
		}
		
		/////  update():void  /////
		///////////////////////////////////////////////
		//											 //
		//	Called each frame the goat is moving.	 //
		//	Calculates forces and updates position.	 //
		//											 //
		///////////////////////////////////////////////
		
		private function update():void
		{
			
			//  The maximum value of the steering force is max force.
			//	So, truncate _steeringForce.
			
			//	Add this force to the velocity.
			//	Reset _steeringForce...
			
			_steeringForce.truncate(_maxForce);
			_velocity = _velocity.add(_steeringForce);
			_steeringForce = new Vector2D();
			
			//  Make sure velocity stays within max speed.
			
			_velocity.truncate(_maxSpeed);
			  
			//  Add velocity to position.
			
			_position = _position.add(_velocity);
			  			  
			//  Update position of sprite.
			
			x = _position.x;
			y = _position.y;
			
			//  If the goat has reached the seek point, remove the enter frame handler.
			
			if(_position.equals(_seekPoint))
				foundPoint();
			
		}
		
		/////  findPoint(target:Vector2D):void  /////
		///////////////////////////////////////////////////////////
		//														 //
		//	@param-	target:Vector2D points to target.			 //
		//	Sets the seek point.  Adds the necessary listeners.	 //
		//														 //
		///////////////////////////////////////////////////////////
		
		protected function findPoint(target:Vector2D):void
		{
			
			_seekPoint = target;
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
		}
		
		/////  seekPoint(target:Vector2D):void  /////
		/////////////////////////////////////////////////
		//											   //
		//	@param-	target:Vector2D points to target.  //
		//	Calculates the desired steering force.	   //
		//											   //
		/////////////////////////////////////////////////
		
		private function seekPoint(target:Vector2D):void
		{
			
			//  Calculate the desired direction by finding difference between target and position, normalize.
			
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			
			//	Find the distance to the target.
			//	If greater than arrival threshold:
			//		The magnitude of the desired velocity will be the max speed.
			//	Else:
			//		The magnitude will be reduced by the ratio of distance / threshold.
			
			var dist:Number = _position.dist(target);
			if(dist > _arrivalThreshold)
				desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			else
				desiredVelocity = desiredVelocity.multiply(_maxSpeed * dist / _arrivalThreshold);
			
			//	If close enough, consider the goat arrived and set velocity to 0 and position to target point.
			
			if(dist < _equalityThreshold)
			{
				
				desiredVelocity.zero();
				_position = _seekPoint;
				
			}
			
			//  To reach the desired velocity, we take into account the current velocity.
			//  Add this force to the steering force.
			
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.add(force);
			
		}
		
		/////  enterFrameHandler(event:Event):void  /////
		/////////////////////////////////////////////////
		//											   //
		//	ENTER_FRAME Event Handler				   //
		//  Calculate the neccessary vectors.		   //
		//	Update the position.					   //
		//											   //
		/////////////////////////////////////////////////
		
		private function enterFrameHandler(event:Event):void
		{
			
			seekPoint(_seekPoint);
			update();
			
		}
		
		/////  foundPoint():void  /////
		////////////////////////////////////////
		//									  //
		//  Removes the ENTER_FRAME handler.  //
		//									  //
		////////////////////////////////////////
		
		protected function foundPoint():void
		{
			
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
		}
		
		/////  setPos(value:Point):void  /////
		////////////////////////////////////////
		//									  //
		//  Set the position of the vehicle.  //
		//									  //
		////////////////////////////////////////
		
		public function setPos(value:Point):void
		{
			
			x = _position.x = value.x;
			y = _position.y = value.y;
			
		}
		
	}
	
}