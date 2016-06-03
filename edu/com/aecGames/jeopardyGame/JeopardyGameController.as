//  JeopardyGameController.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/05/17
//  Last Updated:	2011/05/22
//
//  This class controls the game actions and contains the game elements for the jeopardy game.

package aecGames.jeopardyGame
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
	import aecGames.gameEvent.GameEvent;
	import aecGames.text.GUITextField;
	import aecGames.helpers.Randomize;
	import aecGames.game.GameController;
	import aecGames.game.GameModel;
	import aecGames.jeopardyGame.JeopardyButtonController;

	public class JeopardyGameController extends GameController
	{
		
		/////  Variable Declaration  /////
		////////////////////////////////////////////////////////////////////////////
		//																		  //
		//  _soundModel			-	Instance of the sound model.				  //
		//  _gameModel			-	Instance of the game model.					  //
		//																		  //
		//  _soundController	-	Instance of the sound controller.			  //
		//  _buttonController	-	Instance of the button controller.			  //
		//																		  //
		//  _border				-	Instance of the border.						  //
		//																		  //
		//  _dragList			-	Holds references to the drag boxes.			  //
		//  _targetList			-	Holds references to the drag targets.		  //
		//  _randomList			-	Holds a random list for shuffling questions.  //
		//																		  //
		//  _feedbackText		-	The feedback text for the user.				  //
		//																		  //
		////////////////////////////////////////////////////////////////////////////
		
		private var _soundModel:SoundModel;
		private var _gameModel:JeopardyGameModel;
		
		private var _soundController:SoundView;
		private var _buttonController:JeopardyButtonController;
		
		private var _border:Border;
		
		private var _clickList:Array = [];
		
		private var _feedbackText:GUITextField;
		
		/////  Constructor  /////
		///////////////////////////////////////////////////////////////////////////
		//																		 //
		//  @param - gameModel:Object  - An instance of the game's game model.	 //
		//  @param - soundModel:Object - An instance of the game's sound model.  //
		//																		 //
		///////////////////////////////////////////////////////////////////////////
		
		public function JeopardyGameController(gameModel:Object, soundModel:Object)
		{
			
			super(gameModel, soundModel);
			_soundModel = soundModel as SoundModel;
			_gameModel = gameModel as JeopardyGameModel;
			
			_soundController = new SoundView(_soundModel);
			_buttonController = new JeopardyButtonController(_gameModel, _soundModel);
						
			_border = new Border();
			_border.width = _gameModel.GAME_WIDTH;
			_border.height = _gameModel.GAME_HEIGHT;
			
			_gameModel.addEventListener(GameEvent.CHANGE_SCREEN, changeScreenHandler);
			changeScreenHandler(new GameEvent(GameEvent.CHANGE_SCREEN, false, false, GameModel.SCREEN_TITLE));
			
			_gameModel.addEventListener(GameEvent.CHECK_ANSWER, checkAnswerHandler);
			_gameModel.addEventListener(GameEvent.SHOW_ANSWER, showAnswerHandler);
			_gameModel.addEventListener(GameEvent.RESET_ANSWER, resetAnswerHandler);
			
		}
		
		/////  changeScreenHandler(event:GameEvent):void  /////
		//////////////////////////////////////////////////////////
		//														//
		//  Called when the model's current screen is changed.  //
		//														//
		//////////////////////////////////////////////////////////
		
		private function changeScreenHandler(event:GameEvent):void
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
					
				case GameModel.SCREEN_QUESTION:
					drawQuestionScreen();
					break;
					
				default:
				
			}
			
		}
		
		/////  drawTitleScreen():void  /////
		////////////////////////////////////////////////
		//											  //
		//  Draws the elements for the title screen.  //
		//											  //
		////////////////////////////////////////////////
		
		private function drawTitleScreen():void
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
		
		private function drawDirectionsScreen():void
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
		
		private function drawGameScreen():void
		{
			
			var mainBackground:MainBackground = new MainBackground();
			var cat1Header:Cat1Header = new Cat1Header();
			var cat2Header:Cat2Header = new Cat2Header();
			var cat3Header:Cat3Header = new Cat3Header();
			var cat4Header:Cat4Header = new Cat4Header();
			var headerList:Array = [ cat1Header, cat2Header, cat3Header, cat4Header ];
			
			addChild(mainBackground);
			
			var cl:ClickBox = new ClickBox();
			
			var wp:Number = (_gameModel.GAME_WIDTH - (_gameModel.NUM_CATEGORIES * cl.width)) / (_gameModel.NUM_CATEGORIES + 1);
			var hp:Number = (_gameModel.GAME_HEIGHT - 130 - (_gameModel.NUM_ROWS * cl.height)) / (_gameModel.NUM_ROWS + 1);
			
			for(var j:int = 0; j < _gameModel.NUM_CATEGORIES; ++j)
			{
				
				var header:Sprite = headerList[j];
				header.x = wp + (cl.width + wp) * j + cl.width * 0.5;
				header.y = 40;
				addChild(header);
				
				for(var i:int = 0; i < _gameModel.NUM_ROWS; ++i)
				{
					
					var index:int = i + j * _gameModel.NUM_ROWS;
					
					cl = new ClickBox();
					cl.name = String("box " + index);
					cl.x = wp + (cl.width + wp) * j + cl.width * 0.5;
					cl.y = 83 + hp + (cl.height + hp) * i + cl.height * 0.5;
					cl.gotoAndStop(i + 2);
					cl.addEventListener(MouseEvent.CLICK, clickElementHandler);
					_clickList.push(cl);
					addChild(cl);
					
				}
				
			}
			
			addChild(_border);
			addChild(_buttonController.resetButton);
			
			//  Create  a text format for the feedback text.

			var feedbackFormat:TextFormat = new TextFormat();
			feedbackFormat.font = "Calibri";
			feedbackFormat.align = TextFormatAlign.CENTER;
			feedbackFormat.size = 22;
			feedbackFormat.bold = true;
			feedbackFormat.color = 0x000000;

			//  Create text field for box text.

			_feedbackText = new GUITextField();
			_feedbackText.defaultTextFormat = feedbackFormat;
			_feedbackText.width = 265;
			_feedbackText.height = 26;
			_feedbackText.x = 105;
			_feedbackText.y = 542;
			addChild(_feedbackText);
			
		}
		
		private function drawQuestionScreen():void
		{
			
			
			
		}
		
		private function getQuestion(index:Number):void
		{
			
			
			
		}
		
		/////  releaseElementHandler(event:GameEvent):void  /////
		/////////////////////////////////////////////////////////
		//													   //
		//  Snaps released elements to an appropriate spot.	   //
		//													   //
		/////////////////////////////////////////////////////////
		
		public function clickElementHandler(event:MouseEvent):void
		{
			
			trace("CLICK!", event.target.name);
			var i:String = event.target.name;
			var index:int = int(i.slice(4));
			_gameModel.currentQuestionIndex = index;
			_gameModel.currentScreenName = GameModel.SCREEN_QUESTION;
			
		}
		
		/////  checkAnswerHandler(event:GameEvent):void  /////
		////////////////////////////////////////////////////////////////////////
		//																	  //
		//  Adds up total correct answers and displays appropriate feedback.  //
		//																	  //
		////////////////////////////////////////////////////////////////////////
		
		public function checkAnswerHandler(event:GameEvent):void
		{
			
			//  Reset the numCorrect counter.
			
			_gameModel.numCorrect = 0;
			for each(var cl:ClickBox in _clickList)
			{
				
				cl.removeEventListener(MouseEvent.CLICK, clickElementHandler);
				
			}
			
			//  If the user got all correct, disable the buttons.
			
			if(_gameModel.numCorrect == _gameModel.NUM_QUESTIONS)
			{
				
				_buttonController.enableButton(_buttonController.resetButton, false);
				_buttonController.enableButton(_buttonController.showButton, false);
				
			}
			
			//  Display the feedback.
			
			_feedbackText.text = "You got " + _gameModel.numCorrect + " out of " + _gameModel.NUM_QUESTIONS + " correct.";
			
		}
		
		/////  showAnswerHandler(event:GameEvent):void  /////
		////////////////////////////////////////////////////////
		//													  //
		//  Move each box to the correct target and disable.  //
		//													  //
		////////////////////////////////////////////////////////
		
		public function showAnswerHandler(event:GameEvent):void
		{
			
			//  Clear the feedback.
			
			_feedbackText.text = "";
			
		}
		
		/////  resetAnswerHandler(event:GameEvent):void  /////
		//////////////////////////////////////////////////////
		//													//
		//  Resets all of the drag boxes.					//
		//													//
		//////////////////////////////////////////////////////
		
		public function resetAnswerHandler(event:GameEvent):void
		{
			
			//  Clear the feedback.
			
			_feedbackText.text = "";
			
		}

	}
	
}