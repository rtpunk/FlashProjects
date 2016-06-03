//  JeopardyMain.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/05/17
//  Last Updated:	2011/05/17
//
//  This is the main document class for jeopardy games.

package aecGames.jeopardyGame
{
	
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import aecGames.jeopardyGame.JeopardyGameModel;
	import aecGames.jeopardyGame.JeopardyGameController;
	import aecGames.jeopardyGame.JeopardyButtonController;
	import aecGames.sounds.SoundModel;
	
	public class JeopardyMain extends MovieClip
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
		private var _gameModel:JeopardyGameModel;
		private var _gameController:JeopardyGameController;
		
		public function JeopardyMain()
		{
			
			//  We don't want the game to scale.
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//  Create the main MVC pattern.
			
			_soundModel = new SoundModel();
			_gameModel = new JeopardyGameModel();
			_gameController = new JeopardyGameController(_gameModel, _soundModel);
			addChild(_gameController);
			
		}
		
	}
	
}