using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

module Components {
  module Debug {
    class Arcs extends Ui.Drawable {
      function initialize(params) {
        Drawable.initialize(params);
      }

      function draw(dc) {
        var xy = offsetFromCenter(0, 0);
        var thickness = 30;
        dc.setPenWidth(thickness);
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
        drawAnArc(dc, xy.x, xy.y, fullWidth / 2, 0, 90);

        // dc.setPenWidth(3);
        // drawAHashedArc(dc, xy.x, xy.y, fullWidth / 2, 270, 0, thickness, 5);

        // var fullRadius = Layout.fullWidth / 2;
        // drawRadialLine(dc, xy.x, xy.y, 1, fullRadius / 4, 0 + 45);
        // dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
        // drawRadialLine(dc, xy.x, xy.y, 1, fullRadius / 4, 90 + 45);
        // dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
        // drawRadialLine(dc, xy.x, xy.y, 1, fullRadius / 4, 180 + 45);
        // dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
        // drawRadialLine(dc, xy.x, xy.y, 1, fullRadius / 4, 270 + 45);
        // dc.setPenWidth(3);
        // dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
        // drawHollowArc(dc, fullWidth / 2.6, 90 + 3, 180 - 3, position, 22);

        // var arc = new RoundedArc({
        //   foreground: Colours.BLUE,
        //   background: Colors.RED,
        //   start: 180,
        //   end: 270,
        // });

        dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
        drawRoundedArc(dc, xy.x, xy.y, fullWidth / 3, 270, 90, 26);
        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
        drawRoundedArc(dc, xy.x, xy.y, fullWidth / 3, 270, 20, 26);

        xy = offsetFromCenter(10, 120);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        drawRoundedArc(dc, xy.x, xy.y, 40, 0, 180, 8);
        dc.setColor(Colours.YELLOW, Gfx.COLOR_TRANSPARENT);
        drawRoundedArc(dc, xy.x, xy.y, 40, 30, 150, 8);
      }
    }
  }
}
