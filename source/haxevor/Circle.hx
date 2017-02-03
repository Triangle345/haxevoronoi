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

        var distance = 
            Math.sqrt(Math.pow((p.x - center.x),2) + Math.pow((p.y - center.y),2));

        if (distance < radius){
            return true;
        }

        return false;
    }
}