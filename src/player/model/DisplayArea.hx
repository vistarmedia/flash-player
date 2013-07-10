package player.model;

import haxe.rtti.Infos;

import hxjson2.JSON;


class DisplayArea implements Infos {
  private var id: String;
  public var width: Int;
  public var height: Int;
  private var allowAudio: Bool;
  private var supportedMedia: Array<String>;
  private var offsetX: Int;
  private var offsetY: Int;

  public function new(id: String, width: Int, height: Int, allowAudio: Bool,
                      supportedMedia: Array<String>,
                      ?offsetX: Int = 0, ?offsetY: Int = 0) {
    this.id             = id;
    this.width          = width;
    this.height         = height;
    this.allowAudio     = allowAudio;
    this.supportedMedia = supportedMedia;
    this.offsetX        = offsetX;
    this.offsetY        = offsetY;
  }

  public function toSimple(): Hash<Dynamic> {
    var simple = new Hash<Dynamic>();

    simple.set("id",              this.id);
    simple.set("width",           this.width);
    simple.set("height",          this.height);
    simple.set("allow_audio",     this.allowAudio);
    simple.set("supported_media", this.supportedMedia);
    simple.set("offset_x",        this.offsetX);
    simple.set("offset_y",        this.offsetY);

    return simple;
  }

  public function toJson() {
    return JSON.encode(toSimple());
  }
}
