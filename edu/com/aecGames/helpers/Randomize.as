//  Randomize.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/07
//  Last Updated:	2011/03/28
//
//  This class contains helper functions to randomize data.

package aecGames.helpers
{
	
	public class Randomize
	{

		/////  Constructor  /////
		///////////////////////////////////////////////////////
		//													 //
		//  Nothing external to you has any power over you.  //
		//													 //
		//  --Ralph Waldo Emerson							 //
		//													 //
		///////////////////////////////////////////////////////
		
		public function Randomize()
		{
		}
		
		/////  getRandomArray(length:uint):Array  /////
		/////////////////////////////////////////////////////////////////
		//															   //
		//  Returns an array of consecutive integers in random order.  //
		//															   //
		/////////////////////////////////////////////////////////////////
		
		public static function getRandomArray(length:uint, startNum:Number = 0, step:int = 1):Array
		{
			
			//  Generate an array of consecutive integers.
			
			var list:Array = [];
			var len:int = length + startNum;
			for(var i:int = startNum; i < len; i += step)
			{
				
				list.push(i);
				
			}
			
			//  Shuffle the elements of the array.
			
			for(i = 0; i < len; ++i)
			{
				
				var rand:int = uint(Math.random() * list.length);
				list.splice(rand, 0, list.shift());
				
			}
			
			return list;
			
		}
		
		public static function shuffle(list:Array):Array
		{
			
			var len:int = list.length;
			for(var i:int = 0; i < len; ++i)
			{
				
				var randPos:int = uint(len * Math.random());
				list.push(list[randPos]);
				list.splice(randPos, 1);
				
			}
			
			return list;
			
		}
		
	}
	
}
