//  CarnivalMain.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/05/09
//  Last Updated:	2011/05/09
//
//  This is the main document class for carnival games.

package aecGames.carnivalGame
{
	
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import aecGames.carnivalGame.CarnivalGameModel;
	import aecGames.carnivalGame.CarnivalGameController;
	import aecGames.carnivalGame.CarnivalButtonController;
	import aecGames.sounds.SoundModel;
	
	public class CarnivalMain extends MovieClip
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
		private var _gameModel:CarnivalGameModel;
		private var _gameController:CarnivalGameController;
		
		public function CarnivalMain()
		{
			
			//  We don't want the game to scale.
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//  Create the main MVC pattern.
			
			_soundModel = new SoundModel();
			_gameModel = new CarnivalGameModel();
			_gameController = new CarnivalGameController(_gameModel, _soundModel);
			addChild(_gameController);
			
		}
		
	}
	
}