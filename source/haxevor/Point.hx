package haxevor;

class ConcretePoint
{

    public var x(default,default) = 0.0;
    public var y(default,default) = 0.0;

    public function new(x:Float = 0.0, y:Float = 0.0) {
        this.x = x;
        this.y = y;
    }
    public function toString():String
    {
        return ('Point: $x,$y');
    }
}

@:forward(x,y,toString)
abstract Point (ConcretePoint) from ConcretePoint to ConcretePoint{
    public function new(x:Float = 0.0, y:Float = 0.0) {
        this = new ConcretePoint(x,y);
    }
    
    public function hashCode():Int {
        
        return Std.int(((this.x + this.y) * (this.x + this.y + 1)/2) + this.y);
    }

    @:op(A == B)
    public static function equals(lhs:Point, rhs:Point):Bool {
        if (lhs.x == rhs.x && lhs.y == rhs.y) {
            return true;
        } else {
            return false;
        }
    }

    @:op(A + B)
    public static function addition(lhs:Point, rhs:Point):Point {
        return new Point(lhs.x + rhs.x, lhs.y + rhs.y);
    }

    @:op(A - B)
    public static function subtract(lhs:Point, rhs:Point):Point {
        return new Point(lhs.x - rhs.x, lhs.y - rhs.y);
    }

    @:op(A / B)
    public static function division(lhs:Point, div:Float):Point {
        return new Point(lhs.x/div, lhs.y/div);
    }


    // finds euclidean distance from anther point.
    public function distanceFrom(o:Point)
    {
        var p:Point = this;
        return Math.sqrt(Math.pow(o.x - p.x,2) + Math.pow(o.y - p.y,2));
    }

}