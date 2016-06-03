//  GUIButton.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/07
//  Last Updated:	2011/03/27
//
//  This is the class for the games buttons.

package aecGames.buttons
{
	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class GUIButton extends MovieClip
	{
		
		/////  Variable Declaration  /////
		/////////////////////////////////////////////////////////////////////////
		//																	   //
		//	_isEnabled		-	Holds the graphic to be displayed on the box.  //
		//																	   //
		/////////////////////////////////////////////////////////////////////////
		
		private var _targetScreen:String = "";
		private var _isEnabled:Boolean = true;
		
		/////  Constructor  /////
		///////////////////////////////////////////////////////////////
		//															 //
		//  Disable the children so the button behaves as one unit.  //
		//															 //
		///////////////////////////////////////////////////////////////
		
		public function GUIButton()
		{
			
			mouseChildren = false;
			
			//  The buttons default to being enabled.
			
			isEnabled = true;
			
		}
		
		/////  RollOverHandler(event:MouseEvent):void  /////
		////////////////////////////////////////////////////
		//												  //
		//  Change to the appropriate graphic.			  //
		//												  //
		////////////////////////////////////////////////////
		
		private function RollOverHandler(event:MouseEvent):void
		{
			
			gotoAndStop("over");
			
		}
		
		/////  RollOutHandler(event:MouseEvent):void  /////
		///////////////////////////////////////////////////
		//												 //
		//  Change to the appropriate graphic.			 //
		//												 //
		///////////////////////////////////////////////////
		
		private function RollOutHandler(event:MouseEvent):void
		{
			
			gotoAndStop("up");
			
		}
		
		/////  set isEnabled(value:Boolean):void  /////
		///////////////////////////////////////////////
		//											 //
		//  isEnabled Setter Method					 //
		//  Enables/disables the button functions.	 //
		//											 //
		///////////////////////////////////////////////
		
		public function set isEnabled(value:Boolean):void
		{
			
			//  Set the variable to the appropriate value.
			//  Set the button mode to the appropriate value.
			
			_isEnabled = value;
			buttonMode = value;
			
			//  If true has been passed in, add the listeners, go to the appropriate
			//  graphic, and make the button completely opaque.
			//  If false has been passed in, remove the listeners, go to the appropriate
			//  graphic, and make the button half transparent.
			
			if(value)
			{
			
				addEventListener(MouseEvent.ROLL_OVER, RollOverHandler);
				addEventListener(MouseEvent.ROLL_OUT, RollOutHandler);
				
				gotoAndStop("up");
				alpha = 1;
			
			}
			else
			{
			
				removeEventListener(MouseEvent.ROLL_OVER, RollOverHandler);
				removeEventListener(MouseEvent.ROLL_OUT, RollOutHandler);
				
				gotoAndStop("down");
				alpha = 0.5;
			
			}
			
		}
		
		/////  get isEnabled():Boolean  /////
		/////////////////////////////////////
		//								   //
		//  _isEnabled Getter Method	   //
		//								   //
		/////////////////////////////////////
		
		public function get isEnabled():Boolean
		{
			
			return _isEnabled;
			
		}
		
	}
	
}