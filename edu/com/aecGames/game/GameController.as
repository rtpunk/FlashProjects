//  GameController.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/07
//  Last Updated:	2011/03/27
//
//  This is the base class for the game controllers.

package aecGames.game
{
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import aecGames.gameEvent.GameEvent;
	
	public class GameController extends Sprite
	{
		
		/////  Constructor  /////
		///////////////////////////////////////////////////
		//												 //
		//  I have nothing to declare except my genius.  //
		//												 //
		//  --Oscar Wilde								 //
		//												 //
		///////////////////////////////////////////////////
		
		public function GameController(gameModel:Object, soundModel:Object)
		{			
		}
		
		/////  changeHandler(event:GameEvent):void  /////
		///////////////////////////////////////////////////////////////
		//															 //
		//  ABSTRACT METHOD TO BE OVERRIDDEN BY DERIVATIVE CLASSES.  //
		//															 //
		///////////////////////////////////////////////////////////////
		
		private function changeHandler(event:GameEvent):void
		{
			
			throw(new Error("changeHandler IS AN ABSTRACT METHOD AND SHOULB BE OVERRIDDEN"));
			
		}
		
	}
	
}