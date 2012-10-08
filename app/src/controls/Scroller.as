package controls
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    
    import utils.Helper;
    
    public class Scroller
    {
        private var _width   :int;
        private var _height:int;
        
        private var _container:Sprite;
        
        public function Scroller(width:int, height:int) {
            this._width = width;
            this._height = height;
            
            this._container = new Sprite();
            create();
        }
        
        private var _containerBg    :Shape;
        private var _slider         :Slider;
        private var _contentHolder  :Sprite;
        
        private function create():void {
            _container.addChild( _containerBg = Helper.getShape(_width, _height, 0xccccbb) );
            addHolder();
            _container.addChild( _slider = new Slider(_height, _contentHolder));
            _slider.x = _width-_slider.width;
        }
        
        private function addHolder():void {
            var mask:Shape = Helper.getShape(_width, _height, 0xccccbb);
            _container.addChild( _contentHolder = new Sprite() );
            _container.mask = mask;
        }
        
        private var contentList:Vector.<DisplayObject> = new Vector.<DisplayObject>;
        private static const GAP:int = 10;
        
        public function add(item:DisplayObject):void {
            contentList.push(item);
            update();
        }
        
        public function clear():void{
            contentList.splice(0, contentList.length);
            update();
        }
        
        private function update():void {
            _contentHolder.removeChildren();
            for (var i:int = 0; i < contentList.length; i++) 
            {
                contentList[i].y = contentList[i].height*i + GAP*i;
                _contentHolder.addChild( contentList[i] );
            }
            _slider.update();
        }
        
        public function get container():DisplayObjectContainer{ return _container; }
    }
}
import controls.ClickableButton;

import flash.display.Sprite;
import flash.geom.Rectangle;

class Slider extends Sprite{
    private var _btnUp       :ClickableButton;
    private var _btnDown     :ClickableButton;
    private var _slider      :ClickableButton;
    private var _sliderTrack:ClickableButton;
    
    private var target:Sprite;
    
    private const WIDTH:int = 10;
    
    public function Slider(_height:int, target:Sprite) {
        this.target = target;
        addChild( (_btnUp= ClickableButton.createSimpleControll(new Rectangle(0,0,WIDTH, WIDTH))).resource );
        addChild( (_btnDown = ClickableButton.createSimpleControll(new Rectangle(0,_height-WIDTH,WIDTH,WIDTH))).resource );
        addChild( (_slider = ClickableButton.createSimpleControll(new Rectangle(0,WIDTH,WIDTH,_height-(WIDTH<<1)))).resource );
        addChild( (_sliderTrack = ClickableButton.createSimpleControll(new Rectangle(0,0,WIDTH,WIDTH))).resource );
        update();
    }
    
    public function update():void {
        this.visible = (this.target.height > this.height);
    }
}