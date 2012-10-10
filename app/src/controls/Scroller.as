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
        private var _width          :int;
        private var _height         :int;
        
        private var _container      :Sprite;
        private var _containerBg    :Shape;
        private var _slider         :VSlider;
        private var _contentHolder  :Sprite;
        
        private var contentList     :Vector.<DisplayObject> = new Vector.<DisplayObject>;
        private static const GAP    :int = 10;
        
        private var arranger:Arranger;
        
        public function Scroller(width:int, height:int) {
            this._width = width;
            this._height = height;
            this._container = new Sprite();
            create();
        }
        
        
        private function create():void {
            _container.addChild( _containerBg = Helper.getShape(_width, _height, 0xccccbb) );
            addHolder();
            _container.addChild( _slider = new VSlider(_height, _contentHolder));
            _slider.x = _width-_slider.width;
            arranger = new Arranger();
        }
        
        private function addHolder():void {
            var mask:Shape = Helper.getShape(_width, _height, 0xccccbb);
            _container.addChild( _contentHolder = new Sprite() );
            _container.mask = mask;
        }
        
        
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
            arranger.arrange(contentList, GAP);
            for (var i:int = 0; i < contentList.length; i++) {
                _contentHolder.addChild( contentList[i] );
            }
            _slider.update();
        }
        
        public function get container():DisplayObjectContainer{ return _container; }
    }
}
import controls.BaseControll;
import controls.ClickableButton;

import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

import utils.Helper;

class VSlider extends Sprite{
    private var _btnUp       :ClickableButton;
    private var _btnDown     :ClickableButton;
    private var _slider      :ClickableButton;
    private var _sliderTrack :ClickableButton;
    
    private var target:Sprite;
    private var _height:int;
    
    private const WIDTH:int = 20;
    private const BTN_CLICK_OFFSET:int = 10;
    private const SLIDER_CLICK_OFFSET:int = 110;
    
    public function VSlider(_height:int, target:Sprite) {
        this.target = target;
        this._height = _height;
        addChild( (_sliderTrack = ClickableButton.createSimpleControll(new Rectangle(0,WIDTH,WIDTH,_height-(WIDTH<<1)), Helper.DARK)).resource );
        addChild( (_btnUp       = ClickableButton.createSimpleControll(new Rectangle(0,0,WIDTH, WIDTH), Helper.GREY)).resource );
        addChild( (_btnDown     = ClickableButton.createSimpleControll(new Rectangle(0,_height-WIDTH,WIDTH,WIDTH), Helper.GREY)).resource );
        addChild( (_slider      = ClickableButton.createSimpleControll(new Rectangle(0,WIDTH,WIDTH,_height-(WIDTH<<1)), Helper.GREY)).resource );
        configControlls();
        update();
    }
    
    private var offsetCoeff:Number;
    
    public function update():void {
        this.visible = (this.target.height > this.height);
        resetSlidetSize();
        offsetCoeff = (target.height-_height) / (_height - (WIDTH<<1) - _slider.resource.height);
        _slider.resource.y = WIDTH;
        target.y = 0;
        
    }
    
    private function resetSlidetSize():void{
        var xxx:int = (target.height/_sliderTrack.resource.height)*100;
        if(xxx<=100){
            _slider.resource.scaleY =1;
        }else if(xxx >= 500){
            _slider.resource.scaleY = 0.02;
        } else {
            _slider.resource.scaleY = 1 - (xxx/500);
        }
    }
    
    private function configControlls():void {
        _slider.registerCustomDownHandler(onSliderDown);
        _slider.registerCustomUpHandler(onSliderUp);
        _btnDown.registerCustomClickHandler(onBtnDownClick);
        _btnUp.registerCustomClickHandler(onBtnUpClick);
        _sliderTrack.registerCustomClickHandler(onSliderTrackClick);
        this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    }
    
    private function onSliderTrackClick(event:MouseEvent):void {
        if(event.localY < _slider.resource.y)
            moveSliderAndContentTo( ((target.y+SLIDER_CLICK_OFFSET)/offsetCoeff)+WIDTH );
        else
            moveSliderAndContentTo( ((target.y-SLIDER_CLICK_OFFSET)/offsetCoeff)+WIDTH );
    }
    private function onBtnUpClick(event:MouseEvent):void {
        moveSliderAndContentTo(_slider.resource.y - BTN_CLICK_OFFSET);
    }
    private function onBtnDownClick(event:MouseEvent):void {
        moveSliderAndContentTo(_slider.resource.y + BTN_CLICK_OFFSET);
    }
    
    private function onMouseMove(event:MouseEvent):void {
        if(!drug) return;
        var localPoint:Point = this.globalToLocal( new Point(event.stageX, event.stageY));
        var neSliderPos:Number = localPoint.y - mouseOffsetY;
        moveSliderAndContentTo(neSliderPos);
    }
    
    private function moveSliderAndContentTo(dest:Number):void {
        if(dest <= sliderMinY){
            _slider.resource.y = sliderMinY;
            _btnUp.enabled = false;
        } else if(dest >= sliderMaxY){
            _slider.resource.y = sliderMaxY;
            _btnDown.enabled = false;
        } else {
            _slider.resource.y = dest;
            _btnUp.enabled =
                _btnDown.enabled = true;
        }
        target.y = - (_slider.resource.y - WIDTH)* offsetCoeff;
    }
    
    private var drug:Boolean;
    private var mouseOffsetY:Number;
    private function onSliderDown(event:MouseEvent):void {
        drug = true;
        var localPoint:Point = this.globalToLocal( new Point(event.stageX, event.stageY));
        mouseOffsetY = localPoint.y - _slider.resource.y; 
    }
    private function onSliderUp(event:MouseEvent):void {
        drug = false;
        mouseOffsetY = 0;
    }
    
    private function get sliderMinY():Number {
        return WIDTH;
    }
    private function get sliderMaxY():Number {
        return _height - WIDTH - _slider.resource.height;
    }
}
class Arranger{
    public function arrange(list:Vector.<DisplayObject>, gap:int):void{
        var coll:int = 0;
        var row :int = 0;
        for (var i:int = 0; i < list.length; i++) {
            
            list[i].y = (list[i].height + gap)*row;
            list[i].x = (list[i].width + gap)*coll;
            
            if(coll++ > 0){
                coll=0;
                row++;
            }
        }
    }
}