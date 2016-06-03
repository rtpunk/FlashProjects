//  GUITextField.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/07
//  Last Updated:	2011/03/28
//
//  Simply a prettier version of TextField.

package aecGames.text
{
	import flash.text.TextField;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	
	public class GUITextField extends TextField
	{
		
		/////  Constructor  /////
		///////////////////////////////////////////////////////////////////
		//																 //
		//  Embeds fonts, adds antialiasing, and removes mouse effects.  //
		//																 //
		///////////////////////////////////////////////////////////////////
		
		public function GUITextField()
		{
			
			embedFonts = true;
			antiAliasType = AntiAliasType.ADVANCED;
			selectable = false;
			mouseEnabled = false;
			
		}
		
	}
	
}