//  GameSound.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/07
//  Last Updated:	2011/03/28
//
//  This class adds functionality to the standard sound class.

package aecGames.sounds
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class GameSound extends Sound
	{
		
		/////  Variable Declaration  /////
		/////////////////////////////////////////////////////////////////////////
		//																	   //
		//  name			-	The name of the sound.						   //
		//  channel			-	A SoundChannel to play this sound.			   //
		//  lastPosition	-	The last position of the sound playhead.	   //
		//  isPlaying		-	Bool indicating whether the sound is playing.  //
		//																	   //
		/////////////////////////////////////////////////////////////////////////
		
		public var name:String;
		public var channel:SoundChannel = new SoundChannel();
		public var lastPosition:Number = 0;
		public var isPlaying:Boolean = false;
		
		/////  Constructor  /////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//																												  //
		//  To do nothing at all is the most difficult thing in the world, the most difficult and the most intellectual.  //
		//																												  //
		//  --Oscar Wilde																								  //
		//																												  //
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function GameSound()
		{			
		}
		
	}
	
}