//  MountainClimberMain.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/04/10
//  Last Updated:	2011/04/10
//
//  This is the main document class for mountain climber games.

package aecGames.blitzGame
{
	
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import aecGames.blitzGame.BlitzGameModel;
	import aecGames.blitzGame.BlitzGameController;
	import aecGames.blitzGame.BlitzButtonController;
	import aecGames.sounds.SoundModel;
	
	public class BlitzMain extends MovieClip
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
		private var _gameModel:BlitzGameModel;
		private var _gameController:BlitzGameController;
		
		public function BlitzMain()
		{
			
			//  We don't want the game to scale.
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//  Create the main MVC pattern.
			
			_soundModel = new SoundModel();
			_gameModel = new BlitzGameModel();
			_gameController = new BlitzGameController(_gameModel, _soundModel);
			addChild(_gameController);
			
		}
		
	}
	
}