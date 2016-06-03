//  CategorizeGamecontroller.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/27
//  Last Updated:	2011/04/09
//
//  This class controls the game actions and contains the game elements for the categorize game.

package aecGames.categorizeGame
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
	import aecGames.boxes.TargetArea;

	public class CategorizeGameController extends GameController
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
		private var _gameModel:CategorizeGameModel;
		
		private var _soundController:SoundView;
		private var _buttonController:CategorizeButtonController;
		
		private var _border:Border;
		
		private var _dragList:Array = [];
		private var _cat1DragList:Array = [];
		private var _cat2DragList:Array = [];
		private var _targetAreaList:Array = [];
		private var _randomList:Array = [];
		
		private var _feedbackText:GUITextField;
		
		/////  Constructor  /////
		///////////////////////////////////////////////////////////////////////////
		//																		 //
		//  @param - gameModel:Object  - An instance of the game's game model.	 //
		//  @param - soundModel:Object - An instance of the game's sound model.  //
		//																		 //
		///////////////////////////////////////////////////////////////////////////
		
		public function CategorizeGameController(gameModel:Object, soundModel:Object)
		{
			
			super(gameModel, soundModel);
			_soundModel = soundModel as SoundModel;
			_gameModel = gameModel as CategorizeGameModel;
			
			_soundController = new SoundView(_soundModel);
			_buttonController = new CategorizeButtonController(_gameModel, _soundModel);
						
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
			
			//  Assemble list.
			
			var len:int = _gameModel.cat1AnswerData.length;
			for(var i:int = 0; i < len; ++i)
			{
				
				var drag:DragBox = new DragBox(_gameModel.cat1AnswerData[i], 0);
				_dragList.push(drag);
				_cat1DragList.push(drag);
				
			}
			
			len = _gameModel.cat2AnswerData.length;
			for(i = 0; i < len; ++i)
			{
				
				drag = new DragBox(_gameModel.cat2AnswerData[i], 1);
				_dragList.push(drag);
				_cat2DragList.push(drag);
				
			}
			
			var numRows:int = uint(_gameModel.NUM_ANSWERS / _gameModel.NUM_COLS) + int(Boolean(_gameModel.NUM_ANSWERS % _gameModel.NUM_COLS));
			_randomList = Randomize.getRandomArray(_gameModel.NUM_ANSWERS);
			
			for(var j:int = 0; j < _gameModel.NUM_COLS; ++j)
			{
			
				for(i = 0; i < numRows; ++i)
				{
					
					var index:int = i * _gameModel.NUM_COLS + j;
					if(index >= _gameModel.NUM_ANSWERS)
						break;
					
					trace(index);
					trace(j, i);
					
					drag = _dragList[_randomList[index]];
					drag.name = String("box " + index);
					drag.setPos(125 + 110 * j, 394 + 50 * i);
					drag.dragBoundary = new Rectangle(15, 15, 550, 510);
					drag.addEventListener(GameEvent.RELEASE_ELEMENT, releaseElementHandler);
					
				}
				
			}
			
			var target:TargetArea = new TargetArea(0, 8);
			target.heading = new Cat1Heading();
			target.x = 30;
			target.y = 30;
			addChild(target);
			
			_targetAreaList.push(target);
			
			target = new TargetArea(1, 8);
			target.heading = new Cat2Heading();
			target.x = 300;
			target.y = 30;
			addChild(target);
			
			_targetAreaList.push(target);
			
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
			feedbackFormat.size = 30;
			feedbackFormat.bold = true;
			feedbackFormat.color = 0x000000;

			//  Create text field for box text.

			_feedbackText = new GUITextField();
			_feedbackText.defaultTextFormat = feedbackFormat;
			_feedbackText.width = 350;
			_feedbackText.height = 40;
			_feedbackText.x = 0.5 * (width - _feedbackText.width);
			_feedbackText.y = 310;
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
			
			//  Snap the box to the next available space.
			
			for each(var targetArea:TargetArea in _targetAreaList)
			{
			
				if(event.target.hitBox.hitTestObject(targetArea))
				{
					
					targetArea.snapToCurrent(event.target as DragBox);
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
			
			if(_gameModel.numCorrect == _gameModel.NUM_ANSWERS)
			{
				
				_buttonController.enableButton(_buttonController.resetButton, false);
				_buttonController.enableButton(_buttonController.showButton, false);
				_buttonController.enableButton(_buttonController.checkButton, false);
				
			}
			
			//  Display the feedback.
			
			_feedbackText.text = "You got " + _gameModel.numCorrect + " out of " + _gameModel.NUM_ANSWERS + " correct.";
			
		}
		
		/////  showAnswerHandler(event:GameEvent):void  /////
		////////////////////////////////////////////////////////
		//													  //
		//  Move each box to the correct target and disable.  //
		//													  //
		////////////////////////////////////////////////////////
		
		public function showAnswerHandler(event:GameEvent):void
		{
			
			for each(var targetArea:TargetArea in _targetAreaList)
			{
				
				targetArea.resetTargets();
				
			}
			
			//  Loop through the drag list and move each to the appropriate target.
			
			for each(var drag:DragBox in _cat1DragList)
			{
				
				_targetAreaList[0].snapToCurrent(drag);
				
			}
			
			for each(drag in _cat2DragList)
			{
				
				_targetAreaList[1].snapToCurrent(drag);
				
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
			
			for each(var targetArea:TargetArea in _targetAreaList)
			{
				
				targetArea.resetTargets();
				
			}
			
			//  Clear the feedback.
			
			_feedbackText.text = "";
			
		}

	}
	
}