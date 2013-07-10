package player.assetbank;

import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;


class ImageMedia implements Media {
  private var url: String;
  private var loader: Loader;
  private var loaded: Bool;
  private var hasResized: Bool;

  public function new(url: String) {
    this.url    = url;
    this.loader = new Loader();
    this.loaded = false;
    this.hasResized = false;

    loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
    loader.load(new URLRequest(url));
  }

  public function resizeTo(width: Int, height: Int) {
    if(hasResized) {
      return;
    }

    var scaleX = width / loader.width;
    var scaleY = height / loader.height;
    var scale = if(scaleX > scaleY) scaleY else scaleX;
    loader.width  *= scale;
    loader.height *= scale;
  }

  public function isLoaded() {
    return loaded;
  }

  private function loadComplete(e: Event) {
    this.loaded = true;
  }

  public function getDisplay(): DisplayObject {
    return loader;
  }

  public function play() {}
  public function stop() {}
  public function rewind() {}
}
