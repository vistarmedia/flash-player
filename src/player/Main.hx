package player;

import unject.StandardKernel;

import player.controller.Player;
import player.module.PlayerModule;


class Main {
  public static function main() {
    haxe.Log.setColor(0xFF0000);
    var loaderParams = flash.Lib.current.loaderInfo.parameters;
    var kernel = new StandardKernel([new PlayerModule(loaderParams)]);
    var player = kernel.get(Player);

    player.start();
  }
}
