package
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    public class Resource extends EventDispatcher
    {
        private static var _instance:Resource;
        public static function get instance():Resource{
            if(_instance == null){ _instance = new Resource(); }
            return _instance;
        }
        private var image:Bitmap;
        public function loadImage(url:String):void{
            var imgLoader:LocalImageLoader = new LocalImageLoader(url);
            imgLoader.addEventListener(Event.COMPLETE, onImageLoaded);
        }
        
        private function onImageLoaded(event:Event):void {
            image = (event.target as LocalImageLoader).image;
            dispatchEvent(new Event(Event.COMPLETE));
        }
        
        public function getImageCopy():Bitmap{
            var imageRect:Rectangle = image.getRect(image);
            var bmd:BitmapData = new BitmapData(imageRect.width, imageRect.height, false, 0xFFFFFF);
            bmd.copyPixels(image.bitmapData, imageRect, new Point());
            return new Bitmap(bmd);
        }
    }
}
import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.ByteArray;

class LocalImageLoader extends EventDispatcher{
    private var _url:String;
    private var _loader:Loader;
    public var image:Bitmap;
    public function LocalImageLoader(url:String) {
        _loader = new Loader();
        _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
        _loader.load(new URLRequest(url));
    }
    
    private function onComplete(event:Event):void {
        image = _loader.content as Bitmap;
        dispatchEvent(new Event(Event.COMPLETE));
    }
}