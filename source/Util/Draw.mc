import Toybox.Lang;
import Types;
using Toybox.Graphics as Gfx;
using Toybox.Math;
using Toybox.System;

function mirrorAngle(angle) {
  if (angle < 0) {
    return mirrorAngle(abs(angle));
  }

  var result = 360 - angle;
  if (result >= 360) {
    return result - 360;
  }
  return result;
}

function mapAngle(angle) {
  var result = mirrorAngle(angle + 90);
  if (angle <= 90) {
    return result - 180;
  }
  return result + 180;
}

function offsetFromCenter(offset, degrees) as Point {
  return offsetFromPoint(Layout.center, offset, degrees);
}

function offsetFromPoint(point as Point, offset, degrees) as Point {
  var radians = Math.toRadians(degrees + 90);
  var x = point.x - offset * Math.cos(radians);
  var y = point.y - offset * Math.sin(radians);
  return new Point(toInteger(x), toInteger(y));
}

function mapArcDegrees(start, end, rotation) as Array<Number> {
  var degreeStart = mapAngle(start) - rotation;
  var degreeEnd = mapAngle(end) - rotation;
  return [degreeStart, degreeEnd];
}

// New version
function drawAnArc(dc, x, y, radius, start, end) {
  dc.drawArc(x, y, radius, Gfx.ARC_CLOCKWISE, mapAngle(start), mapAngle(end));
}

// Draw an arc using normal clock degrees (0 = 12, 90 = 3)
function drawArc(dc, radius, start, end, position) {
  var offset = position.get(:offset) || 0;
  var rotation = position.get(:rotation) || 0;
  var angle = position.get(:angle) || 0;

  var xy = offsetFromCenter(offset, angle);
  var degrees = mapArcDegrees(start, end, rotation);

  dc.drawArc(
    xy.x,
    xy.y,
    radius,
    Gfx.ARC_CLOCKWISE,
    degrees[0],
    degrees[1]
  );
}

function drawRoundedArc(dc, x, y, radius, start, end, thickness) {
  dc.setPenWidth(thickness);

  // Convert thickness and radius to degree offset
  var offsetRadians = Math.asin(thickness / 2 / (2.0 * radius));
  var offsetDegrees = offsetRadians * (180.0 / Math.PI);
  var offsetStart = start + offsetDegrees;
  var offsetEnd = end - offsetDegrees;

  // If to add the cap offset to start and end reverses their dynamic
  // (ie. creates a full arc, rather than a tiny one) then set as the same
  // Super small (1% battery arcs) can otherwise show as a full circle
  if (end > start && offsetEnd < offsetStart) {
    offsetEnd = offsetStart + 1;
  }

  drawAnArc(dc, x, y, radius, offsetStart, offsetEnd);

  // dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
  var startCap = offsetFromCenter(radius, offsetStart);
  var capOffsetX = x - (Layout.fullWidth / 2);
  var capOffsetY = y - (Layout.fullWidth / 2);
  dc.fillCircle(startCap.x + capOffsetX, startCap.y + capOffsetY, thickness / 2);

  var endCap = offsetFromCenter(radius, offsetEnd);
  // dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
  dc.fillCircle(endCap.x + capOffsetX, endCap.y + capOffsetY, thickness / 2);
}

// Same as draw an arc, but is hollow (provide "thickness" as last param)
function drawHollowArc(dc, radius, start, end, position, thickness) {
  var offset = position.get(:offset) || 0;
  var rotation = position.get(:rotation) || 0;
  var angle = position.get(:angle) || 0;

  // Position
  var xy = offsetFromCenter(offset, angle);
  var x = xy.x; //xy[0];
  var y = xy.y; //xy[1];

  // Draw the arc
  var degreeStart = mapAngle(start) - rotation;
  var degreeEnd = mapAngle(end) - rotation;
  var innerRadius = radius - thickness + 8;
  var outerRadius = radius;
  dc.drawArc(x, y, innerRadius, Gfx.ARC_CLOCKWISE, degreeStart, degreeEnd);
  dc.drawArc(x, y, outerRadius, Gfx.ARC_CLOCKWISE, degreeStart, degreeEnd);

  // Draw arc close caps
  var delta = 2;
  drawLine(dc, x, y, innerRadius + delta, outerRadius + delta, Math.toRadians(start - 90));
  drawLine(dc, x, y, innerRadius + delta, outerRadius + delta, Math.toRadians(end - 90));
}

