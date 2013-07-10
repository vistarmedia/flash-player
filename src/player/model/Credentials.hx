package player.model;

import haxe.rtti.Infos;


class Credentials implements Infos {
	private var networkId: String;
	private var apiKey: String;
  private var demoMode: Bool;
	
	public function new(networkId: String, apiKey: String, demoMode: Bool) {
		this.networkId = networkId;
		this.apiKey = apiKey;
    this.demoMode = demoMode;
	}
	
	public function getNetworkId(): String {
		return networkId;
	}
	
	public function getApiKey(): String {
		return apiKey;
	}

  public function isDemoMode(): Bool {
    return this.demoMode;
  }
}
