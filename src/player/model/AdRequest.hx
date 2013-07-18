package player.model;

import hxjson2.JSON;


class AdRequest {
  private var networkId: String;
  private var apiKey: String;
  private var deviceId: String;
  private var displayTime: Date;
  private var deviceAttributes: Hash<String>;
  private var displayArea: DisplayArea;

  public function new(networkId: String, apiKey: String, deviceId: String,
                      displayTime: Date,
                      deviceAttributes: Hash<String>,
                      displayArea: DisplayArea) {
    this.networkId = networkId;
    this.apiKey = apiKey;
    this.deviceId = deviceId;
    this.displayTime = displayTime;
    this.deviceAttributes = deviceAttributes;
    this.displayArea = displayArea;
  }

  public function toSimple(): Hash<Dynamic> {
    var simple = new Hash<Dynamic>();

    var displayTime = Std.int(this.displayTime.getTime() / 1000);
    var deviceAttributes = new List<Hash<String>>();

    for(key in this.deviceAttributes.keys()) {
      var entry = new Hash<String>();
      entry.set("name", key);
      entry.set("value", this.deviceAttributes.get(key));
      deviceAttributes.add(entry);
    }

    simple.set("network_id",          networkId);
    simple.set("api_key",             apiKey);
    simple.set("device_id",           deviceId);
    simple.set("display_time",        displayTime);
    simple.set("direct_connection",   true);
    simple.set("device_attribute",    deviceAttributes);
    simple.set("display_area",        displayArea.toSimple());

    return simple;
  }

  public function toJson(): String {
    var json = JSON.encode(toSimple());
    return StringTools.replace(json, "\\/", "/");
  }
}