function drawLine(dc, x, y, innerRadius, outerRadius, radians) {
  var sX = x + innerRadius * Math.cos(radians);
  var sY = y + innerRadius * Math.sin(radians);
  var eX = x + outerRadius * Math.cos(radians);
  var eY = y + outerRadius * Math.sin(radians);
  dc.drawLine(sX, sY, eX, eY);
}

// function toRadians(degrees) {
//   return degrees * (Math.PI / 180.0);
// }

// 0 degrees points to the right (3:00 position).
// Angles increase counterclockwise.
// 90 degrees points up (12:00 position).
// 180 degrees points to the left (9:00 position).
// 270 degrees points down (6:00 position).
function toCartesianDegrees(angle) {
  var cartesianDegrees = mod(90.0 - angle, 360.0);
  // Ensure positive angles (MonkeyC handles angles < 0, but let's keep it clean)
  if (cartesianDegrees < 0) {
    cartesianDegrees += 360;
  }
  return cartesianDegrees;
}

function drawRadialLine(dc, x, y, innerRadius, outerRadius, angle) {
  var cartesianDegrees = toCartesianDegrees(angle);
  var radians = Math.toRadians(cartesianDegrees);
  var sX = x + innerRadius * Math.cos(radians);
  var sY = y - innerRadius * Math.sin(radians);
  var eX = x + outerRadius * Math.cos(radians);
  var eY = y - outerRadius * Math.sin(radians);
  dc.drawLine(sX, sY, eX, eY);
}

// Like "ticks" around a circle, draw the segments around the provided radius
// Iterates through the entire 360 but only draws a line when past the "start"
// threshold
function drawHashedArc(dc, radius, start, end, position, segments, length) {
  var offset = position.get(:offset) || 0;
  var rotation = position.get(:rotation) || 0;
  var angle = position.get(:angle) || 0;

  // Center point
  var xy = offsetFromCenter(offset, angle);
  var x = xy.x; //xy[0];
  var y = xy.y; //xy[1];
  var outerRadius = radius;
  var innerRadius = outerRadius - length;

  // Starting point
  var radians = Math.toRadians(-90);
  var dontDrawHashUntil = Math.toRadians(start-90);// Math.toRadians(end - 90);//Math.toRadians(360);//radians + Math.toRadians(start) - Math.toRadians(90);
  if (rotation) {
    radians = radians - Math.toRadians(rotation - 90);
    dontDrawHashUntil = dontDrawHashUntil - Math.toRadians(rotation - 90);
  }

  // End point
  var totalRadians = Math.toRadians(end);
  var oneFinalSegment = 0;
  if (end < 360) {
    oneFinalSegment = 1;
  }

  // Loop through segments
  for (var i = 0; i < segments + oneFinalSegment; i += 1) {
    if (radians >= dontDrawHashUntil) {
      drawLine(dc, x, y, innerRadius, outerRadius, radians);
    }

    radians += totalRadians / segments;
  }
}

// Like "ticks" around a circle, draw the segments around the provided radius
// Iterates through the entire 360 but only draws a line when past the "start"
// threshold
function drawAHashedArc(dc, x, y, radius, start, end, thickness, segmentCount) {
  var outerRadius = radius;
  var innerRadius = outerRadius - thickness;
  var length = traversedAngleLength(start, end);
  var increment = length * 1.0 / (segmentCount - 1);

  for (var i = 0; i < segmentCount; i += 1) {
    drawRadialLine(dc, x, y, innerRadius, outerRadius, Math.ceil(incrementAngle(start, i * increment)));
  }
}
