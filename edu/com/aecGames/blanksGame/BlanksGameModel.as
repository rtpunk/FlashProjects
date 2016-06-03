//  BlanksGameModel.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/29
//  Last Updated:	2011/03/29
//
//  This class holds the data for the blanks game.

package aecGames.blanksGame
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import aecGames.gameEvent.GameEvent;
	import aecGames.game.GameModel;
	
	public class BlanksGameModel extends GameModel
	{
		
		/////  Variable Declaration  /////
		//////////////////////////////////////////////////////////////////////////////////////////
		//																						//
		//  GAME_WIDTH		-	The width of the game stage in pixels.							//
		//  GAME_HEIGHT		-	The height of the game stage in pixels.							//
		//																						//
		//  MAX_TRIES		-	The maximum number of tries before the show me button enables.  //
		//  NUM_QUESTIONS	-	The total number of questions to be asked.						//
		//																						//
		//  questionData	-	Holds the questions.											//
		//  answerData		-	Holds the answers.												//
		//																						//
		//  numTries		-	The number of user attempts.									//
		//  numCorrect		-	The number of boxes correctly placed.							//
		//																						//
		//////////////////////////////////////////////////////////////////////////////////////////
		
		public const GAME_WIDTH:int = 740;
		public const GAME_HEIGHT:int = 600;
		
		public const MAX_TRIES:int = 2;
		public const NUM_QUESTIONS:int = 6;
		public const NUM_ANSWERS:int = 8;

		public var questionData = [ new Question01(),
								    new Question02(),
									new Question03(),
									new Question04(),
									new Question05(),
									new Question06() ];
							 
		public var answerData = [ new Answer01(),
								  new Answer02(),
								  new Answer03(),
								  new Answer04(),
								  new Answer05(),
								  new Answer06(),
								  new Answer07(),
								  new Answer08() ];
		
		public var numTries:int = 0;
		public var numCorrect:int = 0;
		
		/////  Constructor  /////
		/////////////////////////////////////////////////////////
		//													   //
		//  ...people with nothing to declare carry the most.  //
		//													   //
		//  --Jonathan Safran Foer							   //
		//													   //
		/////////////////////////////////////////////////////////

		public function BlanksGameModel()
		{
		}
		
		/////  set checkAnswer(value:Boolean):void  /////
		/////////////////////////////////////////////////
		//											   //
		//  Dispatches CHECK_ANSWER event.			   //
		//											   //
		/////////////////////////////////////////////////
		
		public function set checkAnswer(value:Boolean):void
		{
			
			if(value)
				dispatchEvent(new GameEvent(GameEvent.CHECK_ANSWER, true));
			
		}
		
		/////  set showAnswer(value:Boolean):void  /////
		////////////////////////////////////////////////
		//											  //
		//  Dispatches SHOW_ANSWER event.			  //
		//											  //
		////////////////////////////////////////////////
		
		public function set showAnswer(value:Boolean):void
		{
			
			if(value)
				dispatchEvent(new GameEvent(GameEvent.SHOW_ANSWER, true));
			
		}
		
		/////  set resetAnswer(value:Boolean):void  /////
		/////////////////////////////////////////////////
		//											   //
		//  Dispatches RESET_ANSWER event.			   //
		//											   //
		/////////////////////////////////////////////////
		
		public function set resetAnswer(value:Boolean):void
		{
			
			if(value)
				dispatchEvent(new GameEvent(GameEvent.RESET_ANSWER, true));
			
		}
		
	}
	
}