package player.model;

import haxe.rtti.Infos;


class Device implements Infos {
	private var deviceId: String;
  private var attributes: Hash<String>;

	public function new(deviceId: String, attributes: Hash<String>) {
    this.deviceId = deviceId;
    this.attributes = attributes;
  }

  public function getDeviceId(): String {
    return this.deviceId;
  }

  public function getAttributes(): Hash<String> {
    return this.attributes;
  }
}
