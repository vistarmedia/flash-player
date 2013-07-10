package player.assetbank;

import flash.display.DisplayObject;

interface Media {
  public function isLoaded(): Bool;
  public function getDisplay(): DisplayObject;
  public function play(): Void;
  public function stop(): Void;
  public function rewind(): Void;
  public function resizeTo(width: Int, height: Int): Void;
}
