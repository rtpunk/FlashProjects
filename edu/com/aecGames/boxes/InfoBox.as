//  InfoBox.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/07
//  Last Updated:	2011/05/07
//
//  This is the class for display information graphics.

package aecGames.boxes
{
	
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	
	public class InfoBox extends Sprite
	{
		
		/////  Variable Declaration  /////
		//////////////////////////////////////////////////////////////////
		//																//
		//	_displayGraphic	-	The graphic displayed by the info box.	//
		//																//
		//////////////////////////////////////////////////////////////////
		
		private var _displayGraphic:DisplayObject = new Sprite();
		
		/////  Constructor  /////
		/////////////////////////////////////////////
		//										   //
		//  Add the place holder display graphic.  //
		//										   //
		/////////////////////////////////////////////
		
		public function InfoBox()
		{
			
			//  Add the placeholder display graphic.
			
			addChild(_displayGraphic);

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
		
		/////  displayDataHeight():Number  /////
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		//																									//
		//  Display Graphic Height Getter Method															//
		//  We don't want to give unrestriced access to the graphic when all we really need is the height.  //
		//																									//
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function get displayDataHeight():Number
		{
			
			return _displayGraphic.height;
			
		}
		
	}
	
}
