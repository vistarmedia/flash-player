package player.transport;

import haxe.rtti.Infos;


interface Transport implements Infos {
  public function get(url: String, handler: Response->Void): Void;
  public function post(url: String, body: String, handler: Response->Void): Void;
}
