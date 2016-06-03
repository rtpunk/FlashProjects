//  ThreeColumnGamecontroller.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/05/14
//  Last Updated:	2011/05/15
//
//  This class controls the game actions and contains the game elements for the 3 column game.

package aecGames.threeColumnGame
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
	import aecGames.threeColumnGame.ThreeColumnButtonController;
	import aecGames.boxes.TargetArea;

	public class ThreeColumnGameController extends GameController
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
		private var _gameModel:ThreeColumnGameModel;
		
		private var _soundController:SoundView;
		private var _buttonController:ThreeColumnButtonController;
		
		private var _border:Border;
		
		private var _dragList:Array = [];
		private var _cat1DragList:Array = [];
		private var _cat2DragList:Array = [];
		private var _cat3DragList:Array = [];
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
		
		public function ThreeColumnGameController(gameModel:Object, soundModel:Object)
		{
			
			super(gameModel, soundModel);
			_soundModel = soundModel as SoundModel;
			_gameModel = gameModel as ThreeColumnGameModel;
			
			_soundController = new SoundView(_soundModel);
			_buttonController = new ThreeColumnButtonController(_gameModel, _soundModel);
						
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
			
			for(var i:int = 0; i < 3; ++i)
			{
				
				var target:TargetArea = new TargetArea(i, 5, 1);
				target.name = "target" + i;
				target.x = 20 + 260 * i;
				target.y = 20;
				_targetAreaList.push(target);
				addChild(target);
				
			}
			
			for(i = 0; i < _gameModel.cat1AnswerData.length; ++i)
			{
				
				var drag:DragBox = new DragBox(_gameModel.cat1AnswerData[i], 0);
				_cat1DragList.push(drag);
				_dragList.push(drag);
				
			}
			
			for(i = 0; i < _gameModel.cat2AnswerData.length; ++i)
			{
				
				drag = new DragBox(_gameModel.cat2AnswerData[i], 1);
				_cat2DragList.push(drag);
				_dragList.push(drag);
				
			}
			
			for(i = 0; i < _gameModel.cat3AnswerData.length; ++i)
			{
				
				drag = new DragBox(_gameModel.cat3AnswerData[i], 2);
				_cat3DragList.push(drag);
				_dragList.push(drag);
				
			}
			
			_targetAreaList[0].heading = new Cat1Heading();
			_targetAreaList[1].heading = new Cat2Heading();
			_targetAreaList[2].heading = new Cat3Heading();
			
			_randomList = Randomize.getRandomArray(_dragList.length);
			
			var len:int = _randomList.length;
			for(i = 0; i < len; i += 3)
			{
				
				var drag1:DragBox = _dragList[_randomList[i]];
				var drag2:DragBox = _dragList[_randomList[i + 1]];
				var drag3:DragBox = _dragList[_randomList[i + 2]];
				
				_targetAreaList[0].snapToCurrent(drag1, false);
				_targetAreaList[0].dragList.push(drag1);
				_targetAreaList[1].snapToCurrent(drag2, false);
				_targetAreaList[1].dragList.push(drag2);
				_targetAreaList[2].snapToCurrent(drag3, false);
				_targetAreaList[2].dragList.push(drag3);
				
			}
			
			for each(drag in _dragList)
			{
				
				drag.setPos(drag.x, drag.y);
				drag.dragBoundary = new Rectangle(15, 15, _gameModel.GAME_WIDTH - 30, _gameModel.GAME_HEIGHT - 57);
				drag.addEventListener(GameEvent.RELEASE_ELEMENT, releaseElementHandler);
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
			feedbackFormat.color = 0xFFFFFF;

			//  Create text field for box text.

			_feedbackText = new GUITextField();
			_feedbackText.defaultTextFormat = feedbackFormat;
			_feedbackText.width = 265;
			_feedbackText.height = 26;
			_feedbackText.x = 225;
			_feedbackText.y = 565;
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
			
			var oldTargetArea:TargetArea = null;
			var newTargetArea:TargetArea = null;
			
			var destination:DragBox = null;
			
			//  Snap the box to the next available space.
			
			for each(var drag:DragBox in _targetAreaList[0].dragList)
			{
				
				if(event.target.hitBox.hitTestObject(drag) && drag != event.target)
				{
					
					newTargetArea = _targetAreaList[0];
					destination = drag;
					break;
					
				}
				
			}
			
			for each(drag in _targetAreaList[1].dragList)
			{
				
				if(newTargetArea)
					break;
				
				if(event.target.hitBox.hitTestObject(drag) && drag != event.target)
				{
					
					newTargetArea = _targetAreaList[1];
					destination = drag;
					break;
					
				}
					
			}
			
			for each(drag in _targetAreaList[2].dragList)
			{
				
				if(newTargetArea)
					break;
				
				if(event.target.hitBox.hitTestObject(drag) && drag != event.target)
				{
					
					newTargetArea = _targetAreaList[2];
					destination = drag;
					break;
					
				}
					
			}
			
			for each(drag in _targetAreaList[0].dragList)
			{
				
				if(drag == event.currentTarget)
				{
					
					oldTargetArea = _targetAreaList[0];
					break;
					
				}
				
			}
			
			for each(drag in _targetAreaList[1].dragList)
			{
				
				if(oldTargetArea)
					break;
					
				if(drag == event.currentTarget)
				{
					
					oldTargetArea = _targetAreaList[1];
					break;
					
				}
				
			}
			
			for each(drag in _targetAreaList[2].dragList)
			{
				
				if(oldTargetArea)
					break;
					
				if(drag == event.currentTarget)
				{
					
					oldTargetArea = _targetAreaList[2];
					break;
					
				}
				
			}
			
			if(oldTargetArea && newTargetArea)
			{
				
				var newIndex:int = newTargetArea.dragList.indexOf(destination);
				var oldIndex:int = oldTargetArea.dragList.indexOf(event.target);
				
				newTargetArea.snapToPos(event.target as DragBox, newIndex, false);
				newTargetArea.dragList.splice(newIndex, 1, event.target);

				oldTargetArea.snapToPos(destination as DragBox, oldIndex, false);
				oldTargetArea.dragList.splice(oldIndex, 1, destination);
				
				return;
				
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
			
			for each(drag in _cat3DragList)
			{
				
				_targetAreaList[2].snapToCurrent(drag);
				
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
			
			_targetAreaList[0].resetTargets();
			_targetAreaList[1].resetTargets();
			_targetAreaList[2].resetTargets();
			
			_targetAreaList[0].dragList.length = 0;
			_targetAreaList[1].dragList.length = 0;
			_targetAreaList[2].dragList.length = 0;
			
			var len:int = _randomList.length;
			for(var i:int = 0; i < len; i += 3)
			{
				
				var drag1:DragBox = _dragList[_randomList[i]];
				var drag2:DragBox = _dragList[_randomList[i + 1]];
				var drag3:DragBox = _dragList[_randomList[i + 2]];
				
				_targetAreaList[0].snapToCurrent(drag1, false);
				_targetAreaList[0].dragList.push(drag1);
				_targetAreaList[1].snapToCurrent(drag2, false);
				_targetAreaList[1].dragList.push(drag2);
				_targetAreaList[2].snapToCurrent(drag3, false);
				_targetAreaList[2].dragList.push(drag3);
				
				drag1.setPos(drag1.x, drag1.y);
				drag2.setPos(drag2.x, drag2.y);
				drag3.setPos(drag3.x, drag3.y);
				
				drag1.setIsCorrect(0);
				drag2.setIsCorrect(1);
				drag3.setIsCorrect(2);
				
				drag1.enable();
				drag2.enable();
				drag3.enable();
				
			}
			
			//  Clear the feedback.
			
			_feedbackText.text = "";
			
		}

	}
	
}