package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

import haxevor.Point;
import haxevor.Line;
import haxevor.Triangle;
import haxevor.Circle;
import neko.vm.Thread;

import flixel.text.FlxText;


import flixel.util.FlxSpriteUtil;
import flixel.FlxSprite;

class MenuState extends FlxState
{
	var vor = new Voronoi();
	var pnts = new Array<Point>();
	override public function create():Void
	{
		super.create();
		var text = new FlxText(50,50, 200, "test text" ,12);

		var line = new Line(new Point(2,5), new Point(8,3));

		var midpoint = line.midpoint();
		var slope = line.slope();
		var intercept = line.intercept();

		trace('midpoint $midpoint');
		trace('slope: $slope');
		trace('intercept: $intercept');

		var perp = line.perpBisect();

		trace('perp line: $perp');

		intercept = perp.intercept();
		trace('perp line intercept: $intercept');

		var line2 = new Line(new Point(-2,-5), new Point(0,5));

		var midpoint = line2.midpoint();
		var slope = line2.slope();
		var intercept = line2.intercept();

		trace('midpoint2 $midpoint');
		trace('slope2: $slope');
		trace('intercept2: $intercept');

		var intercect = line.intersection(line2);

		trace('intersection: $intercect');


		var tri = new Triangle(new Point(100,70), new Point(200,70), new Point(200,300));

		var circle = tri.circumcircle();
		trace('Circle: $circle');
		
		

		
		pnts.push(new Point(130,140));
		pnts.push(new Point(175,300));
		pnts.push(new Point(205,110));
		pnts.push(new Point(220,200));
		pnts.push(new Point(250,185));

		// pnts.push(new Point(300,230));

		Thread.create(_testThread);
		
		var dtri = vor.BowyerWatson(pnts);
		

		//add(text);
		//add(new CircleSprite(circle));
		//add(new TriangleSprite(tri));

			
			for (t in dtri) {
				add(new TriangleSprite(t));

				add(new FlxText(t.p1.x,t.p1.y, 50, t.p1.toString() ,7));
				add(new CircleSprite(new Circle(t.p1,3)));

				add(new CircleSprite(new Circle(t.p2,3)));
				add(new FlxText(t.p2.x,t.p2.y, 50, t.p2.toString() ,7));

				add(new CircleSprite(new Circle(t.p3,3)));
				add(new FlxText(t.p3.x,t.p3.y, 50, t.p3.toString() ,7));
				
				
			
			}
		

	}
	private function _testThread() : Void
	{
		Sys.sleep(2);
		// var test = vor.BowyerWatson(pnts);
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (FlxG.mouse.justReleasedRight) {
			// this.clear();
			// pnts.push(new Point(FlxG.mouse.getPosition().x,FlxG.mouse.getPosition().y));
			// var vor = new Voronoi();
			// trace(FlxG.mouse.getPosition());
			// var dtri = vor.BowyerWatson(pnts);
			// trace('dualaney tri: $dtri');
			// for (t in dtri) {
			// add(new TriangleSprite(t));

			// add(new FlxText(t.p1.x,t.p1.y, 50, t.p1.toString() ,7));
			// add(new CircleSprite(new Circle(t.p1,2)));

			// add(new CircleSprite(new Circle(t.p2,2)));
			// add(new FlxText(t.p3.x,t.p3.y, 50, t.p3.toString() ,7));

			// add(new CircleSprite(new Circle(t.p3,2)));
			// add(new FlxText(t.p3.x,t.p3.y, 50, t.p3.toString() ,7));
			
			}
			// var dtri = this.vor.triangulation;
			
			// for (t in dtri) {
			// 	add(new TriangleSprite(t));

			// 	add(new FlxText(t.p1.x,t.p1.y, 50, t.p1.toString() ,7));
			// 	add(new CircleSprite(new Circle(t.p1,3)));

			// 	add(new CircleSprite(new Circle(t.p2,3)));
			// 	add(new FlxText(t.p2.x,t.p2.y, 50, t.p2.toString() ,7));

			// 	add(new CircleSprite(new Circle(t.p3,3)));
			// 	add(new FlxText(t.p3.x,t.p3.y, 50, t.p3.toString() ,7));
				
				
			
			// }

		Sys.sleep(.01);
		
	}
}
