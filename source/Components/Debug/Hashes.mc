using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

module Components {
  module Debug {
    class Hashes extends Ui.Drawable {
      function initialize(params) {
        Drawable.initialize(params);
      }

      function draw(dc) {
        var fullRadius = Layout.fullWidth / 2;
        var xy = offsetFromCenter(0, 0);
        dc.setPenWidth(3);

        var thickness;
        var count;

        // Draw ticks
        thickness = 10;
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        count = 60; // minutes
        drawAHashedArc(dc, xy.x, xy.y, fullWidth / 2, (360.0 / count), 360, thickness, count);

        thickness = 20;
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
        count = 60 / 5; // 5 minute blocks
        drawAHashedArc(dc, xy.x, xy.y, fullWidth / 2, (360.0 / count), 360, thickness, count);

        thickness = 30;
        dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
        drawAHashedArc(dc, xy.x, xy.y, fullWidth / 2, 270, 180, thickness, 4);



        var time = new Types.Time(2, 19, 37);
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
        dc.fillCircle(xy.x, xy.y, 8);
        dc.setPenWidth(5);
        drawRadialLine(dc, xy.x, xy.y, 0, fullRadius * 0.75, hourAngle(time.hours, time.minutes));

        dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
        dc.setPenWidth(3);
        dc.fillCircle(xy.x, xy.y, 6);
        drawRadialLine(dc, xy.x, xy.y, 0, fullRadius * 0.95, minuteAngle(time.minutes));

        dc.setPenWidth(2);
        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.fillCircle(xy.x, xy.y, 4);
        drawRadialLine(dc, xy.x, xy.y, 0, fullRadius, minuteAngle(time.seconds));
      }
    }
  }
}
