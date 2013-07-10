package player.transport;

class Response {
  public var status: Int;
  public var body: String;

  public function new(status: Int, body: String) {
    this.status = status;
    this.body = body;
  }
}
