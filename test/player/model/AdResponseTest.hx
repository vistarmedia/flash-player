package player.model;

import haxe.rtti.Infos;
import haxe.unit.TestCase;

class AdResponseTest extends TestCase, implements Infos {

  public function testSimpleParse() {
    var json = '{
      "advertisement": [
        {
          "lease_id":         "some-lease-id",
          "lease_expiry":     1234567890,
          "display_area_id":  "some-display-area",
          "asset_id":         "some-asset",
          "asset_url":        "http://foo.com/bar.jpg",
          "width":            800,
          "height":           600,
          "mime_type":        "image/flv",
          "length_in_seconds":200
        }
      ]
    }';
    
    var adResponse = AdResponse.fromJson(json);
    assertEquals(1, adResponse.advertisements.length);
    var ad = adResponse.advertisements.first();
    assertEquals("http://foo.com/bar.jpg", ad.assetUrl);
  }
}
