
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import haxevor.Circle;
import flixel.util.FlxColor;

// Draws a circle
class CircleSprite extends FlxSprite {
    public function new(circle: Circle) {
        super(1,1);
        makeGraphic(500,500, FlxColor.TRANSPARENT);
        FlxSpriteUtil.drawCircle(this,circle.center.x ,circle.center.y ,circle.radius, FlxColor.fromRGB(100,100,100,100));	

    }
}