package player.model;

import hxjson2.JSON;


class Advertisement {
  public var id: String;
  public var proofOfPlayUrl: String;
  public var leaseExpiry: Date;
  public var displayAreaId: String;
  public var assetId: String;
  public var assetUrl: String;
  public var width: Int;
  public var height: Int;
  public var mimeType: String;
  public var lengthInSeconds: Int;

  public function new(id: String, proofOfPlayUrl: String, leaseExpiry: Date,
                      displayAreaId: String, assetId: String, assetUrl: String,
                      width: Int, height: Int, mimeType: String,
                      lengthInSeconds: Int) {
    this.id = id;
    this.proofOfPlayUrl = proofOfPlayUrl;
    this.leaseExpiry = leaseExpiry;
    this.displayAreaId = displayAreaId;
    this.assetId = assetId;
    this.assetUrl = assetUrl;
    this.width = width;
    this.height = height;
    this.mimeType = mimeType;
    this.lengthInSeconds = lengthInSeconds;
  }

  public dynamic function complete() { }

  public function getDuration(): Int {
    if(lengthInSeconds < 1) {
      return 5;
    } else {
      return lengthInSeconds;
    }
  }

  public static function fromObject(object: Dynamic): Advertisement {
    return new Advertisement(
      object.id,
      object.proof_of_play_url,
      Date.fromTime(object.lease_expiry * 1000),
      object.display_area_id,
      object.asset_id,
      object.asset_url,
      object.width,
      object.height,
      object.mime_type,
      object.length_in_seconds);
  }

  public static function fromJson(json: String): Advertisement {
    return fromObject(JSON.parse(json));
  }
}
