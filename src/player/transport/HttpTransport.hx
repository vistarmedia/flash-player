package player.transport;

import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import haxe.rtti.Infos;

class HttpTransport implements Transport, implements Infos {

  public function new() {
  }

  public function get(url: String, handler: Response->Void) {
    var request = new URLRequest(url);
    request.method = "GET";
    send(request, handler);
  }

  public function post(url: String, body: String, handler: Response->Void) {
    var request = new URLRequest(url);
    request.contentType = "application/json";
    request.data   = body;
    request.method = "POST";
    send(request, handler);
  }

  private function send(request: URLRequest, handler: Response -> Void) {
    var loader = new URLLoader();

    loader.addEventListener(Event.COMPLETE, function(e: Event) {
      handler(new Response(200, loader.data));
    });

    loader.load(request);
  }
}
