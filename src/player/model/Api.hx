package player.model;

import haxe.rtti.Infos;

import player.transport.Transport;
import player.transport.Response;


class Api implements Infos {
  private var transport: Transport;
  private var host: String;

  public function new(transport: Transport, host: String) {
    this.transport = transport;
    this.host = host;
  }

  public function getAd(adRequest: AdRequest, responseHandler: AdResponse->Void) {
    var url = "http://"+ host +"/api/v1/get_ad/json";
    transport.post(url, adRequest.toJson(), function(resp: Response) {
      if(resp.status == 200) {
        var adResponse = AdResponse.fromJson(resp.body);
        responseHandler(adResponse);
      }
    });
  }

  public function sendPop(ad: Advertisement, responseHandler: Void->Void) {
    transport.get(ad.proofOfPlayUrl, function(resp: Response) {
      if(resp.status == 200 || resp.status == 204) {
        responseHandler();
      }
    });
  }
}
