package
{
    import controls.BaseControll;
    import controls.LableButton;
    import controls.Scroller;
    
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    
    import utils.Helper;
    
    [SWF (width="400", height="500", backgroundColor="0xBCBCBC")]
    
    public class scroller extends Sprite
    {
        private var _scroller:Scroller;
        private var textInput:TextField;
        
        public function scroller()
        {
            var buildBtn:LableButton;
            
            stage.addChild( (_scroller = new Scroller(400, 400)).container );
            stage.addChild( textInput = BaseControll.createTextField( new Rectangle(150,452, 50, 20)) );
            
            stage.addChild( (buildBtn = LableButton.createLableButton(new Point(210,450), "Построить")).resource );
            
            buildBtn.registerCustomClickHandler(buildScroller);
        }
        
        private function buildScroller(event:MouseEvent):void{
            var itemsCount:int = parseInt( textInput.text );
            _scroller.clear();
            for (var i:int = 0; i < itemsCount; i++) {
                _scroller.add( Helper.getShape(150, 150, 0) );
            }
            
        }
    }
}