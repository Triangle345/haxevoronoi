package haxevor;

class Circle
{
    public var radius:Float = 0.0;
    public var center:Point = new Point();

    public function new(center:Point, radius=0.0)
    {
        this.center = center;
        this.radius = radius;
    }

    public function contains(p:Point):Bool 
    {
        if (p.x <= center.x + radius && p.y <= center.y + radius){
            return true;
        }

        return false;
    }
}