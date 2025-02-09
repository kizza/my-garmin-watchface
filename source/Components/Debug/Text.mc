using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
import Fonts;

module Components {
  module Debug {
    class Text extends Ui.Drawable {
      function initialize(params) {
        Drawable.initialize(params);
      }

      function draw(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);

        var point = offsetFromCenter(0, 180);
        // var font = Fonts.get(:AdventProBold, 36);
        var font = Fonts.get(Theme.Typography.secondary);
        var fontHeight = dc.getFontHeight(font);
        // var fontWidth = dc.getTextWidthInPixels(Data.time.seconds.toString(), Theme.Typography.largeFont);

        var yOffset = Math.floor(fontHeight / 2);
        dc.drawText(
          point.x,
          point.y - yOffset,
          font,
          Data.time.seconds,
          Graphics.TEXT_JUSTIFY_CENTER
        );

        // dc.drawText(point.x, point.y, Theme.Typography.smallFont, Data.time.seconds, Graphics.TEXT_JUSTIFY_CENTER);
      }
    }
  }
}
