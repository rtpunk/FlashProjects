//  ButtonController.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/07
//  Last Updated:	2011/03/27
//
//  This is the base class for the game button controllers.

package aecGames.buttons
{
	
	import flash.events.MouseEvent;
	import aecGames.game.GameModel;
	import aecGames.game.GameModel;
	import aecGames.sounds.SoundModel;
	
	public class ButtonController
	{
		
		/////  Variable Declaration  /////
		///////////////////////////////////////////////////////////////////
		//																 //
		//	_buttonList	-	Holds references to the buttons in the app.  //
		//																 //
		///////////////////////////////////////////////////////////////////
		
		protected var _buttonList:Array = [];
 
		/////  Constructor  /////
		////////////////////////////////////////////
		//										  //
		//  Nothing is too wonderful to be true.  //
		//										  //
		//  --Michael Faraday					  //
		//										  //
		////////////////////////////////////////////

 		public function ButtonController(model:Object, sModel:Object)
		{
		}
		
		/////  buttonHandler(event:MouseEvent):void  /////
		///////////////////////////////////////////////////////////////
		//															 //
		//  ABSTRACT METHOD TO BE OVERRIDDEN BY DERIVATIVE CLASSES.  //
		//															 //
		///////////////////////////////////////////////////////////////
		
		public function buttonHandler(event:MouseEvent):void
		{
			
			throw(new Error("buttonHandler IS AN ABSTRACT METHOD AND SHOULD BE OVERRIDDEN"));
			
		}
		
		/////  enableButton(button:GUIButton, isEnabled:Boolean = true):void  /////
		///////////////////////////////////////////////////////////////////////////
		//																		 //
		//  Enables/disables the button passed in based on the Bool passed in.	 //
		//																		 //
		///////////////////////////////////////////////////////////////////////////
		
		public function enableButton(button:GUIButton, isEnabled:Boolean = true):void
		{
			
			//  Set the button's isEnabled var.
			
			button.isEnabled = isEnabled;
			
			//  If true, enable the click listener.
			//  If false, disable the click listener.
			
			if(isEnabled)
				button.addEventListener(MouseEvent.CLICK, buttonHandler);
			else
				button.removeEventListener(MouseEvent.CLICK, buttonHandler);
			
		}
		
	}
	
}