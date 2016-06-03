//  DragTarget.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/06/11
//  Last Updated:	2011/03/27
//
//  This is the class for the target for the drag box.

package aecGames.boxes
{
	
	import flash.display.Sprite;
	
	public class DragTarget extends Sprite
	{
		
		/////  Variable Declaration  /////
		//////////////////////////////////////////////////////////////////////////////////////////
		//																						//
		//	_id		-	Holds an identifying integer.  Defaults to -1, indicating it is unset.	//
		//																						//
		//////////////////////////////////////////////////////////////////////////////////////////
		
		private var _id:int;
		
		/////  Constructor  /////
		///////////////////////////////////////////
		//										 //
		//	@param - id:int - Indentity of box.	 //
		//										 //
		///////////////////////////////////////////
		
		public function DragTarget(id:int = -1)
		{
			
			//  Pass in parameters.
			
			_id = id;
			
		}
		
		public function set id(value:int):void
		{
			
			_id = value;	
			
		}
		
		/////  get id():int /////
		///////////////////////////////////////////
		//										 //
		//	_id Getter Method					 //
		//										 //
		///////////////////////////////////////////
				
		public function get id():int
		{
		
			return _id;
		
		}
		
	}
		
}