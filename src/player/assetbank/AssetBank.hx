package player.assetbank;

import haxe.rtti.Infos;


class AssetBank implements Infos {
  private var media: Hash<Media>;

  public function new() {
    this.media   = new Hash<Media>();
  }

  public function hasRegistered(url: String) {
    return this.media.get(url) != null;
  }

  public function hasLoaded(url: String) {
    var media = this.media.get(url);
    if(media == null) {
      return false;
    }
    return media.isLoaded();
  }

  public function register(mimeType: String, url: String) {
    var exists = media.get(url);
    if(exists != null) {
      return exists;
    }
    var self = this;

    var media: Media = null;
    switch(mimeType) {
      case "video/x-flv", "video/mp4":
        media = cast(new VideoMedia(url), Media);
      case "image/jpeg", "image/gif", "image/png":
        media = cast(new ImageMedia(url), Media);
    }
    if(media != null) {
      this.media.set(url, media);
    }
    return media;
  }

  public function get(url: String): Media {
    return media.get(url);
  }
}
