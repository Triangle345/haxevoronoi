package;

import flixel.FlxState;
import haxevor.Point;
import haxevor.Circle;
import haxevor.Voronoi;
import flixel.text.FlxText;

class VorTest extends FlxState
{
	var vor = new Voronoi();
	var pnts = new Array<Point>();
	override public function create():Void
	{
		super.create();		
		
		pnts.push(new Point(130,140));
		pnts.push(new Point(175,300));
		pnts.push(new Point(205,110));
		pnts.push(new Point(220,200));
		pnts.push(new Point(250,185));

		pnts.push(new Point(300,230));
		pnts.push(new Point(400,230));
		pnts.push(new Point(400,120));

		pnts.push(new Point(10,5));
		pnts.push(new Point(50,111));
		pnts.push(new Point(400,320));

		
		var dtri = vor.GenerateTriangulation(pnts);
		
		// draw triangulation	
		for (t in dtri) {
			add(new TriangleSprite(t));

			add(new FlxText(t.p1.x,t.p1.y, 50, t.p1.toString() ,7));
			add(new CircleSprite(new Circle(t.p1,3)));

			add(new CircleSprite(new Circle(t.p2,3)));
			add(new FlxText(t.p2.x,t.p2.y, 50, t.p2.toString() ,7));

			add(new CircleSprite(new Circle(t.p3,3)));
			add(new FlxText(t.p3.x,t.p3.y, 50, t.p3.toString() ,7));
		
		}

		var cells = vor.GenerateVoronoi(pnts);

		// draw voronoi on top of triangulation
		for (c in cells) {
			for (e in c.border) {
				add(new LineSprite(e));
			}
			
		}		
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
	}
}
