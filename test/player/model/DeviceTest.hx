package player.model;

import flash.Lib;
import haxe.unit.TestCase;
import unject.StandardKernel;

import player.module.PlayerModule;


class DeviceTest extends TestCase {

  public function testDeviceIdFromFlashVars() {
    var flashParams = Lib.current.loaderInfo.parameters;
    var kernel = new StandardKernel([new PlayerModule(flashParams)]);
    var device = kernel.get(Device);

    this.assertEquals("flashvar-device_id", device.getDeviceId());
  }

  public function testDeviceAttributesFromFlashVars() {
    var flashParams = Lib.current.loaderInfo.parameters;
    var kernel = new StandardKernel([new PlayerModule(flashParams)]);
    var device = kernel.get(Device);

    var attrs = device.getAttributes();
    this.assertEquals("one", attrs.get("extraParam1"));
    this.assertEquals("two", attrs.get("extraParam2"));
    this.assertEquals(null, attrs.get("extraParam3"));
    this.assertEquals(null, attrs.get("network_id"));
    this.assertEquals(null, attrs.get("api_key"));
  }

  /** The build number is hard-coded in the "build" file at the root of this
    * project. */
  public function testBuildNumber() {
    var flashParams = Lib.current.loaderInfo.parameters;
    var kernel = new StandardKernel([new PlayerModule(flashParams)]);
    var device = kernel.get(Device);

    var attrs = device.getAttributes();
    this.assertEquals("123", attrs.get("build"));
  }
}
