//  MountainClimberGamecontroller.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/04/10
//  Last Updated:	2011/04/12
//
//  This class controls the game actions and contains the game elements for the mountain climber game.

package aecGames.blitzGame
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
	
	public class BlitzGameController extends GameController
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
		private var _gameModel:BlitzGameModel;
		
		private var _soundController:SoundView;
		private var _buttonController:BlitzButtonController;
		
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
		
		public function BlitzGameController(gameModel:Object, soundModel:Object)
		{
			
			super(gameModel, soundModel);
			_soundModel = soundModel as SoundModel;
			_gameModel = gameModel as BlitzGameModel;
			
			_soundController = new SoundView(_soundModel);
			_buttonController = new BlitzButtonController(_gameModel, _soundModel);
						
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
			gameMask.graphics.drawRect(0, 0, 680, 580);
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
			
			var len:int = _gameModel.answerData[0].length;
			var randomList:Array = Randomize.getRandomArray(len);
			for(var i:int = 0; i < len; ++i)
			{
				
				var index:int = randomList[i];
				var box:ClickBox = new ClickBox();
				box.id = index;
				box.x = 80;
				box.y = 380 + i * 34;
				box.displayData = _gameModel.answerData[0][index];
				addChild(box);
				
				box.addEventListener(MouseEvent.CLICK, clickBoxHandler);
				
				_clickList.push(box);
				
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
			_scoreText.text = String(_gameModel.score);
			addChild(_scoreText);
			
			_footballPlayers = new FootballPlayers();
			_footballPlayers.x = 80;
			_footballPlayers.y = 190;
			addChild(_footballPlayers);
			
			addChild(_border);
			addChild(_buttonController.resetButton);
			addChild(_buttonController.nextButton);
			
			_gameModel.addEventListener(GameEvent.NEXT_QUESTION, nextQuestionHandler);
			_gameModel.addEventListener(GameEvent.DRAW_SCORE, drawScoreHandler);
			
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
			
			if(_gameModel.score >= _gameModel.WINNING_SCORE)
			{
				
				gameOverText.text = "You win!";
				
			}
			else
			{
				
				gameOverText.text = "Try again.";
				_buttonController.enableButton(_buttonController.resetButton);
				_gameModel.addEventListener(GameEvent.RESET_GAME, resetGameHandler);
			
			}
			
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
			
			//  If the correct answer was clicked, move the player's goat.
			//  Else, move the computer's goat.
			
			if(event.currentTarget.id == 0)
			{
				
				event.currentTarget.gotoAndStop("correct");
				
				if(_gameModel.score < 9)
				{
					
					_footballPlayers.findNextPoint(new Point(_footballPlayers.x + 98.6, _footballPlayers.y));
					_gameModel.score += 2;
				}
				else
				{
					
					_footballPlayers.findNextPoint(new Point(_footballPlayers.x + 49.3, _footballPlayers.y));
					_gameModel.score++;
					
				}
				
			}
			else
			{
				
				event.currentTarget.gotoAndStop("wrong");
				if(_gameModel.score > 0)
				{
					
					_footballPlayers.findNextPoint(new Point(_footballPlayers.x - 49.3, _footballPlayers.y));
					_gameModel.score--;
					
				}
				
			}
			
			//  If there are still questions, enable the next button.
			//  Else, go to the game over screen.
			
			if(_gameModel.score < _gameModel.WINNING_SCORE && _gameModel.currentQuestionIndex < _gameModel.NUM_QUESTIONS - 1)
				_buttonController.enableButton(_buttonController.nextButton);
			else
				drawGameOver();
			
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
		
		public function drawScoreHandler(event:GameEvent):void
		{
			
			_scoreText.text = String(_gameModel.score);
			
		}
		
	}
	
}