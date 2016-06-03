//  Goat.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/07/15
//  Last Updated:	2012/03/28
//
//  This is the base class for the goat characters.

package aecGames.mountainClimberGame
{
	
	import aecGames.helpers.Vector2D;
	
	public class Goat extends Vehicle
	{
		
		/////  Variable Declaration  /////
		/////////////////////////////////////////////////////////////////
		//     														   //
		//  _pointList		-	Holds the point path to be followed.   //
		//  _currentPoint	-	The index array of the current point.  //
		//															   //
		/////////////////////////////////////////////////////////////////
		
		private var _pointList:Array = [];
		private var _currentPoint:int = 0;
		
		/////  Constructor  /////
		///////////////////////////////////
		//								 //
		//  Shows the standing graphic.  //
		//								 //
		///////////////////////////////////
		
		public function Goat()
		{
			
			gotoAndStop("stand");
			super();
						
		}
		
		/////  findNextPoint():void  /////
		//////////////////////////////////////////////////////////////////
		//																//
		//  If there are points left in the list, find the next point.  //
		//																//
		//////////////////////////////////////////////////////////////////
		
		public function findNextPoint():void
		{
			
			_currentPoint += int(_currentPoint != _pointList.length);
			findPoint(new Vector2D(_pointList[_currentPoint].x, _pointList[_currentPoint].y));
			
		}
		
		/////  findPoint(target:Vector2D):void  /////
		////////////////////////////////////////////////////////
		//													  //
		//	Sets the seek point.  Shows the jumping graphic.  //
		//													  //
		////////////////////////////////////////////////////////
		
		protected override function findPoint(target:Vector2D):void
		{
			
			gotoAndStop("jump");
			super.findPoint(target);
			
		}
		
		/////  foundPoint():void  /////
		///////////////////////////////////
		//								 //
		//  Shows the standing graphic.  //
		//								 //
		///////////////////////////////////
		
		protected override function foundPoint():void
		{
			
			gotoAndStop("stand");
			super.foundPoint();
			
		}
		
		/////  set pointList(value:Array):void  /////
		/////////////////////////////////////////////
		//										   //
		//  Sets the path the goat should follow.  //
		//										   //
		/////////////////////////////////////////////
		
		public function set pointList(value:Array):void
		{
			
			_pointList = value;
			
		}
		
		/////  resetPosition():void  /////
		////////////////////////////////////////////////////////////////////
		//																  //
		//  Reset the current point index and reset the goat's position.  //
		//																  //
		////////////////////////////////////////////////////////////////////
		
		public function resetPosition():void
		{
			
			_currentPoint = 0;
			setPos(_pointList[_currentPoint]);
			
		}

	}
	
}