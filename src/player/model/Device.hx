package player.model;

import haxe.rtti.Infos;


class Device implements Infos {
	private var deviceId: String;
  private var attributes: Hash<String>;
  private var longitude: Float;
  private var latitude: Float;

	public function new(deviceId: String, longitude: Float, latitude: Float,
                      attributes: Hash<String>) {
    this.deviceId = deviceId;
    this.longitude = longitude;
    this.latitude = latitude;
    this.attributes = attributes;
  }

  public function getDeviceId(): String {
    return this.deviceId;
  }

  public function getLongitude(): Float {
    return this.longitude;
  }

  public function getLatitude(): Float {
    return this.latitude;
  }

  public function getAttributes(): Hash<String> {
    return this.attributes;
  }
}
