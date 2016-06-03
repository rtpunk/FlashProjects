//  BongoBingoGameController.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/04/20
//  Last Updated:	2011/04/23
//
//  This class controls the game actions and contains the game elements for the bongo bingo game.

package aecGames.bongoBingoGame
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import aecGames.sounds.SoundModel;
	import aecGames.sounds.SoundView;
	import aecGames.buttons.GUIButton;
	import aecGames.boxes.ClickBox;
	import aecGames.boxes.InfoBox;
	import aecGames.gameEvent.GameEvent;
	import aecGames.helpers.Randomize;
	import aecGames.game.GameController;
	import aecGames.game.GameModel;
	import aecGames.text.GUITextField;
	import flash.geom.Point;
	import flash.filters.GlowFilter;
	
	public class BongoBingoGameController extends GameController
	{
		
		/////  Variable Declaration  /////
		/////////////////////////////////////////////////////////////////////////////
		//																		   //
		//  _soundModel				-	Instance of the sound model.			   //
		//  _gameModel				-	Instance of the game model.				   //
		//																		   //
		//  _soundController		-	Instance of the sound controller.		   //
		//  _buttonController		-	Instance of the button controller.		   //
		//																		   //
		//  _mainBackground			-	Instance of the main background.		   //
		//  _playerSelectBackground	-	Instance of the player select background.  //
		//																		   //
		//  _border					-	Instance of the border.					   //
		//																		   //
		//  _player					-	Reference to the player's goat.			   //
		//  _computer				-	Reference to the computer's goat.		   //
		//																		   //
		//  _questionBox			-	Display area for the questions.			   //
		//  _hintBox				-	Display area for the hints.				   //
		//																		   //
		//  _clickList				-	Holds the click boxes.					   //
		//																		   //
		/////////////////////////////////////////////////////////////////////////////
		
		private var _soundModel:SoundModel;
		private var _gameModel:BongoBingoGameModel;
		
		private var _soundController:SoundView;
		private var _buttonController:BongoBingoButtonController;
		
		private var _mainBackground:MainBackground;
		
		private var _scoreText:GUITextField;
		
		private var _border:Border;
		
		private var _questionBox:InfoBox;
		
		private var _footballPlayers:FootballPlayers;
		
		private var _clickList:Array = [];
		
		/////  Constructor  /////
		///////////////////////////////////////////////////////////////////////////
		//																		 //
		//  @param - gameModel:Object  - An instance of the game's game model.	 //
		//  @param - soundModel:Object - An instance of the game's sound model.  //
		//																		 //
		///////////////////////////////////////////////////////////////////////////
		
		public function BongoBingoGameController(gameModel:Object, soundModel:Object)
		{
			
			super(gameModel, soundModel);
			_soundModel = soundModel as SoundModel;
			_gameModel = gameModel as BongoBingoGameModel;
			
			_soundController = new SoundView(_soundModel);
			_buttonController = new BongoBingoButtonController(_gameModel, _soundModel);
						
			_border = new Border();
			_border.width = _gameModel.GAME_WIDTH;
			_border.height = _gameModel.GAME_HEIGHT;
			
			_gameModel.addEventListener(GameEvent.CHANGE_SCREEN, changeHandler);
			changeHandler(new GameEvent(GameEvent.CHANGE_SCREEN, false, false, GameModel.SCREEN_TITLE));
			
		}
		
		/////  changeScreenHandler(event:GameEvent):void  /////
		//////////////////////////////////////////////////////////
		//														//
		//  Called when the model's current screen is changed.  //
		//														//
		//////////////////////////////////////////////////////////
		
		private function changeHandler(event:GameEvent):void
		{
			
			while(numChildren)
			{
				
				removeChildAt(numChildren - 1);
				
			}
			
			switch(event.data)
			{
				
				case GameModel.SCREEN_TITLE:
					drawTitleScreen();
					break;
					
				case GameModel.SCREEN_DIRECTIONS:
					drawDirectionsScreen();
					break;
					
				case GameModel.SCREEN_GAME:
					drawGameScreen();
					break;
					
				default:
					throw(new Error("SCREEN NAME NOT RECOGNIZED:", event.data));
				
			}
			
			var gameMask:Sprite = new Sprite();
			gameMask.graphics.beginFill(0x000000);
			gameMask.graphics.drawRect(0, 0, _gameModel.GAME_WIDTH, _gameModel.GAME_HEIGHT);
			gameMask.graphics.endFill();
			
			addChild(gameMask);
			
			mask = gameMask;
			
		}
		
		/////  drawTitleScreen():void  /////
		////////////////////////////////////////////////
		//											  //
		//  Draws the elements for the title screen.  //
		//											  //
		////////////////////////////////////////////////
		
		protected function drawTitleScreen():void
		{
			
			var titleBackground:TitleBackground = new TitleBackground();
			
			addChild(titleBackground);
			addChild(_border);
			addChild(_buttonController.directionsButton);
			addChild(_buttonController.startButton);
			
		}
		
		/////  drawDirectionsScreen():void  /////
		////////////////////////////////////////////////////
		//												  //
		//  Draws the elements of the directions screen.  //
		//												  //
		////////////////////////////////////////////////////
		
		protected function drawDirectionsScreen():void
		{
			
			var directionsBackground:DirectionsBackground = new DirectionsBackground();
			
			addChild(directionsBackground);
			addChild(_border);
			addChild(_buttonController.dPauseButton);
			addChild(_buttonController.dPlayButton);
			addChild(_buttonController.dReplayButton);
			addChild(_buttonController.startButton);
			
		}
		
		/////  drawGameScreen():void  /////
		///////////////////////////////////////////////////
		//												 //
		//  Draws the elements of the main game screen.  //
		//												 //
		///////////////////////////////////////////////////
		
		protected function drawGameScreen():void
		{
			
			_mainBackground = new MainBackground();
			
			addChild(_mainBackground);
			
			//  Create the question area.
			
			_questionBox = new InfoBox();
			_questionBox.x = 80;
			_questionBox.y = 300;
			_questionBox.displayData = _gameModel.questionData[0];
			
			addChild(_questionBox);
			
			//  Create the answer boxes.
			
			for(var i:int = 0; i < _gameModel.NUM_COLS; ++i)
			{
				
				for(var j:int = 0; j < _gameModel.NUM_ROWS; ++j)
				{
					
					trace(i, j);
					var box:ClickBox = new ClickBox();
					box.x = 100 + 40 * i;
					box.y = 100 + 40 * j;
					addChild(box);
					
				}
				
			}
			
			//  Create the score feedback.
			
			var scoreFormat:TextFormat = new TextFormat();
			scoreFormat.align = TextFormatAlign.CENTER;
			scoreFormat.font = "signage large";
			scoreFormat.size = 40;
			scoreFormat.color = 0xFDDE97;
			
			_scoreText = new GUITextField();
			_scoreText.width = 220;
			_scoreText.height = 30;
			_scoreText.x = 23;
			_scoreText.y = 60;
			_scoreText.defaultTextFormat = scoreFormat;
			addChild(_scoreText);
			
			_footballPlayers = new FootballPlayers();
			_footballPlayers.x = 80;
			_footballPlayers.y = 190;
			addChild(_footballPlayers);
			
			addChild(_border);
			addChild(_buttonController.resetButton);
			addChild(_buttonController.nextButton);
			
			_gameModel.addEventListener(GameEvent.NEXT_QUESTION, nextQuestionHandler);
			
		}
		
		/////  drawGameOver():void  /////
		///////////////////////////////////////////////////
		//												 //
		//  Draws the elements of the game over screen.  //
		//												 //
		///////////////////////////////////////////////////
		
		private function drawGameOver():void
		{
			
			var gameOverFormat:TextFormat = new TextFormat();
			gameOverFormat.font = "Collegiate-Normal";
			gameOverFormat.size = 48;
			gameOverFormat.align = TextFormatAlign.CENTER;
			
			var glowFilter:GlowFilter = new GlowFilter(0xFFFFFF, 1, 2, 2, 100);
			glowFilter.quality = 2;
			
			var gameOverText:GUITextField = new GUITextField();
			gameOverText.defaultTextFormat = gameOverFormat;
			gameOverText.width = 300;
			gameOverText.height = 52;
			gameOverText.x = 255;
			gameOverText.y = 35;
			gameOverText.filters = [ glowFilter ];
			addChild(gameOverText);
			
		}
		
		/////  clickBoxHandler(event:MouseEvent):void  /////
		//////////////////////////////////////////////////////////////////////////////////////////////
		//																							//
		//  Disable the boxes and perform actions based on whether the correct answer was clicked.  //
		//  If there are more questions, go to the next.											//
		//																							//
		//////////////////////////////////////////////////////////////////////////////////////////////
		
		private function clickBoxHandler(event:MouseEvent):void
		{
			
			//  Disable the boxes.
			
			enableBoxes(false);
						
		}
		
		/////  enableBoxes(isEnabled:Boolean):void  /////
		/////////////////////////////////////////////////
		//											   //
		//  Enables/disables the click boxes.		   //
		//											   //
		/////////////////////////////////////////////////
		
		public function enableBoxes(isEnabled:Boolean):void
		{
			
			for each(var box:ClickBox in _clickList)
			{
				
				box.buttonMode = isEnabled;
				box.gotoAndStop("init");
				
				if(isEnabled && !box.hasEventListener(MouseEvent.CLICK))
					box.addEventListener(MouseEvent.CLICK, clickBoxHandler);
				else
					box.removeEventListener(MouseEvent.CLICK, clickBoxHandler);
				
			}
			
		}
		
		/////  nextQuestionHandler(event:GameEvent):void  /////
		/////////////////////////////////////////////////////////
		//													   //
		//  Displays the current question, answers, and hint.  //
		//													   //
		/////////////////////////////////////////////////////////
		
		public function nextQuestionHandler(event:GameEvent):void
		{
			
			_questionBox.displayData = _gameModel.questionData[_gameModel.currentQuestionIndex];
			
			var len:int = _clickList.length;
			var randomList:Array = Randomize.getRandomArray(len);
			for (var i:int = 0; i < len; ++i)
			{
				
				var index:int = randomList[i];
				_clickList[i].displayData = _gameModel.answerData[_gameModel.currentQuestionIndex][index];
				_clickList[i].id = index;
				
			}
			
			enableBoxes(true);
			
		}
		
		/////  resetGameHandler(event:GameEvent):void  /////
		////////////////////////////////////////////////////
		//												  //
		//  Reset the game back to the first question.	  //
		//												  //
		////////////////////////////////////////////////////
		
		public function resetGameHandler(event:GameEvent):void
		{

			_gameModel.removeEventListener(GameEvent.RESET_GAME, resetGameHandler);
			_gameModel.resetQuestions();
			_clickList.length = 0;
			
			//  Go to the main game screen.
			
			_gameModel.currentScreenName = GameModel.SCREEN_GAME;
			
		}
		
	}
	
}