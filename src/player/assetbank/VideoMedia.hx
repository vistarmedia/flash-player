package player.assetbank;

import flash.display.DisplayObject;
import flash.events.NetStatusEvent;
import flash.events.SecurityErrorEvent;
import flash.media.Video;
import flash.net.NetConnection;
import flash.net.NetStream;


class VideoMedia implements Media {
  private var url: String;
  private var video: Video;
  private var connection: NetConnection;
  private var stream: NetStream;
  private var loaded: Bool;
  private var hasResized: Bool;

  public function new(url: String) {
    this.url    = url;
    this.loaded = false;

    this.connection = new NetConnection();
    connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
    connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
    connection.connect(null);

    this.stream     = new NetStream(connection);
    stream.client   = this;
    this.video      = new Video();
    video.smoothing  = true;
    this.hasResized  = false;

    video.attachNetStream(stream);
    stream.play(url);
    stream.pause();
  }

  public function resizeTo(width: Int, height: Int) {
    if(hasResized) {
      return;
    }

    var scaleX = width / video.width;
    var scaleY = height / video.height;
    var scale = if(scaleX > scaleY) scaleY else scaleX;
    video.width  *= scale;
    video.height *= scale;
    hasResized = true;
  }

  public function isLoaded() {
    return loaded;
  }

  public function getDisplay(): DisplayObject {
    return video;
  }

  public function play() {
    stream.resume();
  }

  public function stop() {
    stream.pause();
  }

  public function rewind() {
    stream.seek(0);
  }

  private function netStatusHandler(event: NetStatusEvent) {

  }

  private function securityErrorHandler(event: SecurityErrorEvent) {
    throw event;
  }

  private function onMetaData(info: Dynamic) {
    if(!loaded) {
      video.width  = info.width;
      video.height = info.height;
    }
    loaded = true;
  }
}
