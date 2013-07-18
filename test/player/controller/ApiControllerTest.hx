package player.controller;

import flash.Lib;
import haxe.unit.TestCase;
import hxjson2.JSON;
import unject.StandardKernel;

import player.model.Advertisement;
import player.module.TestModule;
import player.transport.MemoryTransport;
import player.transport.Transport;


class ApiControllerTest extends TestCase {

  public function testBasicUsage() {
    var self = this;
    var kernel = new StandardKernel([new TestModule()]);
    var controller = kernel.get(ApiController);
    var transport  = cast(kernel.get(Transport), MemoryTransport);

    transport.setResponse(200, '{
      "advertisement": [{
        "id":           "test-lease-id"
      }]
    }');

    controller.getAds(function(ad: Advertisement) {
      self.assertEquals("test-lease-id", ad.id);
    });
  }

  public function testSendDeviceSize() {
    var params = Lib.current.loaderInfo.parameters;
    var kernel = new StandardKernel([new TestModule(params)]);
    var controller = kernel.get(ApiController);
    var transport  = cast(kernel.get(Transport), MemoryTransport);

    transport.setResponse(200, '{
      "advertisement": [{
        "id":           "test-lease-id"
      }]
    }');

    controller.getAds(function(ad: Advertisement) {
    });

    this.assertEquals("http://test.com/api/v1/get_ad/json", transport.lastPostUrl);

    var req = JSON.decode(transport.lastPostBody);
    var displayArea = req.display_area;
    var attrs: Array<Dynamic> = req.device_attribute;

    this.assertEquals("flashvar-network_id",  req.network_id);
    this.assertEquals("flashvar-api_key",     req.api_key);
    this.assertEquals("flashvar-device_id",   req.device_id);
    this.assertTrue(req.direct_connection);

    this.assertTrue(displayArea != null);
    this.assertTrue(displayArea.allow_audio);
    this.assertEquals("flashvar-device_id", displayArea.id);
    this.assertEquals(500, displayArea.width);
    this.assertEquals(501, displayArea.height);

    var mediaTypes: Array<String> = displayArea.supported_media;
    this.assertEquals(5, mediaTypes.length);

    this.assertEquals(3, attrs.length);
    var attrMap = new Hash<String>();
    for(i in attrs) {
      attrMap.set(i.name, i.value);
    }
    this.assertEquals("123", attrMap.get("build"));
    this.assertEquals("one", attrMap.get("extraParam1"));
    this.assertEquals("two", attrMap.get("extraParam2"));
    this.assertEquals(null, attrMap.get("extraParam3"));

  }
}
