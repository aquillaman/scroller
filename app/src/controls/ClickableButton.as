package controls
{
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    
    import utils.Helper;
    
    public class ClickableButton extends BaseControll
    {
        
        public static const DEFAULT_WIDTH   :int = 50;
        public static const DEFAULT_HEIGHT  :int = 20;
        
        public function ClickableButton(resource:DisplayObject)
        {
            super(resource);
        }
        
        //===================== Controll Factories ===========================//
        
        public static function createSimpleControll(rect:Rectangle):ClickableButton {
            var stroke:int = 2;
            var btn:SimpleButton = new SimpleButton(createState(rect,GREY),createState(rect,WHITE),createState(rect,DARK),createState(rect));
            btn.x = rect.x;
            btn.y = rect.y;
            
            return new ClickableButton(btn);
            
            function createState(rect:Rectangle ,color:uint=0):DisplayObject{
                var holder:Sprite = new Sprite();
                holder.addChild(Helper.getShape(rect.width, rect.height, color));
                return holder;
            }
        }
    }
}