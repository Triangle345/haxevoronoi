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

    // creates an equalateral triangle that perfectly 
    // encompasses this circle.
    // This method takes the range of X and Y values. It creates
    // a circle that encompasses this range.  It creates a triangle
    // using a formula which is:
    // area = 1/2 * b *h
    // height = 3r
    public function equalateralTriangle():Triangle {
        var side = ((radius * 3 ) * 2) / Math.sqrt(3);

        var mid = center - new Point(0,radius);

        // bot left
        var s1 = mid - new Point(side/2,0);

        // bot right
        var s2 = mid + new Point(side/2,0);

        //top mid
        var s3 = mid + new Point(0, radius * 3);

        return new Triangle(s1,s2,s3);
        
    }

    // Determines if this circle contains a point.
    // uses distance formula and checks if its within the radius, exculsive.
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