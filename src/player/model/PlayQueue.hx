package player.model;

import haxe.rtti.Infos;

import player.model.Advertisement;
import player.assetbank.AssetBank;


class PlayQueue implements Infos {
  private var queue: List<Advertisement>;
  private var assetBank: AssetBank;
  private var minItems: Int;

  public function new(assetBank: AssetBank) {
    this.assetBank = assetBank;
    queue = new List<Advertisement>();
    minItems = 3;
  }

  /** Dynamic function meant to be replaced with a real implementation. This
    * will be invoked when the play queue determines it needs more
    * advertisements. */
  public dynamic function requestMore(count: Int) { }

  /** Finds the oldest advertisement whose media is loaded. If there are no
    * advertisements, or none of the advertisements have their media loaded,
    * this will return null. */
  public function pop(): Advertisement {
    checkQueue();
    for(ad in queue) {
      if(assetBank.hasLoaded(ad.assetUrl)) {
        queue.remove(ad);
        return ad;
      }
    }
    return null;
  }

  /** Adds a new advertisement to this queue. It will also register the asset
    * with the AssetBank in case it needs to be cached in to memory. */
  public function push(ad: Advertisement) {
    var self = this;
    var media = assetBank.register(ad.mimeType, ad.assetUrl);
    if(media != null) {
      queue.add(ad);
    }
    self.checkQueue();
  }

  private function checkQueue() {
    if(queue.length < minItems) {
      requestMore(minItems - queue.length);
    }
  }
}
