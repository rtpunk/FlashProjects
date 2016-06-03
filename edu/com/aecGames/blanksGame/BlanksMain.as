//  BlanksMain.as
//  For American Education Corporation
//  Programmer:  	Jeffrey Woidke
//  Created:		2011/03/29
//  Last Updated:	2011/03/29
//
//  This is the main document class for blanks games.

package aecGames.blanksGame
{
	
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import aecGames.blanksGame.BlanksGameModel;
	import aecGames.blanksGame.BlanksGameController;
	import aecGames.blanksGame.BlanksButtonController;
	import aecGames.sounds.SoundModel;
	
	public class BlanksMain extends MovieClip
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
		private var _gameModel:BlanksGameModel;
		private var _gameController:BlanksGameController;
		
		public function BlanksMain()
		{
			
			//  We don't want the game to scale.
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//  Create the main MVC pattern.
			
			_soundModel = new SoundModel();
			_gameModel = new BlanksGameModel();
			_gameController = new BlanksGameController(_gameModel, _soundModel);
			addChild(_gameController);
			
		}
		
	}
	
}