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

    public function getEdges(): Array<Line> {
        var t:Triangle = this;
        var edges = new Array<Line>();

        edges.push(new Line(t.p1,t.p2));
        edges.push(new Line(t.p2,t.p3));
        edges.push(new Line(t.p1,t.p3));

        return edges;
    }

    public function containsPoint(p:Point):Bool {
        
        var t:Triangle = this;
        trace('comparing p: $p to triangle: $t');
        if (p == t.p1 || p == t.p2 || p == t.p3) {
            trace("TRUE");
            return true;
        }

        trace("FALSE");
        return false;
    }

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

    public function circumcircle() : Circle
    {

        var t:Triangle = this;

        var center:Point = null;

        var l1 = new Line(t.p1,t.p2);        
        var l2 = new Line(t.p1,t.p3);
        var l3 = new Line(t.p2,t.p3);

        var lines = new Array<Line>();


        try 
        {
            var l1p = l1.perpBisect();
            lines.push(l1p);
        } catch(s:String){}
        
        try 
        {
            var l2p = l2.perpBisect();
            lines.push(l2p);
        }catch(s:String){}

        try 
        {
            var l3p = l3.perpBisect();
            lines.push(l3p);
        }catch (s:String){}


        if (lines.length <= 1) 
        {
            throw("Cannot find perpendicular bisector of any points in triangle: " + this);
        }


        var tmpLine:Line = null;

        for (line in lines) 
        {
            if (tmpLine == null) {
                tmpLine = line;
                continue;
            }        

            center = tmpLine.intersection(line);

    }

        //trace('intersection1: $intPnt1');

               // var intPnt2 = l1p.intersection(l3p);
        //trace('intersection2: $intPnt2');


        return new Circle(center, center.distanceFrom(t.p1));
    }
}