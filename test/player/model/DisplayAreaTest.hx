package player.model;

import haxe.rtti.Infos;
import haxe.unit.TestCase;
import unject.StandardKernel;

import player.module.TestModule;


class DisplayAreaTest extends TestCase, implements Infos {

  public function testToSimple() {
    var media = ["image/jpeg", "image/gif", "video/mp4"];
    var displayArea = new DisplayArea("myid", 800, 600, true, media);

    var simple = displayArea.toSimple();
    assertEquals("myid", simple.get("id"));
    assertEquals(true,   simple.get("allow_audio"));
    assertEquals(media,  simple.get("supported_media"));
    assertEquals(null,   simple.get("suportedMedia"));
  }

  public function testToJson() {
    var media = ["image/jpeg", "image/gif", "video/mp4"];
    var displayArea = new DisplayArea("id", 800, 600, true, media);

    var json = displayArea.toJson();
    assertTrue(json.indexOf("image\\/gif") > -1);
    assertTrue(json.indexOf("allow_audio") > -1);
  }

  /** In the test.html file, the swf is loaded as 500x501. The swf header has an
    * entirely different resolution -- 1280x720. The HTML should override the
    * flash header. */
  public function testOverrideSize() {
    var kernel = new StandardKernel([new TestModule()]);
    var displayArea = kernel.get(DisplayArea);

    this.assertEquals(500, displayArea.width);
    this.assertEquals(501, displayArea.height);
  }

  public function testDisplayAreaSingleton() {
    var kernel = new StandardKernel([new TestModule()]);
    var da1 = kernel.get(DisplayArea);
    var da2 = kernel.get(DisplayArea);
    this.assertEquals(da1, da2);
  }
}
