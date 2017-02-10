package haxevor;


class ConcreteLine 
{
    public var p1 = new Point();
    public var p2 = new Point();

    public function new(p1:Point, p2:Point) {
        this.p1 = p1;
        this.p2 = p2;
    }

    
}

@:forward(p1,p2)
abstract Line(ConcreteLine) from ConcreteLine to ConcreteLine {
    public inline function new(p1:Point, p2:Point) {
        this = new ConcreteLine(p1,p2);
        
    }
    @:op(A == B)
    public static inline function equals(lhs:Line, rhs:Line):Bool {
        if ( (lhs.p1 == rhs.p1 || lhs.p1 == rhs.p2) && 
            (lhs.p2 == rhs.p2 || lhs.p2 == rhs.p1)) {
            
            return true;
        } else {
            return false;
        }
    }

    // finds the slope. Throws if undefined.
    public inline function slope() : Float {

        var line:Line = this;

        if (line.p2.x - line.p1.x == 0) {
            throw "undefined slope! : " + line.p1 + ","+ line.p2;
        }

        return (line.p2.y - line.p1.y) / (line.p2.x - line.p1.x);
    }


    // finds perpendicular bisector.
    // basically the mid point with inverse slope.
    // throws if slope undefined.
    public function perpBisect(): Line {


        var slope = 0.0;
        var line:Line = this;
        
        var mp = midpoint();

        try {
            slope = line.slope();

        } catch(s:String) {

            // slope of perp is horizontal line; 0.
            var b = mp.y;

            var pp2 = new Point(0, b);

            // y = mPerp * x + b
            return new Line(mp, pp2);
        }

        // if slope of this line is zero we know its a horizontal Line
        // the perp of a horizontal line is a virtical line which is undefined.
        if (slope == 0) {
            throw "Perp is Vertical line, no slope defined for bisector!" + this ;
        }

        // if slope is undefined then we know its a vertical line..
        // the perpendicular of virtical line is a horizontal line with slope 0
        var mPerp = (1/slope) * -1;


        var b = (-1 * (mPerp * mp.x) ) + mp.y;

        var pp2 = new Point(0, b);

        // y = mPerp * x + b
        return new Line(mp, pp2);
    }

    public function intercept():Float
    {
        var line:Line = this;

        var slope = line.slope();
        return (-1 * (slope * line.p1.x)) + line.p1.y;
    }

    public function midpoint() : Point {
        var line:Line = this;
        return new Point( (line.p1.x + line.p2.x) / 2, (line.p1.y + line.p2.y) / 2);

    }

    
    public function hashCode():Int {
        var mid = midpoint();
        return mid.hashCode();
    }


    

    public function intersection(other:Line):Point
    {

        var mym = slope();
        var myint = intercept();

        var otherm = other.slope();
        var otherint = other.intercept();

        var xint = (otherint - myint) / (mym - otherm);
        var yint = (mym * xint) + myint;

        return new Point(xint, yint);


    }
}

