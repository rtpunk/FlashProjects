//  MatchingGamecontroller.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/27
//  Last Updated:	2011/03/28
//
//  This class controls the game actions and contains the game elements for the matching game.

package aecGames.matchingGame
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
	import aecGames.boxes.DragBox;
	import aecGames.boxes.DragTarget;
	import aecGames.boxes.InfoBox;
	import aecGames.gameEvent.GameEvent;
	import aecGames.text.GUITextField;
	import aecGames.helpers.Randomize;
	import aecGames.game.GameController;
	import aecGames.game.GameModel;
	import aecGames.matchingGame.MatchingButtonController;

	public class MatchingGameController extends GameController
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
		private var _gameModel:MatchingGameModel;
		
		private var _soundController:SoundView;
		private var _buttonController:MatchingButtonController;
		
		private var _border:Border;
		
		private var _dragList:Array = [];
		private var _targetList:Array = [];
		private var _randomList:Array = [];
		
		private var _feedbackText:GUITextField;
		
		/////  Constructor  /////
		///////////////////////////////////////////////////////////////////////////
		//																		 //
		//  @param - gameModel:Object  - An instance of the game's game model.	 //
		//  @param - soundModel:Object - An instance of the game's sound model.  //
		//																		 //
		///////////////////////////////////////////////////////////////////////////
		
		public function MatchingGameController(gameModel:Object, soundModel:Object)
		{
			
			super(gameModel, soundModel);
			_soundModel = soundModel as SoundModel;
			_gameModel = gameModel as MatchingGameModel;
			
			_soundController = new SoundView(_soundModel);
			_buttonController = new MatchingButtonController(_gameModel, _soundModel);
						
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
			
			addChild(mainBackground);
			
			_randomList = Randomize.getRandomArray(_gameModel.questionData.length);
			
			for(var i:int = 0; i < 10; ++i)
			{
				
				var drag:DragBox = new DragBox(_gameModel.answerData[i], i);
				drag.name = String("box " + i);
				drag.setPos(70, 44 + 50 * _randomList[i]);
				drag.dragBoundary = new Rectangle(15, 15, 550, 510);
				drag.addEventListener(GameEvent.RELEASE_ELEMENT, releaseElementHandler);
				_dragList.push(drag);
				
				var target:DragTarget = new DragTarget(i);
				target.name = String("target" + i);
				target.x = 220;
				target.y = 44 + 50 * i;
				_targetList.push(target);
				
				var info:InfoBox = new InfoBox();
				info.name = String("info" + i);
				info.displayData = _gameModel.questionData[i];
				info.x = 420;
				info.y = 44 + 50 * i;
				
				addChild(target);
				addChild(info);
				
			}
			
			//  This is just to make sure that the drag boxes are on top of all the other aecGames.boxes.
			
			for each(drag in _dragList)
			{
				
				addChild(drag);
				
			}
			
			addChild(_border);
			addChild(_buttonController.resetButton);
			addChild(_buttonController.showButton);
			addChild(_buttonController.checkButton);
			
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
		
		/////  releaseElementHandler(event:GameEvent):void  /////
		/////////////////////////////////////////////////////////
		//													   //
		//  Snaps released elements to an appropriate spot.	   //
		//													   //
		/////////////////////////////////////////////////////////
		
		public function releaseElementHandler(event:GameEvent):void
		{
			
			//  Make sure the space is not occupied by another drag box.
			
			for each(var drag:DragBox in _dragList)
			{
				
				if(event.target == drag)
					continue;
				if(event.target.hitBox.hitTestObject(drag))
				{
					
					event.target.resetPos();
					return;
					
				}
				
			}
			
			//  If the space is free, move the dragBox to the appropriate position.
			
			for each(var target:DragTarget in _targetList)
			{
				
				if(event.target.hitBox.hitTestObject(target))
				{
					
					event.target.x = target.x;
					event.target.y = target.y;
					event.target.setIsCorrect(target.id);
					return;
					
				}
				
			}
			
			//  If the box is released anywhere else, go back to the initial position.
			
			event.target.resetPos();
			
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
			for each(var drag:DragBox in _dragList)
			{
				
				drag.disable();
				_gameModel.numCorrect += int(drag.isCorrect);
				
			}
			
			//  If the user got all correct, disable the buttons.
			
			if(_gameModel.numCorrect == _gameModel.NUM_QUESTIONS)
			{
				
				_buttonController.enableButton(_buttonController.resetButton, false);
				_buttonController.enableButton(_buttonController.showButton, false);
				_buttonController.enableButton(_buttonController.checkButton, false);
				
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
			
			//  Loop through the drag list and move each to the appropriate target.
			
			var len:int = _dragList.length;
			for(var i:int = 0; i < len; ++i)
			{
				
				_dragList[i].x = _targetList[i].x;
				_dragList[i].y = _targetList[i].y;
				_dragList[i].disable();
				
			}
			
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
			
			//  Reset and enable each box.
			
			for each(var drag:DragBox in _dragList)
			{
				
				drag.resetPos();
				drag.enable();
				drag.setIsCorrect(-1);
				
			}
			
			//  Clear the feedback.
			
			_feedbackText.text = "";
			
		}

	}
	
}