package haxevor;


class ConcreteTriangle
{

    public var p1 = new Point();
    public var p2 = new Point();
    public var p3 = new Point();

    public function new (p1: Point, p2: Point, p3: Point)
    {
        this.p1 = p1;
        this.p2 = p2;
        this.p3 = p3;
    }
}

// abstract triangle wraps concrete triangle to overload operators.
@:forward(p1,p2,p3)
abstract Triangle(ConcreteTriangle) from ConcreteTriangle to ConcreteTriangle
{
    public function new (p1: Point, p2: Point, p3: Point)
    {
        this = new ConcreteTriangle(p1,p2,p3);
    }

    @:op(A == B)
    public static function equals(lhs:Triangle, rhs:Triangle):Bool {
        
        if ( (lhs.p1 == rhs.p1 || lhs.p1 == rhs.p2 || lhs.p1 == rhs.p3) && 
            (lhs.p2 == rhs.p1 || lhs.p2 == rhs.p2|| lhs.p2 == rhs.p3) &&
            (lhs.p3 == rhs.p1 || lhs.p3 == rhs.p2|| lhs.p3 == rhs.p3)) {
            return true;
        } else {
            return false;
        }
    }

    // returns edges of this triangle from points.
    public function getEdges(): Array<Line> {
        var t:Triangle = this;
        var edges = new Array<Line>();

        edges.push(new Line(t.p1,t.p2));
        edges.push(new Line(t.p2,t.p3));
        edges.push(new Line(t.p1,t.p3));

        return edges;
    }

    // determines if a point is one of the 3 points of the triangle.
    // this should maybe renamed because it does NOT calculate if a point is inside.
    public function containsPoint(p:Point):Bool {
        
        var t:Triangle = this;
        if (p == t.p1 || p == t.p2 || p == t.p3) {
            return true;
        }

        return false;
    }

    // same as contains point. Does NOT calculate if line is inside but
    // simply tries to match if the line exists as one of the 3 point pairs.
    public function containsLine(l:Line):Bool {
        var t:Triangle = this;

        var e1 = new Line(t.p1,t.p2);
        var e2 = new Line(t.p1,t.p3);
        var e3 = new Line(t.p2,t.p3);

        if (e1 == l || e2 == l || e3 == l) {
            return true;
        }

        return false;
    }

    // returns circumcirlce of this triangle.
    // If this triangle contains at least 2 valid perpendicular 
    // bisectors, it can find the semicircle. Otherwise throws an error.
    public function circumcircle() : Circle
    {

        var t:Triangle = this;

        var center:Point = null;

        var l1 = new Line(t.p1,t.p2);        
        var l2 = new Line(t.p1,t.p3);
        var l3 = new Line(t.p2,t.p3);

        var lines = new Array<Line>();

        // find perp bisector of all three edges
        try 
        {
            var l1p = l1.perpBisect();
            lines.push(l1p);
        } catch(s:String){trace(s);}
        
        try 
        {
            var l2p = l2.perpBisect();
            lines.push(l2p);
        }catch(s:String){trace(s);}

        try 
        {
            var l3p = l3.perpBisect();
            lines.push(l3p);
        }catch (s:String){trace(s);}


        // need at least 2 edges to find the circumcircle.
        if (lines.length <= 1) 
        {
            throw("Cannot find perpendicular bisector of any points in triangle: " + this);
        }


        var tmpLine:Line = null;

        // this simply finds the intersection of 2 or more lines.
        for (line in lines) 
        {
            if (tmpLine == null) {
                tmpLine = line;
                continue;
            }        

            center = tmpLine.intersection(line);
    }

        return new Circle(center, center.distanceFrom(t.p1));
    }
}