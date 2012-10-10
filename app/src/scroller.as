package
{
    import base.Application;
    
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
        private var app:Application;
        public function scroller()
        {
            app = new Application()
            stage.addChild( app );
        }
    }
}