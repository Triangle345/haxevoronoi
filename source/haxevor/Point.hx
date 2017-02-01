package haxevor;

class Point
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

    @:op(A == B)
    public static function equals(lhs:Point, rhs:Point):Bool {
        if (lhs.x == rhs.x && lhs.y == rhs.y) {
            return true;
        } else {
            return false;
        }
    }


    public function distanceFrom(o:Point)
    {
        return Math.sqrt(Math.pow(o.x - x,2) + Math.pow(o.y - y,2));
    }

}