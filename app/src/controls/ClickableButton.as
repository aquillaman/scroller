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
        
        public function ClickableButton(resource:DisplayObject) {
            super(resource);
        }
        
        private var _enabled:Boolean;
        public function set enabled(value:Boolean):void {
            if(resource is SimpleButton){
                (resource as SimpleButton).enabled = value;
            }
            _enabled = value;
        }
        public function get enabled():Boolean {
            return _enabled;
        }
        
        //===================== Controll Factories ===========================//
        
        public static function createSimpleControll(rect:Rectangle, color:uint=0, transperensy:Number=0.5):ClickableButton {
            var stroke:int = 2;
            var btn:SimpleButton = new SimpleButton(createState(rect,color,transperensy),createState(rect,color*0.5,transperensy),createState(rect,color*2,transperensy),createState(rect));
            btn.x = rect.x;
            btn.y = rect.y;
            
            return new ClickableButton(btn);
            
            function createState(rect:Rectangle, color:uint=0, transperensy:Number=0.5):DisplayObject{
                var holder:Sprite = new Sprite();
                holder.addChild(Helper.getShape(rect.width, rect.height, color, transperensy));
                return holder;
            }
        }
    }
}