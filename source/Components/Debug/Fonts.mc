using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

module Components {
  module Debug {
    class Fonts extends Ui.Drawable {
      function initialize(params) {
        Drawable.initialize(params);
      }

      function draw(dc) {
        var y = 10; // Initial Y position

        var fonts = [
          Graphics.FONT_XTINY,
          Graphics.FONT_TINY,
          Graphics.FONT_SMALL,
          Graphics.FONT_MEDIUM,
          Graphics.FONT_LARGE,
          Graphics.FONT_NUMBER_MILD,
          Graphics.FONT_NUMBER_MEDIUM,
          Graphics.FONT_NUMBER_HOT,
          Graphics.FONT_NUMBER_THAI_HOT,
          // Graphics.FONT_SYSTEM_XTINY,
          // Graphics.FONT_SYSTEM_TINY,
          // Graphics.FONT_SYSTEM_SMALL,
          // Graphics.FONT_SYSTEM_MEDIUM,
          // Graphics.FONT_SYSTEM_LARGE,
          // Graphics.FONT_SYSTEM_NUMBER_MILD,
          // Graphics.FONT_SYSTEM_NUMBER_MEDIUM,
          // Graphics.FONT_SYSTEM_NUMBER_HOT,
          // Graphics.FONT_SYSTEM_NUMBER_THAI_HOT,
        ];

        var fontNames = [
          "FONT_XTINY",
          "FONT_TINY",
          "FONT_SMALL",
          "FONT_MEDIUM",
          "FONT_LARGE",
          "123 FONT_NUMBER_MILD",
          "123 FONT_NUMBER_MEDIUM",
          "123 FONT_NUMBER_HOT",
          "123 FONT_NUMBER_THAI_HOT",
          // "FONT_SYSTEM_XTINY",
          // "FONT_SYSTEM_TINY",
          // "FONT_SYSTEM_SMALL",
          // "FONT_SYSTEM_MEDIUM",
          // "FONT_SYSTEM_LARGE",
          // "FONT_SYSTEM_NUMBER_MILD",
          // "FONT_SYSTEM_NUMBER_MEDIUM",
          // "FONT_SYSTEM_NUMBER_HOT",
          // "FONT_SYSTEM_NUMBER_THAI_HOT",
        ];

        for (var i = 0; i < fonts.size(); i++) {
            dc.setColor(Graphics.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
            // dc.setFont(fonts[i]);
            dc.drawText(10, y, fonts[i], fontNames[i], Graphics.TEXT_JUSTIFY_LEFT);

            // dc.drawText(x - 4 + iconWidth + gap, y, font, label[:value], Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);

            y += 20; // Move down for the next font
        }
      }
    }
  }
}
