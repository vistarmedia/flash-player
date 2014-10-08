package player.controller;

import haxe.rtti.Infos;

import player.model.AdRequest;
import player.model.AdResponse;
import player.model.Advertisement;
import player.model.Api;
import player.model.Credentials;
import player.model.Device;
import player.model.DisplayArea;


class ApiController implements Infos {
  private var api: Api;
  private var credentials: Credentials;
  private var displayArea: DisplayArea;
  private var deviceId: String;
  private var deviceAttributes: Hash<String>;
  private var longitude: Float;
  private var latitude: Float;

  public function new(api: Api, credentials: Credentials, device: Device,
                      displayArea: DisplayArea) {
    this.api = api;
    this.credentials = credentials;
    this.displayArea = displayArea;
    this.deviceId = device.getDeviceId();
    this.deviceAttributes = device.getAttributes();
    this.longitude = device.getLongitude();
    this.latitude = device.getLatitude();
  }

  public function getAds(handler: Advertisement->Void) {
    var request = new AdRequest(
      credentials.getNetworkId(),
      credentials.getApiKey(),
      this.deviceId,
      Date.now(),
      this.deviceAttributes,
      this.displayArea,
      this.longitude,
      this.latitude);

    var self = this;
    api.getAd(request, function(response: AdResponse) {
      for(advertisement in response.advertisements) {
        var complete = function() {
          self.sendProofOfPlay(advertisement);
        }
        advertisement.complete = complete;
        handler(advertisement);
      }
    });
  }

  private function sendProofOfPlay(ad: Advertisement) {
    api.sendPop(ad, function() { });
  }
}
