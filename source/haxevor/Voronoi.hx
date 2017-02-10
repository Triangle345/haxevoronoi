package haxevor;


// Voronoi is the main class used to calculate the voronoi diagram.
// in addition it can also create a d. triangulation.
class Voronoi
{
    // the points we recvd as input
    var pnts = new Array<Point>();
    
    // empty constructor
    public function new() {}

    // Generate a voronoi diagram from a list of points.
    public function GenerateVoronoi(points:Array<Point>) : Array<VorCell> {

        // we are returning these cells.
        var cells = new Array<VorCell>();

        // need a mapping of triangle point to the triangles that share it.. 
        // a cell is located here
        var p2t = new Map<Point,Array<Triangle>>();

        // triangulation is dual of voronoi
        var tris = GenerateTriangulation(points);
        
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

        // create a proper voronoi cell with all triangles we found from that cell; find the border.
        for(key in p2t.keys()) {
            var vcell = new VorCell(key, p2t[key]);
            cells.push(vcell);
        }


        return cells;

    }

    // Generates a d. triangulation.  BowerWatson algorithm(sp?)
    public function GenerateTriangulation(points:Array<Point>) : Array<Triangle> {
        var triangulation = new Array<Triangle>();

        this.pnts = points;

        var superTri = getSuperTri();
        triangulation.push(superTri);


        for (p in pnts) 
        {
            //TODO this needs to be a set
            var badTris = new Array<Triangle> ();

            for (t in triangulation)
            {
                var circle = t.circumcircle();
                
                if (circle.contains(p)) {
                    if (badTris.indexOf(t) < 0){
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

                    // since i did not use proper sets.. we need to make sure no dups
                    for (t in badTris) {
                        if (t.containsLine(e)) {
                            hitcount ++;
                        }
                    }

                    // only shared by source triangle and nothing else, add
                    if (hitcount == 1) {
                        
                        if (polygon.indexOf(e) < 0) {
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
                triangulation.push(newtri);
            }
        }

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

        return triangulation;
    }

     // creates a super triangle from the points input.
     // Finds the range of X,Y and uses that to find a circle, which
     // then gives us an equalateral triangle based on a formula.
     public function getSuperTri():Triangle {

        // sort by y so we can find y range  
        haxe.ds.ArraySort.sort(pnts, function(a:Point,b:Point):Int {
                if (a.y < b.y) return -1;
                else if (a.y > b.y) return 1;
                return 0;
            });

            var highestY = pnts[pnts.length - 1].y;
            var lowestY = pnts[0].y;



            trace('highestY: $highestY | lowestY: $lowestY');

            // sort by x so we can find x range.
            haxe.ds.ArraySort.sort(pnts, function(a:Point,b:Point):Int {
                if (a.x < b.x) return -1;
                else if (a.x > b.x) return 1;
                return 0;
            });

            var highestX = pnts[pnts.length - 1].x;
            var lowestX = pnts[0].x;

            trace('highestX: $highestX | lowestX: $lowestX');

            // find the mid of range
            var xMid = (highestX + lowestX)/2;
            var yMid = (highestY + lowestY)/2;

            // find the actual range.
            var xRange = highestX - lowestX;
            var yRange = highestY - lowestY;
            
            // the radius is our furthest value.
            var rad = (xRange > yRange) ? xRange/2: yRange/2;

            // neeed to add 1 to radius in case  point falls on the edge. Add another one for rounding
            var superCircle = new Circle(new Point(xMid,yMid),rad + 2);

            var superTri = superCircle.equalateralTriangle();

            trace('super tri: $superTri');

            return superTri;
        }

}