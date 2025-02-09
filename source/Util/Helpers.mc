import Toybox.Lang;
using Toybox.Math;
using Toybox.System;

function rem(value as Float) {
  return (value / 240.0) * Layout.fullWidth;
}

// Supports float mods
function mod(a as Float, b as Float) as Float {
  return a - b * Math.floor(a / b);
}

function abs(number) {
  if (number < 0) { return -1 * number; } else { return number; }
}

function max(number1, number2) {
  if (number1 > number2) { return number1; } else { return number2; }
}

function min(number1, number2) {
  if (number1 < number2) { return number1; } else { return number2; }
}

function percentage(value, total) as Float {
  return min(value / total, 1.0);
}

function toInteger(input) {
  return Math.round(input).toNumber();
}

function randomNumber(size) {
  return Math.rand() % size;
}

function isSimulator() as Boolean {
  var deviceSettings = System.getDeviceSettings();
  if (deviceSettings != null) {
    var development = "91119a46f3f6a46abfa0440046c145ed16399d2a";
    return deviceSettings.uniqueIdentifier.equals(development);
  }
  return false;
}

function shuffleArray(array as Array<String>) {
  var shuffled = [];
  var index, item;
  var count = array.size();
  Math.srand(System.getTimer());

  for (var i=0; i<count; i++) {
    index = randomNumber(count);
    item = array[index];
    array.remove(item);
    shuffled.add(item);
  }

  return shuffled;
}
