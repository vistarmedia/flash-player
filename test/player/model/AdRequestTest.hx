package player.model;

import haxe.rtti.Infos;
import haxe.unit.TestCase;
import hxjson2.JSON;


class AdRequestTest extends TestCase, implements Infos {

  public function testBasicSerialization() {
    var media = ["image/jpeg", "image/gif", "video/mp4"];
    var displayArea = new DisplayArea("id", 800, 600, true, media);

    var deviceAttributes = new Hash<String>();
    deviceAttributes.set("name", "frank");
    deviceAttributes.set("friends", "bob");

    var displayTime = Date.now();
    var numberOfScreens = 1;

    var adRequest = new AdRequest("my-network-id", "my-api-key", "my-device-id",
      displayTime, numberOfScreens, deviceAttributes, displayArea);

    var json = adRequest.toJson();
    assertTrue(json.indexOf("network_id") > -1);
    assertTrue(json.indexOf("direct_connection") > 1);
    assertTrue(json.indexOf("my-network-id") > 1);
    assertTrue(json.indexOf("my-api-key") > 1);
  }

}
