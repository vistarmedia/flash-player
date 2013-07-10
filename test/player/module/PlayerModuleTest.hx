package player.module;

import haxe.unit.TestCase;
import flash.Lib;
import unject.StandardKernel;

import player.model.Credentials;
import player.model.Device;
import player.model.DisplayArea;


class PlayerModuleTest extends TestCase {

  /**
   * The default FlashVars as defined in the "embed" tag of test.html.  The
   * default case won't try to set them up in the code. */
  public function testLoaderParams() {
    var flashParams = Lib.current.loaderInfo.parameters;
    var kernel = new StandardKernel([new PlayerModule(flashParams)]);
    var credentials = kernel.get(Credentials);

    this.assertEquals("flashvar-network_id", credentials.getNetworkId());
    this.assertEquals("flashvar-api_key",    credentials.getApiKey());
    this.assertFalse(credentials.isDemoMode());
  }

  public function testDeviceId() {
    var flashParams = Lib.current.loaderInfo.parameters;
    var kernel = new StandardKernel([new PlayerModule(flashParams)]);
    var device = kernel.get(Device);

    this.assertEquals("flashvar-device_id", device.getDeviceId());
  }

  public function testProvidedParameters() {
    var params = getFakeParams();
    var kernel = new StandardKernel([new PlayerModule(params)]);
    var credentials = kernel.get(Credentials);

    this.assertEquals("testing-network_id", credentials.getNetworkId());
    this.assertEquals("testing-api_key",    credentials.getApiKey());
    this.assertFalse(credentials.isDemoMode());
  }

  public function testMissingNetworkId() {
    var params = getFakeParams();
    params.network_id = null;

    var kernel = new StandardKernel([new PlayerModule(params)]);
    var credentials = kernel.get(Credentials);

    this.assertTrue(credentials.isDemoMode());
  }

  private function testDiplayAreaHasDeviceId() {
    var flashParams = Lib.current.loaderInfo.parameters;
    var kernel = new StandardKernel([new PlayerModule(flashParams)]);
    var displayArea = kernel.get(DisplayArea).toSimple();

    this.assertEquals("flashvar-device_id", displayArea.get("id"));
  }

  private function getFakeParams(): Dynamic {
    var params: Dynamic = new flash.display.MovieClip();
    params.network_id = "testing-network_id";
    params.api_key    = "testing-api_key";
    params.device_id  = "testing-device_id";
    return params;
  }
}
