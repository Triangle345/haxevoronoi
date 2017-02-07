package haxevor;


class VorCell {
    public var site = new Point(0,0);
    public var triangles = new Array<Triangle>();

    public var border = new Array<Line>();

    public function new(site:Point, triangles:Array<Triangle>) {
        this.site = site;
        this.triangles = triangles;
        
        calculateBorder();
    }

    private function calculateBorder() {
        var e2t = new Map<LineHash,Triangle>();

        for (t in triangles) {
            

            var edges = t.getEdges();
            for (e in edges) {
                trace('attempting to get tri from hash: ', e2t[e.hashCode()]);
                if (e2t[e.hashCode()] == null) {
                    // trace('EDGE NEW: $e with hash:' + e.hashCode());
                    e2t[e.hashCode()] = t;
                    
                } else {
                    trace('EDGE EXISTS');
                    var c1 = t.circumcircle();
                    var c2 = e2t[e.hashCode()].circumcircle();
                    
                    border.push(new Line(c1.center,c2.center));
                }
                trace('AFTER ADDING NEW EDGE:', e2t[e.hashCode()]);
            }

        }
        trace("keys: ", e2t);
    }
}