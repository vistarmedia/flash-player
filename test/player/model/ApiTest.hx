package player.model;

import haxe.rtti.Infos;
import haxe.unit.TestCase;

import player.transport.MemoryTransport;


class ApiTest extends TestCase, implements Infos {
  private var api: Api;
  private var transport: MemoryTransport;

  override public function setup() {
    transport = new MemoryTransport();
    api = new Api(transport, "testhost");
  }

  public function testEmptyAdRespons() {
    var media = ["image/jpeg", "image/gif", "video/mp4"];
    var displayArea = new DisplayArea("id", 800, 600, true, media);

    var deviceAttributes = new Hash<String>();
    deviceAttributes.set("name", "frank");
    deviceAttributes.set("friends", "bob");

    var displayTime = Date.now();

    var adRequest = new AdRequest("my-network-id", "my-api-key", "my-device-id",
      displayTime, deviceAttributes, displayArea);

    transport.setResponse(200, "{\"advertisement\":[]}");
    var self = this;
    api.getAd(adRequest, function(adResponse: AdResponse) {
      self.assertTrue(true);
    });
  }
}
