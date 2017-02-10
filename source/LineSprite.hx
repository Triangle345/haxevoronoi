
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import haxevor.Line;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil.LineStyle;

// Draws a line
class LineSprite extends FlxSprite {
    public function new(line: Line) {
        super(1,1);
        makeGraphic(500,500, FlxColor.TRANSPARENT);


        var lineStyle:LineStyle = {color:FlxColor.BLUE, thickness:1};
        FlxSpriteUtil.drawLine(this,line.p1.x,line.p1.y,line.p2.x,line.p2.y, lineStyle);	

    }
}