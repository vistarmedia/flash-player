package player.model;

import hxjson2.JSON;


class AdResponse {
  public var advertisements: List<Advertisement>;

  public function new(advertisements: List<Advertisement>) {
    this.advertisements = advertisements;
  }

  public static function fromJson(json: String): AdResponse {
    var advertisements = new List<Advertisement>();
    var adResponse = JSON.parse(json);
    if(adResponse.advertisement != null) {
      var adObjects = cast(adResponse.advertisement, Array<Dynamic>);
      for(ad in adObjects) {
        advertisements.add(Advertisement.fromObject(ad));
      }
    }
    return new AdResponse(advertisements);
  }
}
