//  JeopardyGameModel.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/05/17
//  Last Updated:	2011/05/22
//
//  This class holds the data for the jeopardy game.

package aecGames.jeopardyGame
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import aecGames.gameEvent.GameEvent;
	import aecGames.game.GameModel;
	
	public class JeopardyGameModel extends GameModel
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
		
		public const NUM_QUESTIONS:int = 20;
		
		public const NUM_CATEGORIES:int = 4;
		public const NUM_ROWS:int = NUM_QUESTIONS / NUM_CATEGORIES;

		public var questionData:Array = [ [ new Question01(), new Question02(), new Question03(), new Question04(), new Question05() ],
										  [ new Question06(), new Question07(), new Question08(), new Question09(), new Question10() ],
										  [ new Question11(), new Question12(), new Question13(), new Question14(), new Question15() ],
										  [ new Question16(), new Question17(), new Question18(), new Question19(), new Question20() ] ];
							 
		public var answerData:Array = [ [ [ new Answer01_1(), new Answer01_2(), new Answer01_3() ], [ new Answer02_1(), new Answer02_2(), new Answer02_3() ], [ new Answer03_1(), new Answer03_2(), new Answer03_3() ], [ new Answer04_1(), new Answer04_2(), new Answer04_3() ], [ new Answer05_1(), new Answer05_2(), new Answer05_3() ] ],
									    [ [ new Answer06_1(), new Answer06_2(), new Answer06_3() ], [ new Answer07_1(), new Answer07_2(), new Answer07_3() ], [ new Answer08_1(), new Answer08_2(), new Answer08_3() ], [ new Answer09_1(), new Answer09_2(), new Answer09_3() ], [ new Answer10_1(), new Answer10_2(), new Answer10_3() ] ],
										[ [ new Answer11_1(), new Answer11_2(), new Answer11_3() ], [ new Answer12_1(), new Answer12_2(), new Answer12_3() ], [ new Answer13_1(), new Answer13_2(), new Answer13_3() ], [ new Answer14_1(), new Answer14_2(), new Answer14_3() ], [ new Answer15_1(), new Answer15_2(), new Answer15_3() ] ],
										[ [ new Answer16_1(), new Answer16_2(), new Answer16_3() ], [ new Answer17_1(), new Answer17_2(), new Answer17_3() ], [ new Answer18_1(), new Answer18_2(), new Answer18_3() ], [ new Answer19_1(), new Answer19_2(), new Answer19_3() ], [ new Answer20_1(), new Answer20_2(), new Answer20_3() ] ] ];
								  
		public var correctFeedbackData:Array = [ [ new CorrectFeedback01(), new CorrectFeedback02(), new CorrectFeedback03(), new CorrectFeedback04(), new CorrectFeedback05() ],
												 [ new CorrectFeedback06(), new CorrectFeedback07(), new CorrectFeedback08(), new CorrectFeedback09(), new CorrectFeedback10() ],
												 [ new CorrectFeedback11(), new CorrectFeedback12(), new CorrectFeedback13(), new CorrectFeedback14(), new CorrectFeedback15() ],
												 [ new CorrectFeedback16(), new CorrectFeedback17(), new CorrectFeedback18(), new CorrectFeedback19(), new CorrectFeedback20() ] ];
								  
		public var wrongFeedbackData:Array = [ [ new WrongFeedback01(), new WrongFeedback02(), new WrongFeedback03(), new WrongFeedback04(), new WrongFeedback05() ],
											   [ new WrongFeedback06(), new WrongFeedback07(), new WrongFeedback08(), new WrongFeedback09(), new WrongFeedback10() ],
											   [ new WrongFeedback11(), new WrongFeedback12(), new WrongFeedback13(), new WrongFeedback14(), new WrongFeedback15() ],
											   [ new WrongFeedback16(), new WrongFeedback17(), new WrongFeedback18(), new WrongFeedback19(), new WrongFeedback20() ] ];
		
		public var numCorrect:int = 0;
		
		public var currentQuestionIndex:int = -1;
		
		/////  Constructor  /////
		/////////////////////////////////////////////////////////
		//													   //
		//  ...people with nothing to declare carry the most.  //
		//													   //
		//  --Jonathan Safran Foer							   //
		//													   //
		/////////////////////////////////////////////////////////

		public function JeopardyGameModel()
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