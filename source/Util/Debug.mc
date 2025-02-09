import Toybox.Lang;
using Toybox.System;

function debugHash(hash as Dictionary) {
  var keys = hash.keys();
  var output = "";
  var join = "";

  for (var i = 0; i < keys.size(); i++) {
    var key = keys[i];
    var value = hash.get(key);
    output = output + join + key.toString() + "=" + value;
    join = ", ";
  }

  System.println(output);
}
