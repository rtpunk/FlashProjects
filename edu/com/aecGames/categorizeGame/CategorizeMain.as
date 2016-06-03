//  CategorizeMain.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/26
//  Last Updated:	2011/04/09
//
//  This is the main document class for matching games.

package aecGames.categorizeGame
{
	
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import aecGames.categorizeGame.CategorizeGameModel;
	import aecGames.categorizeGame.CategorizeGameController;
	import aecGames.categorizeGame.CategorizeButtonController;
	import aecGames.sounds.SoundModel;
	
	public class CategorizeMain extends MovieClip
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
		private var _gameModel:CategorizeGameModel;
		private var _gameController:CategorizeGameController;
		
		public function CategorizeMain()
		{
			
			//  We don't want the game to scale.
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//  Create the main MVC pattern.
			
			_soundModel = new SoundModel();
			_gameModel = new CategorizeGameModel();
			_gameController = new CategorizeGameController(_gameModel, _soundModel);
			addChild(_gameController);
			
		}
		
	}
	
}