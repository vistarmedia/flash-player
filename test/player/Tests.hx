package player;

import flash.external.ExternalInterface;
import haxe.unit.TestRunner;
import unject.StandardKernel;

import player.module.TestModule;


/**
 * To get this to work on your local machine, visit the following URL, and out
 * the `out` directory to the trusted path:
 * http://www.macromedia.com/support/documentation/en/flashplayer/help/settings_manager04.html
 */
class Tests {
  public static function main() {
    TestRunner.print = function(v: Dynamic) {
      ExternalInterface.call("log", v);
    }
    
    var runner = new TestRunner();

    runner.add(new player.assetbank.AssetBankTest());
    runner.add(new player.controller.ApiControllerTest());
    runner.add(new player.model.AdRequestTest());
    runner.add(new player.model.AdResponseTest());
    runner.add(new player.model.AdvertisementTest());
    runner.add(new player.model.ApiTest());
    runner.add(new player.model.DeviceTest());
    runner.add(new player.model.DisplayAreaTest());
    runner.add(new player.module.PlayerModuleTest());
    runner.add(new player.transport.TransportTest());

    if(runner.run()) {
      ExternalInterface.call("onSuccess");
    } else {
      ExternalInterface.call("onFailure");
    }
  } 
}
