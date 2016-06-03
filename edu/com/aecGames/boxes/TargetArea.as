package aecGames.boxes
{
	import flash.display.Sprite;
	
	public class TargetArea extends Sprite
	{

		private var _currentTarget:int = 0;
		private var _targetList:Array = [];
		private var _isEnabled:Boolean = true;
		
		public var dragList:Array = [];

		public function TargetArea(catID:int, numTargets:int = 0, numCols = 2)
		{
			
			for(var i:int = 0; i < numTargets; ++i)
			{
				
				var target:DragTarget = new DragTarget(catID);
				_targetList.push(target);
				
			}
			
			var numRows:int = _targetList.length / numCols;
			
			var wp:Number = (width - numCols * target.width) / (numCols + 1);
			var hp:Number = (height - (numRows + 1) * target.height) / (numRows + 1);
			
			for(i = 0; i < numRows; ++i)
			{
				
				for(var j:int = 0; j < numCols; ++j)
				{
					
					var index:int = j + numCols * i;
					target = _targetList[index];
					target.x = target.width * (j + 0.5) + wp * (j + 1);
					target.y = 32 + target.height * (i + 0.5) + hp * (i + 1);
					addChild(target);
					
				}
				
			}
			
		}
		
		public function set heading(value:Sprite):void
		{
			
			value.x = 0.5 * (width - value.width);
			value.y = 5;
			addChild(value);
			
		}
		
		public function nextTarget():void
		{
			
			if(_currentTarget < _targetList.length - 1)
				++_currentTarget;
			else
				_isEnabled = false;
			
		}
		
		public function resetTargets():void
		{
			
			_currentTarget = 0;
			_isEnabled = true;
			
		}
		
		public function snapToCurrent(drag:DragBox, disable:Boolean = true):void
		{
			
			if(!_isEnabled)
			{
				
				drag.resetPos();
				return;
				
			}
			
			drag.x = x + _targetList[_currentTarget].x;
			drag.y = y + _targetList[_currentTarget].y;
			
			if(disable)
				drag.disable();
			drag.setIsCorrect(_targetList[_currentTarget].id);
			
			nextTarget();
			
		}
		
		public function snapToPos(drag:DragBox, index:int, disable:Boolean = true):void
		{
			
			drag.setPos(x + _targetList[index].x, y + _targetList[index].y);
			
			if(disable)
				drag.disable();
			drag.setIsCorrect(_targetList[index].id);
			
		}
		
	}
	
}
