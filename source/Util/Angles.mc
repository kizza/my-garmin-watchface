import Toybox.Lang;

function hourAngle(hour as Number, minute as Number) as Float {
  return (hour % 12) * 30.0 + ((minute / 60.0) * 30.0);
}

function minuteAngle(minutes as Number) as Float {
  return minutes / 60.0 * 360.0;
}

// Traversed degrees clockwise from one angle to another eg. 270 to 90 is 180
function traversedAngleLength(start, end) {
  if (end < start) { end = end + 360; }
  return end - start;
}

function incrementAngle(angle, increment) {
  var result = angle + increment;
  if (result > 360) {
    result = result - 360;
  }
  return result;
}
