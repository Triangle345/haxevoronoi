
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import haxevor.Triangle;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil.LineStyle;
import flixel.math.FlxPoint;

class TriangleSprite extends FlxSprite {
    public function new(tri: Triangle) {
        super(1,1);
        makeGraphic(500,500, FlxColor.TRANSPARENT);
        var arry = new Array<FlxPoint>();
        arry.push(new FlxPoint(tri.p1.x,tri.p1.y));
        arry.push(new FlxPoint(tri.p2.x,tri.p2.y));
        arry.push(new FlxPoint(tri.p3.x,tri.p3.y));

        var lineStyle:LineStyle = {color:FlxColor.GREEN, thickness:1};
        FlxSpriteUtil.drawPolygon(this,arry,FlxColor.fromRGB(255,100,100,100), lineStyle);	

    }
}