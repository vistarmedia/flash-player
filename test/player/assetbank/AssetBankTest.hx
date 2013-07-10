package player.assetbank;

import haxe.rtti.Infos;
import haxe.unit.TestCase;

class AssetBankTest extends TestCase, implements Infos {
  public function testUrlCaching() {
    var assetBank = new AssetBank();
    var testUrl = "file://test/foo.png";
   
    this.assertFalse(assetBank.hasRegistered(testUrl));
    assetBank.register("image/jpeg", testUrl);
    this.assertTrue(assetBank.hasRegistered(testUrl));
  }
}
