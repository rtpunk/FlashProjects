//  GameEvent.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/07
//  Last Updated:	2011/03/28
//
//  This class extends the functionality of the Event class to pass data.
//  It also contains the definitions for event types.

package aecGames.gameEvent
{
	
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		
		/////  Variable Declaration  /////
		///////////////////////////////////////////////////////////////////////////////////////////
		//																						 //
		//  CHANGE_SCREEN	-	EVENT TYPE: Current screen has been changed.					 //
		//  RELEASE_ELEMENT	-	EVENT TYPE: A draggable element has been released on the stage.  //
		//  CHECK_ANSWER	-	EVENT TYPE: Request to check the answers of a game.				 //
		//  SHOW_ANSWER		-	EVENT TYPE: Request to show the answers of a game.				 //
		//  RESET_ANSWER	-	EVENT TYPE: Reset answers to their original positions.			 //
		//  SHOW_HINT		-	EVENT TYPE: Request to show the hints for a game.				 //
		//  NEXT_QUESTION	-	EVENT TYPE: Request to show next question in the list.			 //
		//  RESET_GAME		-	EVENT TYPE: Request for the game to reset to initial.			 //
		//  DRAW_SCORE		-	EVENT TYPE: Request for the game to draw the score.				 //
		//																						 //
		//  PLAY_SOUND		-	SOUND EVENT TYPE: Request for sound to play.					 //
		//  PAUSE_SOUND		-	SOUND EVENT TYPE: Request for sound to pause.					 //
		//  STOP_SOUND		-	SOUND EVENT TYPE: Request for sound to stop.					 //
		//  SOUND_COMPLETE	-	SOUND EVENT TYPE: Dispatched when a sound has reached its end.	 //
		//																						 //
		//  _data			-	Object to be passed by the event.								 //
		//																						 //
		///////////////////////////////////////////////////////////////////////////////////////////
		
		public static const CHANGE_SCREEN:String = "change screen";
		public static const RELEASE_ELEMENT:String = "release element";
		public static const CHECK_ANSWER:String = "check answer";
		public static const SHOW_ANSWER:String = "show answer";
		public static const RESET_ANSWER:String = "reset answer";
		public static const SHOW_HINT:String = "show hint";
		public static const NEXT_QUESTION:String = "next question";
		public static const RESET_GAME:String = "reset game";
		public static const DRAW_SCORE:String = "draw score";
		
		public static const PLAY_SOUND:String = "play sound";
		public static const PAUSE_SOUND:String = "pause sound";
		public static const STOP_SOUND:String = "stop sound";
		public static const SOUND_COMPLETE:String = "sound complete";
		
		private var _data:Object;
		
		/////  Constructor  /////
		///////////////////////////////////////////////////////////////////////////////
		//																			 //
		//  @param - type:String				- The GameEvent type.				 //
		//  @param - bubbles:Boolean = false	- Needed for the super constructor.  //
		//  @param - cancelable:Boolean = false - Needed for the super constructor.  //
		//  @param - data:Object = null			- Object to be passed by the event.  //
		//																			 //
		///////////////////////////////////////////////////////////////////////////////
		
		public function GameEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:Object = null)
		{
			
			_data = data;
			super(type, bubbles, cancelable);
			
		}
		
		/////  get data():Object  /////
		///////////////////////////////
		//							 //
		//  _data Getter Method		 //
		//							 //
		///////////////////////////////
		
		public function get data():Object
		{
			
			return _data;
			
		}

	}
	
}
