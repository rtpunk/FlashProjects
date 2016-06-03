//  ThreeColumnMain.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/05/14
//  Last Updated:	2011/05/14
//
//  This is the main document class for 3 column games.

package aecGames.threeColumnGame
{
	
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import aecGames.threeColumnGame.ThreeColumnGameModel;
	import aecGames.threeColumnGame.ThreeColumnGameController;
	import aecGames.threeColumnGame.ThreeColumnButtonController;
	import aecGames.sounds.SoundModel;
	
	public class ThreeColumnMain extends MovieClip
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
		private var _gameModel:ThreeColumnGameModel;
		private var _gameController:ThreeColumnGameController;
		
		public function ThreeColumnMain()
		{
			
			//  We don't want the game to scale.
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//  Create the main MVC pattern.
			
			_soundModel = new SoundModel();
			_gameModel = new ThreeColumnGameModel();
			_gameController = new ThreeColumnGameController(_gameModel, _soundModel);
			addChild(_gameController);
			
		}
		
	}
	
}