//  BongoBingoMain.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/04/20
//  Last Updated:	2011/04/20
//
//  This is the main document class for bongo bingo games.

package aecGames.bongoBingoGame
{
	
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import aecGames.blitzGame.BlitzGameModel;
	import aecGames.blitzGame.BlitzGameController;
	import aecGames.blitzGame.BlitzButtonController;
	import aecGames.sounds.SoundModel;
	
	public class BongoBingoMain extends MovieClip
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
		private var _gameModel:BongoBingoGameModel;
		private var _gameController:BongoBingoGameController;
		
		public function BongoBingoMain()
		{
			
			//  We don't want the game to scale.
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//  Create the main MVC pattern.
			
			_soundModel = new SoundModel();
			_gameModel = new BongoBingoGameModel();
			_gameController = new BongoBingoGameController(_gameModel, _soundModel);
			addChild(_gameController);
			
		}
		
	}
	
}