//  FootballPlayers.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/07/15
//  Last Updated:	2012/03/28
//
//  This is the base class for the goat characters.

package aecGames.blitzGame
{
	
	import aecGames.helpers.Vector2D;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class FootballPlayers extends Vehicle
	{
		
		/////  Constructor  /////
		///////////////////////////////////
		//								 //
		//  Shows the standing graphic.  //
		//								 //
		///////////////////////////////////
		
		public function FootballPlayers()
		{
			
			gotoAndStop("stand");
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
		}
		
		private function addedToStageHandler(event:Event):void
		{
			
			trace("x, y", x, y);
			setPos(new Point(x, y));
						
		}
		
		/////  findNextPoint():void  /////
		//////////////////////////////////////////////////////////////////
		//																//
		//  If there are points left in the list, find the next point.  //
		//																//
		//////////////////////////////////////////////////////////////////
		
		public function findNextPoint(point:Point):void
		{
			
			findPoint(new Vector2D(point.x, point.y));
			
		}
		
		/////  findPoint(target:Vector2D):void  /////
		////////////////////////////////////////////////////////
		//													  //
		//	Sets the seek point.  Shows the jumping graphic.  //
		//													  //
		////////////////////////////////////////////////////////
		
		protected override function findPoint(target:Vector2D):void
		{
			
			gotoAndStop("run");
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
		
	}
	
}