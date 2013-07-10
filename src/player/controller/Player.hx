package player.controller;

import haxe.rtti.Infos;

import player.model.Advertisement;
import player.model.PlayQueue;
import player.view.Display;


class Player implements Infos {
  private var apiController: ApiController;
  private var display: Display;
  private var playQueue: PlayQueue;

  public function new(apiController: ApiController, playQueue: PlayQueue,
                      display: Display) {
    this.apiController = apiController;
    this.playQueue = playQueue;
    this.display = display;

    this.playQueue.requestMore = loadAds;
  }

  public function start() {
    loadAds();
    display.showNextAd();
  }

  private function loadAds(count: Int=0) {
    var self = this;
    apiController.getAds(function(advertisement: Advertisement) {
      self.playQueue.push(advertisement);
    });
  }
}
