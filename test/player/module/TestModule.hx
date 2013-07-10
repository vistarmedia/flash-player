package player.module;

import flash.Lib;

import player.model.Api;
import player.transport.MemoryTransport;
import player.transport.Transport;


class TestModule extends PlayerModule {

  public function new(?params: Dynamic) {
    if(params == null) {
      params = new flash.display.MovieClip();
      params.network_id = "testing-network_id";
      params.api_key    = "testing-api_key";
      params.device_id  = "testing-device_id";
    }

    super(params);
  }

	public override function load() {
    super.load();

    bind(Api).toSelf().withParameter("host", "test.com");
    bind(Transport).to(MemoryTransport).inSingletonScope();
  }
}
