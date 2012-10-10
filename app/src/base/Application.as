package base
{
    import controls.BaseControll;
    import controls.LableButton;
    import controls.Scroller;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    
    import utils.Helper;

    public class Application extends Sprite
    {
        private static const IMAGE_URL:String = "jad.png";
        
        private var _scroller:Scroller;
        private var textInput:TextField;
        
        public function Application() {
            Resource.instance.addEventListener(Event.COMPLETE, onResuorcesLoaded);
            Resource.instance.loadImage(IMAGE_URL);;
        }
        
        public function onResuorcesLoaded(event:Event):void {
            Resource.instance.removeEventListener(Event.COMPLETE, onResuorcesLoaded);
            
            var buildBtn:LableButton;
            this.addChild( (_scroller = new Scroller(400, 400)).container );
            this.addChild( textInput = BaseControll.createTextField( new Rectangle(150,452, 50, 20)) );
            
            this.addChild( (buildBtn = LableButton.createLableButton(new Point(210,450), "Построить")).resource );
            
            buildBtn.registerCustomClickHandler(buildScroller);
        }
        
        private function buildScroller(event:MouseEvent):void{
            var itemsCount:int = parseInt( textInput.text );
            _scroller.clear();
            for (var i:int = 0; i < itemsCount; i++) {
                _scroller.add( Resource.instance.getImageCopy() );
            }
        }
    }
}