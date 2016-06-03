//  CategorizeGameModel.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/27
//  Last Updated:	2011/04/09
//
//  This class holds the data for the matching game.

package aecGames.categorizeGame
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import aecGames.gameEvent.GameEvent;
	import aecGames.game.GameModel;
	
	public class CategorizeGameModel extends GameModel
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
		
		public const GAME_WIDTH:int = 580;
		public const GAME_HEIGHT:int = 580;
		
		public const MAX_TRIES:int = 2;
		public const NUM_ANSWERS:int = 12;
		public const NUM_COLS:int = 4;
		
		public var cat1AnswerData = [ new Cat1Answer01(),
									  new Cat1Answer02(),
									  new Cat1Answer03(),
									  new Cat1Answer04(),
									  new Cat1Answer05(),
									  new Cat1Answer06(),
									  new Cat1Answer07() ];

		public var cat2AnswerData = [ new Cat2Answer01(),
									  new Cat2Answer02(),
									  new Cat2Answer03(),
									  new Cat2Answer04(),
									  new Cat2Answer05() ];
		
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

		public function CategorizeGameModel()
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