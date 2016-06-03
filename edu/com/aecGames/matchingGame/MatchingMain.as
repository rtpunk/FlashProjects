//  MatchingMain.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/26
//  Last Updated:	2011/03/28
//
//  This is the main document class for matching games.

package aecGames.matchingGame
{
	
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import aecGames.matchingGame.MatchingGameModel;
	import aecGames.matchingGame.MatchingGameController;
	import aecGames.matchingGame.MatchingButtonController;
	import aecGames.sounds.SoundModel;
	
	public class MatchingMain extends MovieClip
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
		private var _gameModel:MatchingGameModel;
		private var _gameController:MatchingGameController;
		
		public function MatchingMain()
		{
			
			//  We don't want the game to scale.
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//  Create the main MVC pattern.
			
			_soundModel = new SoundModel();
			_gameModel = new MatchingGameModel();
			_gameController = new MatchingGameController(_gameModel, _soundModel);
			addChild(_gameController);
			
		}
		
	}
	
}