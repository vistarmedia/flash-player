package player.module;

import flash.Lib;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.external.ExternalInterface;
import unject.UnjectModule;

import player.assetbank.AssetBank;
import player.controller.ApiController;
import player.controller.Player;
import player.model.Api;
import player.model.Credentials;
import player.model.Device;
import player.model.DisplayArea;
import player.model.PlayQueue;
import player.transport.HttpTransport;
import player.transport.Transport;


class PlayerModule extends UnjectModule {
  private var supportedMedia: Array<String>;

  private var loaderParams: Dynamic;

  public function new(loaderParams: Dynamic) {
    super();

    supportedMedia = new Array<String>();
    supportedMedia.push("image/jpeg");
    supportedMedia.push("image/gif");
    supportedMedia.push("image/png");
    supportedMedia.push("video/x-flv;vp6f");

    this.loaderParams = loaderParams;
  }

	public override function load() {
    super.load();

    var stage = Lib.current.stage;
    stage.align = StageAlign.TOP_LEFT;
    stage.scaleMode = StageScaleMode.NO_SCALE;

    var networkId: String = null;
    var apiKey: String = null;
    var deviceId: String = null;
    var allowAudio = true;
    var displayAttributes = new Hash<String>();

    displayAttributes.set("build", getBuildNumber());

    var fields = Reflect.fields(this.loaderParams);
    for(field in fields) {
      var value = Reflect.field(this.loaderParams, field);
      switch(field) {
        case "network_id":
          networkId = value;

        case "api_key":
          apiKey = value;

        case "device_id":
          deviceId = value;

        case "allow_audio":
          allowAudio = false;

        default:
          displayAttributes.set(field, value);
      }
    }

    var width       = getRealWidth();
    var height      = getRealHeight();

    var demoMode = false;

    var offsetX = if(loaderParams.offset_x == null) 0
                  else Std.parseInt(loaderParams.offset_x);

    var offsetY = if(loaderParams.offset_y == null) 0
                  else Std.parseInt(loaderParams.offset_y);

    bind(Api).toSelf().withParameter("host", loaderParams.host);
    bind(Transport).to(HttpTransport).inSingletonScope();
    bind(ApiController).toSelf().inSingletonScope();
    bind(AssetBank).toSelf().inSingletonScope();
    bind(PlayQueue).toSelf().inSingletonScope();
    bind(Player).toSelf().inSingletonScope();

    bind(Credentials).toSelf()
      .withParameter("networkId", networkId)
      .withParameter("apiKey",    apiKey)
      .withParameter("demoMode",  demoMode)
      .inSingletonScope();

    bind(Device).toSelf()
      .withParameter("deviceId",    deviceId)
      .withParameter("attributes",  displayAttributes)
      .inSingletonScope();

    bind(DisplayArea).toSelf()
      .withParameter("width",          getRealWidth())
      .withParameter("height",         getRealHeight())
      .withParameter("id",             deviceId)
      .withParameter("allowAudio",     allowAudio)
      .withParameter("supportedMedia", supportedMedia)
      .withParameter("offsetX",        offsetX)
      .withParameter("offsetY",        offsetY)
      .inSingletonScope();
  }

  private function getRealWidth(): Int {
    return Std.int(Lib.current.stage.stageWidth);
  }

  private function getRealHeight(): Int {
    return Std.int(Lib.current.stage.stageHeight);
  }

  private function getBuildNumber(): String {
    return StringTools.trim(haxe.Resource.getString("build"));
  }
}
