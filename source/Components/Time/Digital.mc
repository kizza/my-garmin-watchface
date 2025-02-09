import Toybox.Lang;
using Toybox.Graphics as Gfx;
using Toybox.Time.Gregorian;
using Toybox.WatchUi as Ui;

module Components {
  module Time {
    class Digital extends Ui.Drawable {
      // var largeFont;
      // var normalFont;
      // var smallFont;
      // var smallestFont;

      function initialize(params) {
        Drawable.initialize(params);

        // largeFont = Ui.loadResource(Rez.Fonts.HourFont);
        // normalFont = Ui.loadResource(Rez.Fonts.DigitalFont);
        // smallFont = Ui.loadResource(Rez.Fonts.SmallerFont);
        // smallestFont = Ui.loadResource(Rez.Fonts.SmallestFont);

        // var singleFont = Ui.loadResource(Rez.Fonts.BlackOps);
        // largeFont = singleFont;
        // normalFont = singleFont;
        // smallFont = singleFont;
        // smallestFont = singleFont;
      }

      function draw(dc) {
        // System.println("Time.Digital.Draw");
        var hours = Data.time.hours;
        var minutes = Data.time.minutes.format("%02d");

        if (!Data.time.is24Hour) {
          hours = hours % 12;
          if (hours == 0) {
            hours = 12;
          }
        }

        drawCenteredDigitalFace(dc, hours.toString(), minutes);
      }

      function drawCenteredDigitalFace(dc, hours, minutes) {
        // Typography
        var typography = getTypography(dc, hours, minutes);

        // Position
        var hoursWidth = dc.getTextWidthInPixels(hours, typography.hourFont.resource);
        var labelWidth = calculateTotalWidth(dc, hours, minutes, typography);//hourFont, minuteFont, hourGap);
        var minutesHeight = dc.getFontHeight(typography.minuteFont.resource);
        var x = (Layout.fullWidth / 2) - (labelWidth / 2);
        var y = Layout.center.y;// (Layout.fullHeight / 2) - (Gfx.getFontHeight(typography.minuteFont.resource) / 2);

        // Hours
        dc.setColor(Settings.get(:hourColour), Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, typography.hourFont.resource, hours, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        // Minutes
        dc.setColor(Settings.get(:minuteColour), Graphics.COLOR_TRANSPARENT);
        dc.drawText(x + hoursWidth + typography.gap, y, typography.minuteFont.resource, minutes, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        // Date
        var info = getDate();
        var dateLabel = Lang.format("$1$ $2$ $3$", [info[:day], info[:date], info[:month]]);
        // label = label.toUpper();
        dc.setColor(Settings.get(:minuteColour), Graphics.COLOR_TRANSPARENT);

        var dateFont = Gfx.FONT_XTINY;//Ui.loadResource(Rez.Fonts.DigitalFont);
        // dateFont = Fonts.get(Theme.Typography.tertiary, 36).resource
        dc.drawText(x + hoursWidth + typography.gap, y + (minutesHeight / 2), dateFont, dateLabel, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        // Fonts.release(typography.hourFont);
        // Fonts.release(typography.minuteFont);
      }

      class Typography {
        var hourFont;
        var minuteFont;
        var gap = 0;

        function initialize(hourFont, minuteFont, gap) {
          self.hourFont = hourFont;
          self.minuteFont = minuteFont;
          self.gap = gap;
        }
      }

      function getTypography(dc, hours, minutes) as Typography {
        return new Typography(
          Fonts.get(Theme.Typography.primary),
          Fonts.get(Theme.Typography.secondary),
          // Fonts.get(Theme.Typography.primary, 144),
          // Fonts.get(Theme.Typography.secondary, 120),
          0
        );
      }

      // function foo(dc, hours, minutes) as Typography {
      //   var largeFont = Theme.Typography.largeFont;
      //   var normalFont = Theme.Typography.normalFont;
      //   var smallFont = Theme.Typography.smallFont;
      //   var smallestFont = Theme.Typography.smallestFont;

      //   var attempts = [
      //     new Typography(largeFont, largeFont, 0),
      //     new Typography(normalFont, normalFont, 0),
      //     new Typography(smallFont, smallFont, 0),
      //     new Typography(smallestFont, smallestFont, 0),
      //     // new Typography(largeFont, normalFont, -2),
      //     // new Typography(normalFont, smallFont, -2),
      //     // new Typography(smallFont, smallestFont, -2)
      //   ];

      //   // if (Settings.get(:enlargeHours) != true) {
      //   //   attempts = [
      //   //     new Typography(normalFont, normalFont, 0),
      //   //     new Typography(smallFont, smallFont, 0),
      //   //     new Typography(smallestFont, smallestFont, 0)
      //   //   ];
      //   // }

      //   var attempt;
      //   var width;
      //   for (var i=0; i<attempts.size(); i++) {
      //     attempt = attempts[i];
      //     width = calculateTotalWidth(dc, hours, minutes, attempt);//attempt[0], attempt[1], attempt[2]);
      //     if (width < Layout.fullWidth * 0.94) {
      //       // return [attempt[0], attempt[1], attempt[2]];
      //       return attempt;
      //       // return new Typography(attempt[0], attempt[1], attempt[2]);
      //     }
      //   }

      //   return new Typography(smallFont, smallFont, 0);
      // }

      function calculateTotalWidth(dc, hours, minutes, typography) { //hourFont, minuteFont, gap) {
        var hoursWidth = dc.getTextWidthInPixels(hours, typography.hourFont.resource);
        var minutesWidth = dc.getTextWidthInPixels(minutes, typography.minuteFont.resource);
        return hoursWidth + typography.gap + minutesWidth;
      }

      function getDate() as Dictionary<Symbol, String> {
        var info = Gregorian.info(Toybox.Time.now(), Toybox.Time.FORMAT_LONG);
        return {
          :day => info.day_of_week.substring(0, 3),
          :date => info.day,
          :month => info.month.substring(0, 3)
        };
      }
    }
  }
}
