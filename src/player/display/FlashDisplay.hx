package player.display;

import haxe.rtti.Infos;

import flash.display.Stage;
import flash.display.MovieClip;
import flash.media.Video;
import flash.events.Event;
import flash.Lib;

class FlashDisplay extends Display, implements Infos {

  private var stage: Stage;
  private var movieClip: MovieClip;

  public function new() {
    stage = Lib.current.stage;
    movieClip = Lib.current;
  }

  override public function playUrl(url: String) {
    movieClip.addChild(new VideoSprite(url));
  }

}

import flash.display.Sprite;
import flash.net.NetConnection;
import flash.net.NetStream;
import flash.events.NetStatusEvent;
import flash.events.SecurityErrorEvent;
import flash.events.AsyncErrorEvent;

class VideoSprite extends Sprite {
  private var url: String;
  private var connection: NetConnection;
  private var stream: NetStream;

  public function new(url: String) {
    super();
    this.url = url;
    connection = new NetConnection();
    connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
    connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
    connection.connect(null);
  }

  private function netStatusHandler(event: NetStatusEvent) {
    switch (event.info.code) {
      case "NetConnection.Connect.Success":
        connectStream();
    }
  }

  private function connectStream() {
    stream = new NetStream(connection);
    stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
    stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);

    var video:Video = new Video();
    video.attachNetStream(stream);
    stream.play(url);
    addChild(video);
  }

  private function asyncErrorHandler(event:AsyncErrorEvent) {
    // ignore AsyncErrorEvent events.
  }
}
