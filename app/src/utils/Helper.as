package utils
{
    import flash.display.Shape;
    
    public class Helper
    {
        public static function getShape(width:int, height:int, color:uint):Shape {
            var shape:Shape = new Shape();
            shape.graphics.lineStyle(1,color<<1);
            shape.graphics.beginFill(color, 0.5);
            shape.graphics.drawRect(0,0,width,height);
            shape.graphics.endFill();
            return shape;
        }
    }
}