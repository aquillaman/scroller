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
        protected var _resource:DisplayObject;
        
        public function BaseControll(resource:DisplayObject) {
            this._resource = resource;
            addListeners();
        }
        
        private function addListeners():void {
            this._resource.addEventListener(MouseEvent.CLICK,       clickHandler);
            this._resource.addEventListener(MouseEvent.MOUSE_OVER,  overHandler);
            this._resource.addEventListener(MouseEvent.MOUSE_OUT,   outHandler);
            this._resource.addEventListener(MouseEvent.MOUSE_MOVE,  moveHandler);
            this._resource.addEventListener(MouseEvent.MOUSE_DOWN,  downHandler);
            this._resource.addEventListener(MouseEvent.MOUSE_UP,    upHandler);
        }
        
        public function get resource():DisplayObject {
            return _resource;
        }
        
        //========================= Event Handlers ===========================//
        
        private var customClicHandler:Function;
        public function registerCustomClickHandler(func:Function):void { customClicHandler = func; }
        private function clickHandler(event:MouseEvent):void {
            if(customClicHandler != null){
                customClicHandler(event);
            }
        }
        
        private var customOutHandler:Function;
        public function registerCustomOutHandler(func:Function):void { customOutHandler = func; }
        private function outHandler(event:MouseEvent):void {
            if(customOutHandler != null){
                customOutHandler(event);
            }
        }
        
        private var customOverHandler:Function;
        public function registerCustomOverHandler(func:Function):void { customOverHandler = func; }
        private function overHandler(event:MouseEvent):void {
            if(customOverHandler != null){
                customOverHandler(event);
            }
        }
        
        private var customMoveHandler:Function;
        public function registerCustomMoveHandler(func:Function):void { customMoveHandler = func; }
        private function moveHandler(event:MouseEvent):void {
            if(customMoveHandler != null){
                customMoveHandler(event);
            }
        }
        
        private var customDownHandler:Function;
        public function registerCustomDownHandler(func:Function):void { customDownHandler = func; }
        private function downHandler(event:MouseEvent):void {
            if(customDownHandler != null){
                customDownHandler(event);
            }
        }
        
        private var customUpHandler:Function;
        public function registerCustomUpHandler(func:Function):void { customUpHandler = func; }
        private function upHandler(event:MouseEvent):void {
            // override
            if(customUpHandler != null){
                customUpHandler(event);
            }
        }
        //======================EOF Event Handlers ===========================//
        
        public static function createTextField(rect:Rectangle):TextField {
            var textField:TextField = new TextField();
            textField.x         = rect.x;
            textField.y         = rect.y;
            textField.width     = rect.width;
            textField.height    = rect.height;
            
            textField.background = true;
            textField.backgroundColor = 0xFFFFFF;
            textField.type      = TextFieldType.INPUT;
            
            return textField;
        }
    }
}