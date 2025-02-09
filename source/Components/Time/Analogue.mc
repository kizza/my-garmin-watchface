import Toybox.Lang;
using Toybox.Graphics as Gfx;
using Toybox.Time.Gregorian;
using Toybox.WatchUi as Ui;

module Components {
  module Time {
    class Analogue extends Ui.Drawable {
      // var largeFont;
      // var normalFont;
      // var smallFont;
      // var smallestFont;
      typedef Params as {
        :hourColor as Number,
        :minuteColor as Number,
        :secondColor as Number,
      };

      var hourColor = Colours.BLUE;
      var minuteColor = Colours.WHITE;
      var secondColor = Gfx.COLOR_LT_GRAY;

      function initialize(params) {
        Drawable.initialize(params);
        self.hourColor = params.get(:hourColor);
        self.minuteColor = params.get(:minuteColor);
        self.secondColor = params.get(:secondColor);
      }

      function draw(dc) {
        // var hours = Data.time.hours;
        // var minutes = Data.time.minutes;

        // if (!Data.time.is24Hour) {
        //   hours = hours % 12;
        //   if (hours == 0) {
        //     hours = 12;
        //   }
        // }

        // var time = Data.time;//new Types.Time(2, 19, 37);
        drawCenteredAnalogueFace(dc, Data.time);
      }

      function drawCenteredAnalogueFace(dc, time as Types.Time) {
        var xy = offsetFromCenter(0, 0);
        var fullRadius = Layout.fullWidth / 2;

        dc.setColor(self.hourColor, Gfx.COLOR_TRANSPARENT);
        dc.fillCircle(xy.x, xy.y, 8);
        dc.setPenWidth(8);
        drawRadialLine(dc, xy.x, xy.y, 0, fullRadius * 0.6, hourAngle(time.hours, time.minutes));

        dc.setColor(self.minuteColor, Gfx.COLOR_TRANSPARENT);
        dc.setPenWidth(5);
        dc.fillCircle(xy.x, xy.y, 6);
        drawRadialLine(dc, xy.x, xy.y, 0, fullRadius * 0.85, minuteAngle(time.minutes));

        // Don't draw seconds unti partial update is nailed down
        // dc.setPenWidth(2);
        // // dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        // dc.setColor(self.secondColor, Gfx.COLOR_TRANSPARENT);
        // dc.fillCircle(xy.x, xy.y, 4);
        // drawRadialLine(dc, xy.x, xy.y, 0, fullRadius, minuteAngle(time.seconds));
      }
    }
  }
}
