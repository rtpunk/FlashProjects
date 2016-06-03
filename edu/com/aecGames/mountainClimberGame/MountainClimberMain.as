//  MountainClimberMain.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/26
//  Last Updated:	2011/03/28
//
//  This is the main document class for mountain climber games.

package aecGames.mountainClimberGame
{
	
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import aecGames.mountainClimberGame.MountainClimberGameModel;
	import aecGames.mountainClimberGame.MountainClimberGameController;
	import aecGames.mountainClimberGame.MountainClimberButtonController;
	import aecGames.sounds.SoundModel;
	
	public class MountainClimberMain extends MovieClip
	{
		
		/////  Variable Declaration  /////
		////////////////////////////////////////////////////////////
		//														  //
		//  _soundModel		-	Instance of the sound model.	  //
		//  _gameModel		-	Instance of the game model.		  //
		//  _gameController	-	Instance of the game controller.  //
		//														  //
		////////////////////////////////////////////////////////////
		
		private var _soundModel:SoundModel;
		private var _gameModel:MountainClimberGameModel;
		private var _gameController:MountainClimberGameController;
		
		public function MountainClimberMain()
		{
			
			//  We don't want the game to scale.
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//  Create the main MVC pattern.
			
			_soundModel = new SoundModel();
			_gameModel = new MountainClimberGameModel();
			_gameController = new MountainClimberGameController(_gameModel, _soundModel);
			addChild(_gameController);
			
		}
		
	}
	
}