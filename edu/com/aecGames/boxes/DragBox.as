//  DragBox.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/06/11
//  Last Updated:	2012/05/15
//
//  This is the class for the drag box.

package aecGames.boxes
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.display.DisplayObject;
	import aecGames.gameEvent.GameEvent;
	
	public class DragBox extends Sprite
	{
		
		/////  Variable Declaration  /////
		//////////////////////////////////////////////////////////////////////////////////////////////////
		//																								//
		//  _id				-	Holds an identifying integer.  Defaults to -1, indicating it is unset.	//
		//  _displayGraphic	-	The graphic that the drag box will display.								//
		//  _dragBoundary	-	The boundary outside which the box cannot move.							//
		//  _origPos		-	Original position of the box.											//
		//  _isCorrect		-	Indicates whether the drag box is in the correct position or not.		//
		//																								//
		//////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var _id:int;
		private var _displayGraphic:DisplayObject = new Sprite();
		private var _dragBoundary:Rectangle;
		private var _origPos:Point;
		private var _isCorrect:Boolean = false;
		public var currentLocationID:int = -1;
		
		/////  Constructor  /////
		////////////////////////////////////////////////////////////////////////////
		//																		  //
		//	@param - displayGraphic:DisplayObject - The graphic used by the box.  //
		//	@param - id:int						  - Indentity of box.			  //
		//																		  //
		////////////////////////////////////////////////////////////////////////////
						
		public function DragBox(displayGraphic:DisplayObject, id:int = -1)
		{
			
			//  Pass in parameters.
			
			_id = id;
			
			_displayGraphic = displayGraphic;
			addChild(_displayGraphic);
			
			//  Set button mode.
			
			buttonMode = true;
			
			//  Add Mouse Down Listener.
			
			addEventListener(MouseEvent.MOUSE_DOWN, MouseDownHandler);
						
		}
		
		/////  MouseDownHandler(event:MouseEvent):void  /////
		////////////////////////////////////////////////
		//											  //
		//	MOUSE_DOWN Event Handler				  //
		//	Begin dragging box.						  //
		//											  //
		////////////////////////////////////////////////
		
		private function MouseDownHandler(event:MouseEvent):void
		{
			
			//  Move this box to the top of the display list.
			
			parent.setChildIndex(this, parent.numChildren - 1);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, MouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, MouseUpHandler);
			
		}
		
		/////  MouseMoveHandler(event:MouseEvent):void  /////
		////////////////////////////////////////////////
		//											  //
		//	MOUSE_MOVE Event Handler				  //
		//	Move box.								  //
		//											  //
		////////////////////////////////////////////////
		
		private function MouseMoveHandler(event:MouseEvent):void
		{
			
			//  Move box to mouse position.

			x = stage.mouseX - getBounds(this).left - width * 0.5;
			y = stage.mouseY - getBounds(this).top - height * 0.5;
			
			//  If there is no drag boundary, we don't need to correct the position.
			
			if(!_dragBoundary)
				return;
			
			//  Keep the box within the frame.
			
			if(x + getBounds(this).left < _dragBoundary.left)
				x = _dragBoundary.left - getBounds(this).left;
			if(x + getBounds(this).right > _dragBoundary.right)
				x = _dragBoundary.right - getBounds(this).right;
			if(y + getBounds(this).top  < _dragBoundary.top)
				y = _dragBoundary.top - getBounds(this).top;
			if(y + getBounds(this).bottom > _dragBoundary.bottom)
				y = _dragBoundary.bottom - getBounds(this).bottom;
			
		}
		
		/////  MouseUpHandler(event:MouseEvent):void  /////
		//////////////////////////////////////////////
		//											//
		//	MOUSE_UP Event Handler				  	//
		//	Release box and stop dragging.			//
		//											//
		//////////////////////////////////////////////
		
		private function MouseUpHandler(event:MouseEvent):void
		{
			
			//  Remove listeners.
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, MouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, MouseUpHandler);
			
			dispatchEvent(new GameEvent(GameEvent.RELEASE_ELEMENT, true));
			
		}
		
		/////  disable():void  /////
		////////////////////////////////////
		//								  //
		//	Keep user from dragging box.  //
		//								  //
		////////////////////////////////////
		
		public function disable():void
		{
			
			removeEventListener(MouseEvent.MOUSE_DOWN, MouseDownHandler);
			buttonMode = false;
			
		}
		
		/////  enable():void  /////
		///////////////////////////////
		//							 //
		//	Allow user to drag box.  //
		//							 //
		///////////////////////////////
		
		public function enable():void
		{
			
			addEventListener(MouseEvent.MOUSE_DOWN, MouseDownHandler);
			buttonMode = true;
			
		}
		
		/////  setPos(xpos:Number, ypos:Number):void  /////
		///////////////////////////////////////////////////
		//												 //
		//  Sets the position and updates _origPos.		 //
		//												 //
		///////////////////////////////////////////////////
		
		public function setPos(xpos:Number, ypos:Number):void
		{
			
			x = xpos;
			y = ypos;
			
			_origPos = new Point(xpos, ypos);
			
		}
		
		/////  resetPos():void  /////
		///////////////////////////////////////
		//									 //
		//	Resets the position of the box.  //
		//									 //
		///////////////////////////////////////
		
		public function resetPos():void
		{
			
			x = _origPos.x;
			y = _origPos.y;
			
		}
		
		/////  setIsCorrect(targetID:int):void  /////
		//////////////////////////////////////////////////////////////////////////////////
		//																				//
		//	Sets _isCorrect to correct value, based on passed in id and this boxes id.  //
		//																				//
		//////////////////////////////////////////////////////////////////////////////////
		
		public function setIsCorrect(targetID:int):void
		{
			
			_isCorrect = Boolean(_id == targetID);
			
		}
		
		/////  set displayData(data:DisplayObject):void  /////
		//////////////////////////////////////////////////////
		//													//
		//  _displayGraphic Setter Method					//
		//	@param - Graphic to be displayed by the box.	//
		//													//
		//////////////////////////////////////////////////////
		
		public function set displayData(value:DisplayObject):void
		{
			
			removeChild(_displayGraphic);
			_displayGraphic = value;
			addChild(_displayGraphic);
			
		}
		
		public function get displayDataDimensions():Point
		{
			
			return new Point(_displayGraphic.width, _displayGraphic.height);
			
		}
		
		/////  set dragBoundary(value:Rectangle):void  /////
		////////////////////////////////////////////////////
		//												  //
		//  _dragBoundary Setter Method					  //
		//												  //
		////////////////////////////////////////////////////
		
		public function set dragBoundary(value:Rectangle):void
		{
			
			_dragBoundary = value;
			
		}
		
		/////  get isCorrect():Boolean  /////
		/////////////////////////////////////
		//								   //
		//  _isCorrect Getter Method	   //
		//								   //
		/////////////////////////////////////
		
		public function get isCorrect():Boolean
		{
			
			return _isCorrect;
			
		}
		
	}
	
}