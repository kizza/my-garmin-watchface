import Toybox.Lang;
import Toybox.Graphics;
using Toybox.System;

module Fonts {
  var cache as Dictionary<ResourceId, FontReference> = {};

  function get(resource as ResourceId) { //, size as Number) {
    if (resource == 0) {
      System.println("Returning system font");
      return resource;
    }

    if (!cache.hasKey(resource)) {
      System.println("Loading font "+ resource);
      cache[resource] = Toybox.WatchUi.loadResource(resource);
    } else {
      System.println("Using font cache "+ resource);
    }

    return cache[resource]; //Types.Font(name, size, cache[key]);
  }

  function release(font as Types.Font) {
    var key = font.name.toString() + font.size.toString();
    if (cache.hasKey(key)) {
      // Toybox.WatchUi.releaseResource(cache[key]);
      cache.remove(key);
    }
  }
}
