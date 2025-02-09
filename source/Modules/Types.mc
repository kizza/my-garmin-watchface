import Toybox.Lang;
import Toybox.Graphics;

module Types {
  class Time {
    var hours = 0;
    var minutes = 0;
    var seconds = 0;
    var is24Hour = false;

    function initialize(hours as Number, minutes as Number, seconds as Number) {
      self.hours = hours;
      self.minutes = minutes;
      self.seconds = seconds;
    }
  }

  class ActivityInfo {
    var steps = 0;
    var stepGoal = 0;
    var moveBarLevel = 0;
  }

  class Point {
    var x as Number = 0;
    var y as Number = 0;

    function initialize(x as Number, y as Number) {
      self.x = x;
      self.y = y;
    }
  }

  class Font {
    var name;
    var size;
    var resource;

    function initialize(name as Symbol, size as Number, resource as FontReference) {
      self.name = name.toString();
      self.size = size;
      self.resource = resource;
    }

    function toString() {
      return self.name + "@" + self.size.toString();
    }
  }
}
