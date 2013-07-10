flash-player
============

For digital signage providers that support Flash, we provide a nearly fully featured player than can serve realtime ads to an internet connected player. With a few small modifications, this player can interface with the most common parts of Vistar Media's API.

###Overview
The Vistar Media flash player is designed to work in sandboxed or bandwidth-limited environments. However, it does need a persistent internet connection. When scheduled for some block of time, it will poll Vistar Media's API server to buffer relevant ads for display. It supports most major media types via the standard Flash APIs.

Once running, it will only fetch a particular assets once, even if scheduled a number of times. However, it is important to note, that the Flash player cannot persist these assets to disk, so it must re-fetch assets the next time it's run. For this reason, it's best to give it a significant block of time.

###Required parameters
Each network that would like to show ads through Vistar Media must first register their network ID and obtain an API key. This information can be found either through Vistar Media's UI, or emailing api@vistarmedia.com. Along with that information, we must provided a device identifier. This can be any string under 1KB that is guaranteed to be unique for any network. Duplicate device identifiers across networks is acceptable.

The flash player expects to receive these parameters through the FlashVars interface. If this is unfeasible, contact api@vistarmedia.com, and we can probably come up with a work around.

###Example
In the following example, a Flash player is embedded with a network ID of NETWORK_ID, an API key of API_KEY, a device ID of DEVICE_ID and a custom
parameter named custom set to CUSTOM_FIELD. If any of this information is missing, you will see a banner shown in the player noting that it's in 'demo' mode.

```html
<html>
  <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
          width="1280"
          height="720"
          id="player">
    <param name="movie" value="http://PLAYER_URL.swf" />
    <param name="quality" value="high" />
    <embed src="http://PLAYER_URL.swf"
           bgcolor="#000000"
           width="1280"
           height="720"
           name="player"
           quality="high"
           allowScriptAccess="always"
           FlashVars="host=dev.api.vistarmedia.com&network_id=NETWORK_ID&api_key=API_KEY&width=1280&height=720&device_id=DEVICE_ID&custom=CUSTOM_FIELD"
           type="application/x-shockwave-flash"
           pluginspage="http://www.macromedia.com/go/getflashplayer"
           />
  </object>
</html>
```
