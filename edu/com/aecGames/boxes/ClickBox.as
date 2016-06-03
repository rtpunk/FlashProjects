//  ClickBox.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/07/15
//  Last Updated:	2011/03/27
//
//  This is the class for clickable boxes used in bingo games, concentration games, etc.

package aecGames.boxes
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	
	public class ClickBox extends MovieClip
	{
		
		/////  Variable Declaration  /////
		//////////////////////////////////////////////////////////////////////////////////////////////////
		//																								//
		//	_id				-	Holds an identifying integer.  Defaults to -1, indicating it is unset.	//
		//	_displayGraphic	-	Holds the graphic to be displayed on the box.							//
		//																								//
		//////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var _id:int;
		private var _displayGraphic:DisplayObject = new Sprite();
		
		/////  Constructor  /////
		/////////////////////////////////////////////////////////////////////////
		//																	   //
		//  Add display graphic, set button mode, and initialize the graphic.  //
		//																	   //
		/////////////////////////////////////////////////////////////////////////
		
		public function ClickBox()
		{
			
			addChild(_displayGraphic);

			buttonMode = true;
			gotoAndStop("init");
			
		}

		/////  set id():int  /////
		///////////////////////////////
		//							 //
		//	_id Setter Method		 //
		//						 	 //
		///////////////////////////////

		public function set id(value:int):void
		{
			
			_id = value;
			
		}

		/////  get id():int  /////
		/////////////////////////////////
		//							   //
		//	_id Getter Method		   //
		//							   //
		/////////////////////////////////
		
		public function get id():int
		{
			
			return _id;
			
		}
		
		/////  set displayData(data:DisplayObject):void  /////
		//////////////////////////////////////////////////////
		//													//
		//  Display Graphic Setter Method					//
		//	@param - Graphic to be displayed by the box.	//
		//													//
		//////////////////////////////////////////////////////
		
		public function set displayData(data:DisplayObject):void
		{
			
			removeChild(_displayGraphic);
			_displayGraphic = data;
			addChild(_displayGraphic);
			
		}
		
	}
	
}