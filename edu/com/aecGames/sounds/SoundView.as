//  SoundView.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/07
//  Last Updated:	2011/03/28
//
//  This class handles sound functions.

package aecGames.sounds
{
	
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.events.Event;
	import aecGames.gameEvent.GameEvent;
	
	public class SoundView
	{
		
		/////  Variable Declaration  /////
		/////////////////////////////////////////////////////////////
		//														   //
		//  _model			-	A reference to the sound model.	   //
		//  _soundTransform	-	Used to control the sound volume.  //
		//														   //
		/////////////////////////////////////////////////////////////
		
		private var _model:SoundModel;
		private var _soundTransform:SoundTransform = new SoundTransform();
		
		/////  Constructor  /////
		////////////////////////////////////////
		//									  //
		//  Pass in the sound model.		  //
		//  Set the sound to half.			  //
		//  Add the sound control listeners.  //
		//									  //
		////////////////////////////////////////
		
		public function SoundView(model:SoundModel)
		{
			
			_model = model;
			
			_soundTransform.volume = 0.5;
			
			_model.addEventListener(GameEvent.PLAY_SOUND, playSoundHandler);
			_model.addEventListener(GameEvent.PAUSE_SOUND, pauseSoundHandler);
			_model.addEventListener(GameEvent.STOP_SOUND, stopSoundHandler);
			
		}
		
		/////  playSoundHandler(event:GameEvent):void  /////
		/////////////////////////////////////////////////////////////////////////////////////
		//																				   //
		//  Plays the sound. Indicates the sound, position, and whether it is directions.  //
		//																				   //
		/////////////////////////////////////////////////////////////////////////////////////
		
		private function playSoundHandler(event:GameEvent):void
		{
			
			var sound:GameSound = _model.newSoundToPlay;
			
			//  Play from the last position. This handles cases when the sound has been paused.
			
			sound.channel = sound.play(sound.lastPosition);
			sound.channel.soundTransform = _soundTransform;
			
			//  If this sound is game directions, listen for completion.
			
			if(event.data)
				sound.channel.addEventListener(Event.SOUND_COMPLETE, _model.soundCompleteHandler);
			
		}
		
		/////  pauseSoundHandler(event:GameEvent):void  /////
		///////////////////////////////////////////////////////
		//													 //
		//  Pauses the sound and records the last position.  //
		//													 //
		///////////////////////////////////////////////////////
		
		private function pauseSoundHandler(event:GameEvent):void
		{
			
			var sound:GameSound = _model.newSoundToPause;
			
			sound.lastPosition = sound.channel.position;
			sound.channel.stop();
			
		}
		
		/////  stopSoundHandler(event:GameEvent):void  /////
		////////////////////////////////////////////////////
		//												  //
		//  Stops the sound.							  //
		//												  //
		////////////////////////////////////////////////////
		
		private function stopSoundHandler(event:GameEvent):void
		{
			
			var sound:GameSound = _model.newSoundToStop;
			
			sound.lastPosition = 0;
			sound.channel.stop();
			
		}
		
	}
	
}