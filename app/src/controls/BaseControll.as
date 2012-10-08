package controls
{
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFieldType;
    
    public class BaseControll
    {
        protected static const GREY:uint = 0xCCCCCC;
        protected static const DARK:uint = 0xEEEEEE;
        protected static const WHITE:uint = 0xAAAAAA;
        
        protected var _resource:DisplayObject;
        
        public function BaseControll(resource:DisplayObject) {
            this._resource = resource;
            addListeners();
        }
        
        private function addListeners():void {
            this._resource.addEventListener(MouseEvent.CLICK, clickHandler);
            this._resource.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
            this._resource.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
        }
        
        public function get resource():DisplayObject {
            return _resource;
        }
        
        //========================= Event Handlers ===========================//
        protected function clickHandler(event:MouseEvent):void {
            // override
        }
        protected function outHandler(event:MouseEvent):void {
            // override
        }
        protected function overHandler(event:MouseEvent):void {
            // override
        }
        //======================EOF Event Handlers ===========================//
        
        
        public static function createTextField(rect:Rectangle):TextField {
            var textField:TextField = new TextField();
            textField.x         = rect.x;
            textField.y         = rect.y;
            textField.width     = rect.width;
            textField.height    = rect.height;
            
            textField.border    = true;
            textField.type      = TextFieldType.INPUT;
            
            return textField;
        }
    }
}