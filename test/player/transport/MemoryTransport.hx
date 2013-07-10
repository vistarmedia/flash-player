package player.transport;

import haxe.rtti.Infos;

class MemoryTransport implements Transport, implements Infos {
  private var nextStatus: Int;
  private var nextBody: String;

  public var lastPostUrl: String;
  public var lastPostBody: String;

  public function new() {
    nextStatus = 200;
    nextBody   = "OK";

    lastPostUrl = "";
    lastPostBody = "";
  }

  public function get(url: String, handler: Response->Void) {
    handler(new Response(nextStatus, nextBody));
  }

  public function post(url: String, body: String, handler: Response->Void) {
    lastPostUrl = url;
    lastPostBody = body;

    handler(new Response(nextStatus, nextBody));
  }

  public function setResponse(status: Int, body: String) {
    nextStatus = status;
    nextBody   = body;
  }
}
