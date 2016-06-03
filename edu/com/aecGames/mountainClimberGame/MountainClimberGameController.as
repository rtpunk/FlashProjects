//  MountainClimberGamecontroller.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/27
//  Last Updated:	2011/03/28
//
//  This class controls the game actions and contains the game elements for the mountain climber game.

package aecGames.mountainClimberGame
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
	import aecGames.mountainClimberGame.MountainClimberButtonController;
	
	public class MountainClimberGameController extends GameController
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
		private var _gameModel:MountainClimberGameModel;
		
		private var _soundController:SoundView;
		private var _buttonController:MountainClimberButtonController;
		
		private var _mainBackground:MainBackground;
		private var _playerSelectBackground:PlayerSelectBackground;
		
		private var _border:Border;
		
		private var _player:Goat;
		private var _computer:Goat;
		
		private var _questionBox:InfoBox;
		private var _hintBox:HintBox;
		
		private var _clickList:Array = [];
		
		private var _goatSound:GoatSound = new GoatSound();
		
		/////  Constructor  /////
		///////////////////////////////////////////////////////////////////////////
		//																		 //
		//  @param - gameModel:Object  - An instance of the game's game model.	 //
		//  @param - soundModel:Object - An instance of the game's sound model.  //
		//																		 //
		///////////////////////////////////////////////////////////////////////////
		
		public function MountainClimberGameController(gameModel:Object, soundModel:Object)
		{
			
			super(gameModel, soundModel);
			_soundModel = soundModel as SoundModel;
			_gameModel = gameModel as MountainClimberGameModel;
			
			_soundController = new SoundView(_soundModel);
			_buttonController = new MountainClimberButtonController(_gameModel, _soundModel);
						
			_border = new Border();
			_border.width = _gameModel.GAME_WIDTH;
			_border.height = _gameModel.GAME_HEIGHT;
			
			_gameModel.addEventListener(GameEvent.CHANGE_SCREEN, changeHandler);
			changeHandler(new GameEvent(GameEvent.CHANGE_SCREEN, false, false, GameModel.SCREEN_TITLE));
			_gameModel.addEventListener(GameEvent.NEXT_QUESTION, nextQuestionHandler);
			
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
					
				case GameModel.SCREEN_PLAYER_SELECT:
					drawPlayerSelectScreen();
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
		
		/////  drawPlayerSelectScreen():void  /////
		///////////////////////////////////////////////////////
		//													 //
		//  Draws the elements of the player select screen.  //
		//													 //
		///////////////////////////////////////////////////////
		
		protected function drawPlayerSelectScreen():void
		{
			
			_playerSelectBackground = new PlayerSelectBackground();
			
			addChild(_playerSelectBackground);
			
			_playerSelectBackground.playerName.restrict = "A-z";
			
			_playerSelectBackground.brownGoat.buttonMode = true;
			_playerSelectBackground.whiteGoat.buttonMode = true;
			
			//  Add click listeners for each goat.
			
			_playerSelectBackground.brownGoat.addEventListener(MouseEvent.CLICK, clickGoatHandler);
			_playerSelectBackground.whiteGoat.addEventListener(MouseEvent.CLICK, clickGoatHandler);
			
			addChild(_border);
			
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
			
			addChild(_border);
			addChild(_buttonController.resetButton);
			addChild(_buttonController.nextButton);
			
			//  Set up the goats.
			
			_player.scaleX = -0.18;
			_player.scaleY = 0.18;
			_computer.scaleX = _computer.scaleY = 0.18;
			_player.pointList = _gameModel.PLAYER_POINTS;
			_computer.pointList = _gameModel.COMPUTER_POINTS;
			
			_player.resetPosition();
			
			addChild(_player);
			
			_computer.resetPosition();
			
			addChild(_computer);
			
			//  Create the name tags.
			
			_mainBackground.playerName.text = _player.name;
			_mainBackground.computerName.text = _computer.name;
			
			//  Create the question area.
			
			_questionBox = new InfoBox();
			_questionBox.x = 20;
			_questionBox.y = 20;
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
				box.x = 22.5;
				box.y = 131 + i * 60;
				box.displayData = _gameModel.answerData[0][index];
				addChild(box);
				
				box.addEventListener(MouseEvent.CLICK, clickBoxHandler);
				
				_clickList.push(box);
				
			}
			
			//  Create the hint box.
			
			if(_gameModel.useHints)
			{
				
				addChild(_buttonController.hintButton);
			
				_hintBox = new HintBox();
				_hintBox.displayData = _gameModel.hintData[0];
//				_hintBox.height = _hintBox.displayDataHeight + 20;
				_hintBox.x = 400;
				_hintBox.y = 175;
				_hintBox.visible = false;
				addChild(_hintBox);
				
				_gameModel.addEventListener(GameEvent.SHOW_HINT, showHintHandler);
				
			}
			
		}
		
		/////  drawGameOver():void  /////
		///////////////////////////////////////////////////
		//												 //
		//  Draws the elements of the game over screen.  //
		//												 //
		///////////////////////////////////////////////////
		
		private function drawGameOver():void
		{
			
			_buttonController.enableButton(_buttonController.resetButton);
			_gameModel.addEventListener(GameEvent.RESET_GAME, resetGameHandler);
			
			_mainBackground.scoreText.text = "You got " + _gameModel.numCorrect + " out of " + _gameModel.NUM_QUESTIONS + " correct.";

			if(_gameModel.numCorrect == _gameModel.NUM_QUESTIONS)
				_mainBackground.feedbackText.text = "You Win!";
			else
				_mainBackground.feedbackText.text = "Please Try Again.";
			
			_buttonController.enableButton(_buttonController.resetButton, (_gameModel.numCorrect != _gameModel.NUM_QUESTIONS));
			
		}
		
		/////  clickGoatHandler(event:MouseEvent):void  /////
		///////////////////////////////////////////////////////////////
		//															 //
		//  Assign the player/computer goats and go to game screen.  //
		//															 //
		///////////////////////////////////////////////////////////////
		
		private function clickGoatHandler(event:MouseEvent):void
		{
			
			//  Decide which goat the player clicked on.
			
			if(event.target == _playerSelectBackground.brownGoat)
			{
				
				_player = new BrownGoat();
				_computer = new WhiteGoat();
				_computer.name = "White Goat";
				
			}
			else
			{
				
				_player = new WhiteGoat();
				_computer = new BrownGoat();
				_computer.name = "Brown Goat";
				
			}
			
			_player.name = _playerSelectBackground.playerName.text + " Goat";
			
			//  Remove the CLICK listeners.
			
			_playerSelectBackground.whiteGoat.removeEventListener(MouseEvent.CLICK, clickGoatHandler);
			_playerSelectBackground.brownGoat.removeEventListener(MouseEvent.CLICK, clickGoatHandler);
			
			//  Go to main game screen.
			
			_gameModel.currentScreenName = GameModel.SCREEN_GAME;
			
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
				
				++_gameModel.numCorrect;
				event.currentTarget.gotoAndStop("correct");
				_player.findNextPoint();
				
			}
			else
			{
				
				event.currentTarget.gotoAndStop("wrong");
				_computer.findNextPoint();
				
			}
			
			_soundModel.playSound(_goatSound);
			
			//  Disable the hints.
			
			_buttonController.enableButton(_buttonController.hintButton, false);
			_gameModel.displayHint = false;
			
			//  If there are still questions, enable the next button.
			//  Else, go to the game over screen.
			
			if(_gameModel.currentQuestionIndex < _gameModel.NUM_QUESTIONS - 1)
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
			
			if(_gameModel.useHints)
			{
				
				_hintBox.displayData = _gameModel.hintData[_gameModel.currentQuestionIndex];
				//_hintBox.boxGraphic.height = _hintBox.displayDataHeight + 20;
				
			}
			
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
		
		/////  showHintHandler(event:GameEvent):void  /////
		///////////////////////////////////////////////////
		//												 //
		//  Show/hide the hint box.						 //
		//												 //
		///////////////////////////////////////////////////
		
		public function showHintHandler(event:GameEvent):void
		{
			
			_hintBox.visible = _gameModel.displayHint;
			
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
			
			_player.resetPosition();
			_computer.resetPosition();
			
			_buttonController.enableButton(_buttonController.hintButton);
			
			//  Go to the main game screen.
			
			_gameModel.currentScreenName = GameModel.SCREEN_GAME;
			
		}
		
	}
	
}