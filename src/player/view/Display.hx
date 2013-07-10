package player.view;

import flash.Lib;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.NetStatusEvent;
import flash.events.SecurityErrorEvent;
import flash.media.Video;
import flash.net.NetConnection;
import flash.text.TextField;
import flash.text.TextFormat;
import haxe.rtti.Infos;
import player.assetbank.AssetBank;

import player.model.PlayQueue;
import player.model.Advertisement;
import player.model.Credentials;


class Display implements Infos {
  private var playQueue: PlayQueue;
  private var assetBank: AssetBank;
  private var stage: Stage;
  private var root: MovieClip;
  private var movieClip: MovieClip;

  public function new(playQueue: PlayQueue, assetBank: AssetBank,
                      credentials: Credentials) {
    this.playQueue = playQueue;
    this.assetBank = assetBank;

    stage = Lib.current.stage;
    root = Lib.current;
    movieClip = new MovieClip();

    root.addChild(movieClip);
    if(credentials.isDemoMode()) {
      handleDemoMode();
    }
  }

  public function showNextAd() {
    var ad = playQueue.pop();
    if(ad == null) {
      handleNoAd();
    } else {
      handleAd(ad);
    }
  }

  private function handleAd(ad: Advertisement) {
    var duration = ad.getDuration();
    var media    = assetBank.get(ad.assetUrl);
    var display  = media.getDisplay();
    var self     = this;
    var start    = Date.now().getTime();

    var finish = function() {
      ad.complete();
      self.movieClip.removeChild(display);
      media.rewind();
      media.stop();
      self.showNextAd();
    }

    var width = stage.stageWidth;
    var height = stage.stageHeight;

    media.resizeTo(width, height);

    display.x = (width - display.width) / 2;
    display.y = (height - display.height) / 2;

    movieClip.addChild(display);
    media.play();
    var timeout = duration * 1000;
    haxe.Timer.delay(finish, timeout - 1000);
  }

  private function handleNoAd() {
    haxe.Timer.delay(showNextAd, 500);
  }

  private function handleDemoMode() {
    var fmt = new TextFormat();
    fmt.size = 30;
    fmt.bold = true;
    fmt.font = "Arial";

    var text = new TextField();
    text.text = "VISTAR MEDIA DEMO\nhttp://dev.vistarmedia.com/client_api/flash";
    text.textColor = 0xff3333;
    text.setTextFormat(fmt);
    text.width = 1000;
    root.addChild(text);
  }
}
