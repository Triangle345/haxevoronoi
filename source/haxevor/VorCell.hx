package haxevor;

// VorCell represents a voronoi cell that contains a site and triangles.
class VorCell {
    // the voronoi site; aka the triangle points
    public var site = new Point(0,0);

    // the triangles that make up the cell ( good for finding the area TODO)
    public var triangles = new Array<Triangle>();

    // the border of this vor cell; aka the connection between triangle circumcircle centers
    public var border = new Array<Line>();

    public function new(site:Point, triangles:Array<Triangle>) {
        this.site = site;
        this.triangles = triangles;
        
        calculateBorder();
    }

    // calculates the borders between all triangles in triangulation
    private function calculateBorder() {
        var e2t = new Map<LineHash,Triangle>();

        // the below goes through all edges and initially places them in a map.
        // if an edge is already in a map, the triangles that contain the shared edge
        // are adjacent. We take the circumcircle of these triangles and connect them to
        // form the border of the voronoi.
        for (t in triangles) {            

            var edges = t.getEdges();

            // place each edge + triangle in a hash
            for (e in edges) {
                if (e2t[e.hashCode()] == null) {
                    e2t[e.hashCode()] = t;
                    
                } 
                // if edge is already hashed than we have a collision - an adjacent triangle.
                // add this new line to the border.
                else {
                    var c1 = t.circumcircle();
                    var c2 = e2t[e.hashCode()].circumcircle();
                    
                    border.push(new Line(c1.center,c2.center));
                }
            }

        }
    }
}