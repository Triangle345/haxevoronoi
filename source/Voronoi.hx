import haxevor.Point;
import haxevor.Triangle;
import haxevor.Line;
import haxevor.Circle;
import haxevor.VorCell;

class Voronoi
{
    var pnts = new Array<Point>();
    

    public function new() {

    }

    public function GenerateVoronoi(points:Array<Point>) : Array<VorCell> {
        var cells = new Array<VorCell>();
        var p2t = new Map<Point,Array<Triangle>>();
        var tris = BowyerWatson(points);
        
        for (t in tris) {
            var triPs = new Array<Point>();

            triPs.push(t.p1);
            triPs.push(t.p2);
            triPs.push(t.p3);

            // create a map of all points to all triangles that share that point.
            for (p in triPs) {
                if (p2t[p] == null) {
                    p2t[p] = new Array<Triangle>();
                    p2t[p].push(t);
                } else {
                    p2t[p].push(t);
                }
            }
        }

        for(key in p2t.keys()) {
            var vcell = new VorCell(key, p2t[key]);
            cells.push(vcell);
        }

        var test = new Map<Line, String>();
        var l = new Line(new Point(4,3), new Point(6,2));
        test[l] = "mytest";
        trace("TESTING IS: ", test[l]);

        return cells;

    }
    public function BowyerWatson(points:Array<Point>) : Array<Triangle> {
        var triangulation = new Array<Triangle>();

        this.pnts = points;



        var superTri = getSuperTri();

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

     public function getSuperTri():Triangle {
            
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

            var xMid = (highestX + lowestX)/2;
            var yMid = (highestY + lowestY)/2;
            var xRange = highestX - lowestX;
            var yRange = highestY - lowestY;
            
            var rad = (xRange > yRange) ? xRange/2: yRange/2;

            // neeed to add 1 to radius in case  point falls on the edge. Add another one for rounding
            var superCircle = new Circle(new Point(xMid,yMid),rad + 2);
            trace('super circle: $superCircle');


            var superTri = superCircle.equalateralTriangle();

            trace('super tri: $superTri');

            return superTri;
        }

}