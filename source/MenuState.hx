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

import flixel.text.FlxText;


import flixel.util.FlxSpriteUtil;
import flixel.FlxSprite;

class MenuState extends FlxState
{
	
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
		
		var vor = new Voronoi();

		var pnts = new Array<Point>();
		pnts.push(new Point(100,100));
		pnts.push(new Point(50,75));
		pnts.push(new Point(200,120));

		var dtri = vor.BowyerWatson(pnts);

		trace('dualaney tri: $dtri');

		add(text);
		add(new CircleSprite(circle));
		add(new TriangleSprite(tri));

		var l = new Line(new Point(0,0), new Point(50,50));
		

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
