//  ThreeColumnGameModel.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/05/14
//  Last Updated:	2011/05/14
//
//  This class holds the data for the 3 column game.

package aecGames.threeColumnGame
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import aecGames.gameEvent.GameEvent;
	import aecGames.game.GameModel;
	
	public class ThreeColumnGameModel extends GameModel
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
		
		public const GAME_WIDTH:int = 800;
		public const GAME_HEIGHT:int = 600;
		
		public const MAX_TRIES:int = 2;

		public var cat1AnswerData = [ new Cat1Answer01(),
									  new Cat1Answer02(),
									  new Cat1Answer03(),
									  new Cat1Answer04(),
									  new Cat1Answer05() ];
							 
		public var cat2AnswerData = [ new Cat2Answer01(),
									  new Cat2Answer02(),
									  new Cat2Answer03(),
									  new Cat2Answer04(),
									  new Cat2Answer05() ];
							 
		public var cat3AnswerData = [ new Cat3Answer01(),
									  new Cat3Answer02(),
									  new Cat3Answer03(),
									  new Cat3Answer04(),
									  new Cat3Answer05() ];
									  
		public const NUM_ANSWERS:int = cat1AnswerData.length + cat2AnswerData.length + cat3AnswerData.length;
		
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

		public function ThreeColumnGameModel()
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