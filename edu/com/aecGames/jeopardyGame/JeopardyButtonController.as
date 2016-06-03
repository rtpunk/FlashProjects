//  JeopardyButtonController.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/05/17
//  Last Updated:	2011/05/17
//
//  This class controls the button actions for the jeopardy game.

package aecGames.jeopardyGame
{
	
	import flash.events.MouseEvent;
	import aecGames.gameEvent.GameEvent;
	import aecGames.game.GameModel;
	import aecGames.sounds.SoundModel;
	import aecGames.buttons.ButtonController;
	import aecGames.buttons.GUIButton;
	
	public class JeopardyButtonController extends ButtonController
	{
		
		/////  Variable Declaration  /////
		/////////////////////////////////////////////////////////////////////////
		//																	   //
		//  _gameModel			-	Instance of the matching game model.	   //
		//  _soundModel			-	Instance of the sound model.			   //
		//																	   //
		//	_startButton		-	Instance of the start button.			   //
		//  _directionsButton	-	Instance of the directions button.		   //
		//  _dPlayButton		-	Instance of the directions play button.	   //
		//  _dPauseButton		-	Instance of the directions pause button.   //
		//  _dReplayButton		-	Instance of the directions replay button.  //
		//  _checkButton		-	Instance of the check button.			   //
		//  _showButton			-	Instance of the show button.			   //
		//  _resetButton		-	Instance of the reset button.			   //
		//																	   //
		/////////////////////////////////////////////////////////////////////////
		
		private var _gameModel:JeopardyGameModel;
		private var _soundModel:SoundModel;
		
		private var _startButton:StartButton = new StartButton();
		private var _directionsButton:DirectionsButton = new DirectionsButton();
		private var _dPlayButton:DirectionsPlayButton = new DirectionsPlayButton();
		private var _dPauseButton:DirectionsPauseButton = new DirectionsPauseButton();
		private var _dReplayButton:DirectionsReplayButton = new DirectionsReplayButton();
		private var _showButton:ShowButton = new ShowButton();
		private var _resetButton:ResetButton = new ResetButton();
		
		/////  Constructor  /////
		////////////////////////////////////////
		//									  //
		//  Create instances of each button.  //
		//									  //
		////////////////////////////////////////
		
		public function JeopardyButtonController(gameModel:Object, soundModel:Object)
		{
			
			//  Perform necessary super constructor actions.
			
			super(gameModel, soundModel);
			
			//  Pass in the models.
			
			_gameModel = gameModel as JeopardyGameModel;
			_soundModel = soundModel as SoundModel;
			
			//  Create instances of each button.
			
			_startButton.x = 750;
			_startButton.y = 581;
			_buttonList.push(_startButton);
			
			_directionsButton.x = 50;
			_directionsButton.y = 581;
			_buttonList.push(_directionsButton);
			
			_dPlayButton.x = 50;
			_dPlayButton.y = 581;
			_buttonList.push(_dPlayButton);
			
			_dPauseButton.x = 50;
			_dPauseButton.y = 581;
			_dPauseButton.visible = false;
			_buttonList.push(_dPauseButton);
			
			_dReplayButton.x = 138;
			_dReplayButton.y = 581;
			_buttonList.push(_dReplayButton);
			
			_resetButton.x = 50;
			_resetButton.y = 581;
			_resetButton.isEnabled = false;
			_buttonList.push(_resetButton);
			
			_showButton.x = 750;
			_showButton.y = 581;
			_showButton.isEnabled = false;
			_buttonList.push(_showButton);
			
			//  Enable/disable each button.
			
			for each(var button:GUIButton in _buttonList)
			{
				
				enableButton(button, button.isEnabled);
				
			}
			
		}
		
		/////  buttonHandler(event:MouseEvent):void  /////
		/////////////////////////////////////////////////////////
		//													   //
		//  Play a button click sound.						   //
		//  Perform the actions specific to each button type.  //
		//													   //
		/////////////////////////////////////////////////////////
		
		public override function buttonHandler(event:MouseEvent):void
		{
			
			//  Play the click sound.
			
			_soundModel.playSound(SoundModel.SOUND_CLICK);
			
			//  Perform actions based on the button type.
			
			switch(event.target)
			{
				
				case _startButton:
					//  Stop the directions sound if playing.
					//  Go to the main game screen.
					
					_soundModel.stopSound(SoundModel.SOUND_DIRECTIONS);
					_soundModel.removeEventListener(GameEvent.SOUND_COMPLETE, soundCompleteHandler);
					_gameModel.currentScreenName = GameModel.SCREEN_GAME;
					break;
					
				case _directionsButton:
					//  Go to the directions screen.
					
					_soundModel.addEventListener(GameEvent.SOUND_COMPLETE, soundCompleteHandler);
					_gameModel.currentScreenName = GameModel.SCREEN_DIRECTIONS;
					break;
					
				case _dPlayButton:
					//  Switch the dPlay and dPause buttons.
					//  Play the directions sound.
					
					_dPlayButton.visible = false;
					_dPauseButton.visible = true;
					_soundModel.playSound(SoundModel.SOUND_DIRECTIONS, true);
					break;
					
				case _dPauseButton:
					//  Switch the dPlay and dPause buttons.
					//  Pause the directions sound.
					
					_dPauseButton.visible = false;
					_dPlayButton.visible = true;
					_soundModel.pauseSound(SoundModel.SOUND_DIRECTIONS);
					break;
					
				case _dReplayButton:
					//  Switch the dPlay and dPause buttons.
					//  Stop the directions sound.
					
					_dPauseButton.visible = false;
					_dPlayButton.visible = true;
					_soundModel.stopSound(SoundModel.SOUND_DIRECTIONS);
					break;
				
				case _showButton:
					//  Disable the reset, show, and check buttons.
					//  Instruct the model to show the answers.
					
					enableButton(_resetButton, false);
					enableButton(_showButton, false);
					_gameModel.showAnswer = true;
					break;
					
				case _resetButton:
					//  Enable the check button.
					//  Disable the reset button.
					//  Instruct the model to reset the answers.
					
					enableButton(_resetButton, false);
					_gameModel.resetAnswer = true;
					break;
				
				default:
				
			}
			
		}
		
		/////  soundCompleteHandler(event:GameEvent):void  /////
		/////////////////////////////////////////////////////////
		//													   //
		//  Show the dPlay button and hide the dPause button.  //
		//													   //
		/////////////////////////////////////////////////////////
		
		public function soundCompleteHandler(event:GameEvent):void
		{
			
			_dPauseButton.visible = false;
			_dPlayButton.visible = true;
			
		}
		
		///////////////////////////////////
		/////  Button Getter Section  /////
		///////////////////////////////////
		
		/////  get startButton():StartButton  /////
		///////////////////////////////////////////
		//										 //
		//  _startButton Getter Method			 //
		//										 //
		///////////////////////////////////////////
		
		public function get startButton():StartButton
		{
			
			return _startButton;
			
		}
		
		/////  get directionsButton():DirectionsButton  /////
		/////////////////////////////////////////////////////
		//												   //
		//  _directionsButton Getter Method				   //
		//												   //
		/////////////////////////////////////////////////////
		
		public function get directionsButton():DirectionsButton
		{
			
			return _directionsButton;
			
		}
		
		/////  get dPlayButton():DirectionsPlayButton  /////
		////////////////////////////////////////////////////
		//												  //
		//  _dPlayButton Getter Method					  //
		//												  //
		////////////////////////////////////////////////////
		
		public function get dPlayButton():DirectionsPlayButton
		{
			
			return _dPlayButton;
			
		}
		
		/////  get dPauseButton():DirectionsPauseButton  /////
		//////////////////////////////////////////////////////
		//													//
		//  _dPauseButton Getter Method						//
		//													//
		//////////////////////////////////////////////////////
		
		public function get dPauseButton():DirectionsPauseButton
		{
			
			return _dPauseButton;
			
		}
		
		/////  get dReplayButton():DirectionsReplayButton  /////
		////////////////////////////////////////////////////////
		//													  //
		//  _dReplayButton Getter Method					  //
		//													  //
		////////////////////////////////////////////////////////
		
		public function get dReplayButton():DirectionsReplayButton
		{
			
			return _dReplayButton;
			
		}
		
		/////  get showButton():ShowButton  /////
		/////////////////////////////////////////
		//									   //
		//  _showButton Getter Method		   //
		//									   //
		/////////////////////////////////////////
		
		public function get showButton():ShowButton
		{
			
			return _showButton;
			
		}
		
		/////  get resetButton():ResetButton  /////
		///////////////////////////////////////////
		//										 //
		//  _resetButton Getter Method			 //
		//										 //
		///////////////////////////////////////////
		
		public function get resetButton():ResetButton
		{
			
			return _resetButton;
			
		}

	}
	
}