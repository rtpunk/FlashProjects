//  MountainClimberGameModel.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/27
//  Last Updated:	2011/03/28
//
//  This class holds the data for the mountain climber game.

package aecGames.mountainClimberGame
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import aecGames.gameEvent.GameEvent;
	import aecGames.game.GameModel;
	
	public class MountainClimberGameModel extends GameModel
	{
		
		/////  Variable Declaration  /////
		//////////////////////////////////////////////////////////////////////////////
		//																			//
		//  GAME_WIDTH				-	The width of the game stage in pixels.		//
		//  GAME_HEIGHT				-	The height of the game stage in pixels.		//
		//																			//
		//  NUM_QUESTIONS			-	The total number of questions to be asked.  //
		//																			//
		//  PLAYER_POINTS			-	Holds the player's path points.				//
		//  COMPUTER_POINTS			-	Holds the computer's path points.			//
		//																			//
		//  questionData			-	Holds the questions.						//
		//  answerData				-	Holds the answers.							//
		//  hintData				-	Holds the hints.							//
		//																			//
		//  numCorrect				-	The number of boxes correctly placed.		//
		//																			//
		//  _currentQuestionIndex	-	The array index of the current question.	//
		//  _displayHint			-	Whether to display the hint box or not.		//
		//																			//
		//////////////////////////////////////////////////////////////////////////////
		
		public const GAME_WIDTH:int = 780;
		public const GAME_HEIGHT:int = 580;
		
		public const NUM_QUESTIONS:int = 10;
		
		public const PLAYER_POINTS:Array = [ new Point(380, 460),
											 new Point(412, 440),
							  				 new Point(443, 419),
											 new Point(468, 395),
											 new Point(493, 367),
											 new Point(513, 337),
											 new Point(529, 307),
											 new Point(542, 278),
											 new Point(552, 248),
											 new Point(561, 217),
											 new Point(570, 185) ];
												
		public const COMPUTER_POINTS:Array = [ new Point(700, 460),
										 	   new Point(674, 440),
											   new Point(655, 419),
											   new Point(637, 395),
											   new Point(621, 367),
											   new Point(608, 337),
											   new Point(597, 307),
											   new Point(589, 278),
											   new Point(581, 248),
											   new Point(576, 217),
											   new Point(570, 185) ];

		public var questionData:Array = [ new Question01(),
										  new Question02(),
										  new Question03(),
										  new Question04(),
										  new Question05(),
										  new Question06(),
										  new Question07(),
										  new Question08(),
										  new Question09(),
										  new Question10() ];
											
		public var answerData:Array = [ [new Answer01_1(), new Answer01_2(), new Answer01_3(), new Answer01_4()],
										[new Answer02_1(), new Answer02_2(), new Answer02_3(), new Answer02_4()],
										[new Answer03_1(), new Answer03_2(), new Answer03_3(), new Answer03_4()],
										[new Answer04_1(), new Answer04_2(), new Answer04_3(), new Answer04_4()],
										[new Answer05_1(), new Answer05_2(), new Answer05_3(), new Answer05_4()],
										[new Answer06_1(), new Answer06_2(), new Answer06_3(), new Answer06_4()],
										[new Answer07_1(), new Answer07_2(), new Answer07_3(), new Answer07_4()],
										[new Answer08_1(), new Answer08_2(), new Answer08_3(), new Answer08_4()],
										[new Answer09_1(), new Answer09_2(), new Answer09_3(), new Answer09_4()],
										[new Answer10_1(), new Answer10_2(), new Answer10_3(), new Answer10_4()] ];
										
		public var hintData:Array = [ new Hint01(),
									  new Hint02(),
									  new Hint03(),
									  new Hint04(),
									  new Hint05(),
									  new Hint06(),
									  new Hint07(),
									  new Hint08(),
									  new Hint09(),
									  new Hint10() ];
									  
		public var numCorrect:int = 0;
		
		private var _useHints:Boolean = true;
		private var _currentQuestionIndex:int = 0;
		private var _displayHint:Boolean = false;

		/////  Constructor  /////
		/////////////////////////////////////////////////////////////////////////////
		//																		   //
		//  I know only that it is time for me to be something when I am nothing.  //
		//																		   //
		//  --Patrick Branwell Brontë											   //
		//																		   //
		/////////////////////////////////////////////////////////////////////////////

		public function MountainClimberGameModel()
		{
		}
		
		/////  resetGame():void  /////
		////////////////////////////////////
		//								  //
		//  Dispatches RESET_GAME event.  //
		//								  //
		////////////////////////////////////
		
		public function resetGame():void
		{
			
			dispatchEvent(new GameEvent(GameEvent.RESET_GAME, true));
			
		}
		
		/////  nextQuestion():void  /////
		//////////////////////////////////////////////////////////////////////
		//																	//
		//  Increment the question index and dispatch NEXT_QUESTION event.  //
		//																	//
		//////////////////////////////////////////////////////////////////////
		
		public function nextQuestion():void
		{
			
			++_currentQuestionIndex;
			dispatchEvent(new GameEvent(GameEvent.NEXT_QUESTION, true));
			
		}
		
		/////  resetQuestions():void  /////
		/////////////////////////////////////////////////////
		//												   //
		//  Reset the correct counter and question index.  //
		//												   //
		/////////////////////////////////////////////////////
		
		public function resetQuestions():void
		{
			
			numCorrect = 0;
			_currentQuestionIndex = 0;
			
		}
		
		/////  get currentQuestionIndex():int  /////
		////////////////////////////////////////////
		//										  //
		//  _currentQuestionIndex Getter Method	  //
		//										  //
		////////////////////////////////////////////
		
		public function get currentQuestionIndex():int
		{
			
			return _currentQuestionIndex;
			
		}
		
		/////  set displayHint(value:Boolean):void  /////
		/////////////////////////////////////////////////
		//											   //
		//  _displayHint Setter Method				   //
		//  Dispatch SHOW_HINT event.				   //
		//											   //
		/////////////////////////////////////////////////
		
		public function set displayHint(value:Boolean):void
		{
			
			_displayHint = value;
			dispatchEvent(new GameEvent(GameEvent.SHOW_HINT, true));
			
		}
		
		/////  get displayHint():Boolean  /////
		///////////////////////////////////////
		//									 //
		//  _displayHint Getter Method		 //
		//									 //
		///////////////////////////////////////
		
		public function get displayHint():Boolean
		{
			
			return _displayHint;
			
		}
		
		/////  get useHints():Boolean /////
		///////////////////////////////////
		//								 //
		//  _useHints Getter Method		 //
		//								 //
		///////////////////////////////////
		
		public function get useHints():Boolean
		{
			
			return _useHints;
			
		}
		
	}
	
}