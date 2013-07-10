package player.model;

import haxe.rtti.Infos;
import haxe.unit.TestCase;

class AdvertisementTest extends TestCase, implements Infos {

  public function testSimpleParse() {
    var json = '
      {
        "id":                 "some-lease-id",
        "proof_of_play_url":  "http://somehost.com?foo",
        "lease_expiry":       1234567890,
        "display_area_id":    "some-display-area",
        "asset_id":           "some-asset",
        "asset_url":          "http://foo.com/bar.jpg",
        "width":              800,
        "height":             600,
        "mime_type":          "image/flv",
        "length_in_seconds":  200
      }
    ';

    var advertisement = Advertisement.fromJson(json);
    assertEquals("some-lease-id",           advertisement.id);
    assertEquals("http://somehost.com?foo", advertisement.proofOfPlayUrl);
    assertEquals(1234567890000.0,           advertisement.leaseExpiry.getTime());
    assertEquals("some-display-area",       advertisement.displayAreaId);
    assertEquals("some-asset",              advertisement.assetId);
    assertEquals("http://foo.com/bar.jpg",  advertisement.assetUrl);
    assertEquals(800,                       advertisement.width);
    assertEquals(600,                       advertisement.height);
    assertEquals("image/flv",               advertisement.mimeType);
    assertEquals(200,                       advertisement.lengthInSeconds);
  }

}
