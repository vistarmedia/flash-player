package player.transport;

import haxe.rtti.Infos;
import haxe.unit.TestCase;


class TransportTest extends TestCase, implements Infos {

  private var transport: Transport;

  public function new() {
    super();
    this.transport = new MemoryTransport();
  }

  public function testBasicRequest() {
    var self = this;
    transport.get("say_ok", function(response: Response) {
      self.assertEquals(200, response.status);
      self.assertEquals("OK", response.body);
    });
  }
}
