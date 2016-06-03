//  BlanksGamecontroller.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/29
//  Last Updated:	2011/03/29
//
//  This class controls the game actions and contains the game elements for the blanks game.

package aecGames.blanksGame
{
	
	import flash.display.Sprite;
	import flash.display.DisplayObject;
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
	import flash.geom.Point;

	public class BlanksGameController extends GameController
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
		private var _gameModel:BlanksGameModel;
		
		private var _soundController:SoundView;
		private var _buttonController:BlanksButtonController;
		
		private var _feedbackText1:GUITextField;
		private var _feedbackText2:GUITextField;
		private var _feedbackText3:GUITextField;
		
		private var _border:Border;
		
		private var _dragList:Array = [];
		private var _targetList:Array = [];
		private var _randomList:Array = [];
		
		/////  Constructor  /////
		///////////////////////////////////////////////////////////////////////////
		//																		 //
		//  @param - gameModel:Object  - An instance of the game's game model.	 //
		//  @param - soundModel:Object - An instance of the game's sound model.  //
		//																		 //
		///////////////////////////////////////////////////////////////////////////
		
		public function BlanksGameController(gameModel:Object, soundModel:Object)
		{
			
			super(gameModel, soundModel);
			_soundModel = soundModel as SoundModel;
			_gameModel = gameModel as BlanksGameModel;
			
			_soundController = new SoundView(_soundModel);
			_buttonController = new BlanksButtonController(_gameModel, _soundModel);
						
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
			
			var len:int = _gameModel.questionData.length;
			var offset:int = 0;
			for(i = 0; i < len; ++i)
			{
				
				var info:InfoBox = new InfoBox();
				info.displayData = _gameModel.questionData[i];
				info.x = 20;
				info.y = 280 + offset;
				addChild(info);
				
				var l:int = _gameModel.questionData[i].numChildren;
				for(var j:int = l; j > 0; --j)
				{
					
					var child:Object = _gameModel.questionData[i].getChildAt(j - 1) as Object;
					if(child.constructor == DragTarget)
					{
						
						child.id = child.name.slice(1);
						
						_targetList.push(DragTarget(child));
						
					}
					
				}
				
				offset += (info.height + 4);
				
			}
			
			_randomList = Randomize.getRandomArray(_gameModel.answerData.length);
			len = _randomList.length;
			for(var i:int = 0; i < len; ++i)
			{
				
				var index:int = _randomList[i];
				
				var drag:DragBox = new DragBox(_gameModel.answerData[i], i);
				drag.setPos(50, 76 + 26 * index);
				drag.dragBoundary = new Rectangle(15, 15, 710, 530);
				
				var hitBox:Sprite = new Sprite();
				hitBox.graphics.beginFill(0xFFFFFF);
				hitBox.graphics.drawRect(0, 0, drag.displayDataDimensions.x, drag.displayDataDimensions.y);
				hitBox.visible = false;
				
				drag.hitArea = hitBox;
				drag.addEventListener(GameEvent.RELEASE_ELEMENT, releaseElementHandler);
				addChild(drag);
				
				_dragList.push(drag);
				
			}
			
			//  Add feedback text fields.
			
			var feedbackFormat:TextFormat = new TextFormat();
			feedbackFormat.align = TextFormatAlign.CENTER;
			feedbackFormat.font = "Calibri";
			feedbackFormat.size = 30;
			feedbackFormat.bold = true;
			feedbackFormat.color = 0x000000;
			
			var bigFormat:TextFormat = new TextFormat();
			bigFormat.size = 50;
			
			_feedbackText1 = new GUITextField();
			_feedbackText1.x = 411.5;
			_feedbackText1.y = 69;
			_feedbackText1.width = 220;
			_feedbackText1.height = 41;
			_feedbackText1.defaultTextFormat = feedbackFormat;
			addChild(_feedbackText1);
			
			_feedbackText2 = new GUITextField();
			_feedbackText2.x = 411.5;
			_feedbackText2.y = 110;
			_feedbackText2.width = 220;
			_feedbackText2.height = 66;
			_feedbackText2.defaultTextFormat = feedbackFormat;
			_feedbackText2.defaultTextFormat = bigFormat;
			addChild(_feedbackText2);
			
			_feedbackText3 = new GUITextField();
			_feedbackText3.x = 411.5;
			_feedbackText3.y = 177;
			_feedbackText3.width = 220;
			_feedbackText3.height = 41;
			_feedbackText3.defaultTextFormat = feedbackFormat;
			addChild(_feedbackText3);
			
			addChild(_border);
			addChild(_buttonController.resetButton);
			addChild(_buttonController.showButton);
			addChild(_buttonController.checkButton);
			
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
				if(event.target.hitTestObject(drag))
				{
					
					event.target.resetPos();
					return;
					
				}
				
			}
			
			//  If the space is free, move the dragBox to the appropriate position.
			
			for each(var target:DragTarget in _targetList)
			{
				
				if(event.target.hitTestObject(target.targ))
				{

					event.target.x = target.x + target.parent.parent.x + (target.width - event.target.width) * 0.5;
					event.target.y = target.y + target.parent.parent.y;
					event.target.setIsCorrect(target.id);
					event.target.currentLocationID = target.id;
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
			
			_feedbackText1.text = "You got";
			_feedbackText2.text = String(_gameModel.numCorrect);
			_feedbackText3.text = "out of " + _gameModel.NUM_ANSWERS + " correct.";
			
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
				
				var drag:DragBox = _dragList[i];
				var target:DragTarget = _targetList[i];
				
				drag.x = target.x + target.parent.parent.x + (target.width - drag.width) * 0.5;
				drag.y = target.y + target.parent.parent.y;
				drag.disable();
				
			}
			
			//  Clear the feedback.
			
			_feedbackText1.text = _feedbackText2.text = _feedbackText3.text = "";
			
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
			
			_feedbackText1.text = _feedbackText2.text = _feedbackText3.text = "";
			
			
		}

	}
	
}