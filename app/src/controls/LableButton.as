package controls
{
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    
    import utils.Helper;
    
    public class LableButton extends BaseControll
    {
        
        
        public function LableButton(resource:DisplayObject) {
            super(resource);
        }
        
        public static function createLableButton(postion:Point, lable:String):LableButton {
            var stroke:int = 2;
            var btn:SimpleButton = new SimpleButton(createState(lable,Helper.GREY),createState(lable,Helper.WHITE),createState(lable,Helper.DARK),createState(lable));
            btn.x = postion.x;
            btn.y = postion.y;
            
            return new LableButton(btn);
            
            function createState(value:String = '',color:uint = 0):DisplayObject{
                var holder:Sprite = new Sprite();
                
                var bgW:int = 50;
                var bgH:int = 20;
                
                var lable:TextField = new TextField();
                lable.autoSize = TextFieldAutoSize.LEFT;
                lable.text = value;
                
                bgW = lable.width + (stroke*2);
                bgH = lable.height + (stroke*2);
                
                lable.x += stroke;
                lable.y += stroke;

                holder.addChild(Helper.getShape(bgW,bgH, color));
                holder.addChild(lable);
                
                return holder;
            }
        }
    }
}