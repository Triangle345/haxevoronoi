import haxevor.Point;
import haxevor.Triangle;
import haxevor.Line;

class Voronoi
{
    var pnts = new Array<Point>();
    public var triangulation = new Array<Triangle>();
    public function new() {

    }

    public function BowyerWatson(points:Array<Point>) : Array<Triangle> {
        

        this.pnts = points;



        haxe.ds.ArraySort.sort(pnts, function(a:Point,b:Point):Int {
            if (a.y < b.y) return -1;
            else if (a.y > b.y) return 1;
            return 0;
        });

        var highestY = pnts[pnts.length - 1].y;
        var lowestY = pnts[0].y;



        trace('highestY: $highestY | lowestY: $lowestY');

            haxe.ds.ArraySort.sort(pnts, function(a:Point,b:Point):Int {
            if (a.x < b.x) return -1;
            else if (a.x > b.x) return 1;
            return 0;
        });

        var highestX = pnts[pnts.length - 1].x;
        var lowestX = pnts[0].x;

        trace('highestX: $highestX | lowestX: $lowestX');

        var superTri = new Triangle(
                new Point(lowestX-lowestX-300 , highestY + 100),
                new Point(highestX + highestX + 400, highestY + 100), 
                new Point((highestX*2 - 0)/2, lowestY - lowestY));

        triangulation.push(superTri);


        for (p in pnts) 
        {
            trace('POINT: $p');
            //TODO this needs to be a set
            var badTris = new Array<Triangle> ();

            for (t in triangulation)
            {
                var circle = t.circumcircle();
                
                if (circle.contains(p)) {
                    if (badTris.indexOf(t) < 0){
                        trace('circle:$circle contains piont: $p adding: $t');
                        badTris.push(t);
                    }
                }
            }
            //TODO needs to be a sets
            var polygon = new Array<Line>();
            for (t in badTris) {
                var edges = t.getEdges();

                for (e in edges) {
                    var hitcount = 0;
                    trace('edge comparing in bad tris: $e');
                    for (t in badTris) {
                        if (t.containsLine(e)) {
                            trace('tri $t contains $e');
                            hitcount ++;
                        }
                    }
                    // only shared by source triangle and nothing else, add
                    if (hitcount == 1) {
                        
                        if (polygon.indexOf(e) < 0) {
                            trace('adding to polycount: $e');
                            polygon.push(e);
                        }

                        hitcount = 0;
                    }
                }

            }

            for (t in badTris) {
                triangulation.remove(t);
            }

            for (e in polygon) {
                var newtri = new Triangle(p, e.p1, e.p2);
                trace('created new triangle $newtri');
                triangulation.push(newtri);
            }
            trace('TRIANGULATION b4 sleep is: $triangulation');
        }
        trace('triangulation before : $triangulation');

        var removeLst = new Array<Triangle>();

        for (t in triangulation) {
            if (t.containsPoint(superTri.p1) || 
                t.containsPoint(superTri.p2) || 
                t.containsPoint(superTri.p3)  ) {

                removeLst.push(t);

            }
        }

        for (t in removeLst) {
             triangulation.remove(t);
        }

        trace('triangulation after : $triangulation');
        trace('super tri: $superTri');
        return triangulation;
    }

}