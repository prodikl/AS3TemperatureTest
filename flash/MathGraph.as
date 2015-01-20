package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	/**
	 * ...
	 * @author Keith
	 */
	public class MathGraph extends Sprite
	{
		private var temperatures:Array = [];
		private var bars:Sprite;
		
		public function MathGraph():void 
		{
			// 1
			// create text inputs
			var numberOfTemperatures:uint = 7;
			for(var i:uint = 0; i < numberOfTemperatures; i++){
				//create
				var newTemperature:TextField = new TextField();
					newTemperature.width = 200;
					newTemperature.height = 30;
					newTemperature.type = TextFieldType.INPUT;
					newTemperature.border = true;
				// position
				newTemperature.y = i * 40 + 10;
				newTemperature.x = 10;
				// add to stage
				addChild(newTemperature);
				// add to array
				temperatures.push(newTemperature);
			}
			
			// 2
			// create calculate button
			var calculateButton:TextField = new TextField();
				calculateButton.selectable = false;
				calculateButton.text = "Calculate";
				// position
				calculateButton.y = 7 * 40 + 10;
				calculateButton.x = 10;
			// add to stage
			addChild(calculateButton);
			
			// 3
			// add event listener to button
			calculateButton.addEventListener(MouseEvent.CLICK, calculate);
		}
		private function calculate(e:MouseEvent):void {
			// check if all fields have content and are numbers
			var textField:TextField;
			for each(textField in temperatures) {
				if (textField.text == '' || isNaN(Number(textField.text))) return;
			}
			
			// task 1 : get average temp
			var totalTemperatures:Number = 0;
			var temperature:Number;
			for each(textField in temperatures) {
				temperature = Number(textField.text);
				totalTemperatures += temperature;
			}
			var averageTemperature:Number = totalTemperatures / temperatures.length;
			// show averageTemperature in a textField by setting textField.text = averageTemperature
			// but as an example i'll just output it
			trace("Average Temperature:" + averageTemperature);
			
			// task 2 : min & max temperatures	
			var maxTempNumbers:Array = [];
			for each(textField in temperatures) {
				temperature = Number(textField.text);
				maxTempNumbers.push(temperature);
			}
			maxTempNumbers.sort(Array.NUMERIC);
			var maxTemperature:Number = maxTempNumbers[maxTempNumbers.length - 1];
			var minTemperature:Number = maxTempNumbers[0];
			trace("Max Temperature:" + maxTemperature);
			trace("Min Temperature:" + minTemperature);
			
			// all done.. show bar graph
			showBarGraph(averageTemperature, minTemperature, maxTemperature);
		}
		private function showBarGraph(average:Number, min:Number, max:Number):void {
			// remove old bar graphs
			if (bars) {
				while (bars.numChildren) {
					bars.removeChildAt(0);
				}
			}
			
			bars = new Sprite();
			bars.x = 300;
			bars.y = 200;
			
			// create example bar graphs	
			var i:Number = 0;
			for each(var temp:Number in [average, min, max]) {
				var bar:Sprite = new Sprite();
				var graphics:Graphics = bar.graphics;
					graphics.beginFill(Math.random() * int.MAX_VALUE);
					graphics.drawRect(0, 0, 20, -temp);
				bar.x = i * 20;
				bars.addChild(bar);
				i++;
			}
			
			if(!contains(bars)) addChild(bars);
			
		}
	}

}