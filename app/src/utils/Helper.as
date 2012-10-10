package utils
{
    import flash.display.Shape;
    
    public class Helper
    {
        public static const GREY:uint   = 0xCCCCCC;
        public static const DARK:uint   = 0xEEEEEE;
        public static const WHITE:uint  = 0xAAAAAA;
        
        public static function getShape(width:int, height:int, color:uint,transperensy:Number=0.5):Shape {
            var shape:Shape = new Shape();
            shape.graphics.lineStyle(1,color<<1);
            shape.graphics.beginFill(color,transperensy);
            shape.graphics.drawRect(0,0,width,height);
            shape.graphics.endFill();
            return shape;
        }
    }
}