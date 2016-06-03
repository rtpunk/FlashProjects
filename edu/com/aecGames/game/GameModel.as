//  GameModel.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/07
//  Last Updated:	2011/03/27
//
//  This is the base class for the game models.

package aecGames.game
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import aecGames.gameEvent.GameEvent;
	
	public class GameModel extends EventDispatcher
	{
		
		/////  Variable Declaration  /////
		//////////////////////////////////////////////////////////////////////////////
		//																			//
		//	SCREEN_TITLE			-	String value for the title screen.			//
		//  SCREEN_DIRECTIONS		-	String value for the directions screen.		//
		//  SCREEN_PLAYER_SELECT	-	String value for the player select screen.  //
		//  SCREEN_GAME				-	String value for the main game screen.		//
		//  SCREEN_GAME_OVER		-	String value for the game over screen.		//
		//																			//
		//  _screenName				-	The name of the current screen.				//
		//																			//
		//////////////////////////////////////////////////////////////////////////////
		
		public static const SCREEN_TITLE:String = "title screen";
		public static const SCREEN_DIRECTIONS:String = "directions screen";
		public static const SCREEN_PLAYER_SELECT:String = "player select screen";
		public static const SCREEN_GAME:String = "game screen";
		public static const SCREEN_GAME_OVER:String = "game over screen";
		public static const SCREEN_QUESTION:String = "question screen";
		
		protected var _screenName:String = SCREEN_TITLE;
 
		/////  Construcor  /////
		/////////////////////////////////////////////////////////////////////////////////
		//																			   //
		//  I love talking about nothing. It is the only thing I know anything about.  //
		//																			   //
		//  --Oscar Wilde															   //
		//																			   //
		/////////////////////////////////////////////////////////////////////////////////
		
 		public function GameModel()
		{
		}
		
		/////  set currentScreenName(value:String):void  /////
		//////////////////////////////////////////////////////////////////
		//																//
		//  _screenName Setter Method									//
		//  Set the current screen and dispatch a CHANGE_SCREEN event.	//
		//																//
		//////////////////////////////////////////////////////////////////
		
		public function set currentScreenName(value:String):void
		{
			
			_screenName = value;
			dispatchEvent(new GameEvent(GameEvent.CHANGE_SCREEN, true, false, value));
			
		}
		
		/////  get currentScreenName():String  /////
		////////////////////////////////////////////
		//										  //
		//  _screenName Getter Method			  //
		//										  //
		////////////////////////////////////////////
		
		public function get currentScreenName():String
		{
			
			return _screenName;
			
		}
		
	}
	
}