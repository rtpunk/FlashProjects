//  SoundModel.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/07
//  Last Updated:	2011/03/28
//
//  This class holds data for the game sounds.

package aecGames.sounds
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import aecGames.gameEvent.GameEvent;
	
	public class SoundModel extends EventDispatcher
	{
		
		/////  Variable Declaration  /////
		//////////////////////////////////////////////////////////
		//														//
		//  SOUND_DIRECTIONS	-	Direction sound effect.		//
		//  SOUND_CLICK			-	Button click sound effect.  //
		//														//
		//  _newSoundToPlay		-	The sound to be played.		//
		//  _newSoundToPause	-	The sound to be paused.		//
		//  _newSoundToStop		-	The sound to be stopped.	//
		//														//
		//////////////////////////////////////////////////////////
		
		public static const SOUND_DIRECTIONS:DirectionsSound = new DirectionsSound();
		public static const SOUND_CLICK:ClickSound = new ClickSound();
		
		private var _newSoundToPlay:GameSound;
		private var _newSoundToPause:GameSound;
		private var _newSoundToStop:GameSound;
		
		/////  Constructor  /////
		///////////////////////////////////////////////
		//											 //
		//  To do nothing is the way to be nothing.  //
		//											 //
		//  --Nathaniel Hawthorne					 //
		//											 //
		///////////////////////////////////////////////
		
		public function SoundModel()
		{			
		}
		
		/////  playSound(sound:GameSound, isDirections:Boolean = false):void  /////
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//																											//
		//  Plays the given sound.  Unfortunately, the flag is needed to control buttons on the directions screen.  //
		//																											//
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function playSound(sound:GameSound, isDirections:Boolean = false):void
		{
			
			_newSoundToPlay = sound;
			dispatchEvent(new GameEvent(GameEvent.PLAY_SOUND, true, false, isDirections));
			
		}
		
		/////  pauseSound(sound:GameSound):void  /////
		//////////////////////////////////////////////
		//											//
		//  Pauses the given sound.					//
		//											//
		//////////////////////////////////////////////
		
		public function pauseSound(sound:GameSound):void
		{
			
			_newSoundToPause = sound;
			dispatchEvent(new GameEvent(GameEvent.PAUSE_SOUND, true));
			
		}
		
		/////  stopSound(sound:GameSound):void  /////
		/////////////////////////////////////////////
		//										   //
		//  Stops the given sound.				   //
		//										   //
		/////////////////////////////////////////////
		
		public function stopSound(sound:GameSound = null):void
		{
			
			_newSoundToStop = sound;
			dispatchEvent(new GameEvent(GameEvent.STOP_SOUND, true));
			
		}
		
		/////  soundCompleteHandler():void  /////
		/////////////////////////////////////////////////////////////////
		//															   //
		//  Dispatches SOUND_COMPLETE when the sound reaches its end.  //
		//															   //
		/////////////////////////////////////////////////////////////////
		
		public function soundCompleteHandler(event:Event):void
		{
			
			dispatchEvent(new GameEvent(GameEvent.SOUND_COMPLETE, true));
			
		}
		
		/////  get newSoundToPlay():GameSound  /////
		////////////////////////////////////////////
		//										  //
		//  _newSoundToPlay Getter Method		  //
		//										  //
		////////////////////////////////////////////
		
		public function get newSoundToPlay():GameSound
		{
			
			return _newSoundToPlay;
			
		}
		
		/////  get newSoundToPause():GameSound  /////
		/////////////////////////////////////////////
		//										   //
		//  _newSoundToPause Getter Method		   //
		//										   //
		/////////////////////////////////////////////
		
		public function get newSoundToPause():GameSound
		{
			
			return _newSoundToPause;
			
		}
		
		/////  get newSoundToStop():GameSound  /////
		////////////////////////////////////////////
		//										  //
		//  _newSoundToStop Getter Method		  //
		//										  //
		////////////////////////////////////////////
		
		public function get newSoundToStop():GameSound
		{
			
			return _newSoundToStop;
			
		}
		
	}
	
}