using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

module Components {
  module Debug {
    class Colors extends Ui.Drawable {
      var systemColors = [
        Graphics.COLOR_WHITE,
        Graphics.COLOR_LT_GRAY,
        Graphics.COLOR_DK_GRAY,
        Graphics.COLOR_BLACK,
        Graphics.COLOR_RED,
        Graphics.COLOR_DK_RED,
        Graphics.COLOR_ORANGE,
        Graphics.COLOR_YELLOW,
        Graphics.COLOR_GREEN,
        Graphics.COLOR_DK_GREEN,
        Graphics.COLOR_BLUE,
        Graphics.COLOR_DK_BLUE,
        Graphics.COLOR_PURPLE,
        Graphics.COLOR_PINK,
        Graphics.COLOR_TRANSPARENT,
      ];

      var customColors = [
        Colours.RED,
        Colours.ORANGE,
        Colours.YELLOW,
        Colours.GREEN,
        Colours.BLUE,
        Colours.PURPLE,
        Colours.PINK,
        Colours.AQUA,
        Colours.MINT,
      ];

      function initialize(params) {
        Drawable.initialize(params);
      }

      function draw(dc) {

        var colors = [];
        colors.addAll(systemColors);
        colors.addAll(customColors);

        // Screen dimensions
        // var width = dc.getWidth();
        // var height = dc.getHeight();

        // // // Set the color
        // dc.setPenWidth(2);
        // dc.setColor(Graphics.COLOR_RED, Gfx.COLOR_BLUE);
        // dc.fillRectangle(0, 0, width, height);

        // Number of circles
        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() / 2;
        var radius = 100; // Radius for the circle arrangement
        var circleRadius = 18; // Radius of each individual circle
        var numCircles = colors.size();

        // Calculate and draw each circle
        for (var i = 0; i < numCircles; i++) {
            // Angle in radians for this circle
            var angle = (i * 2 * Math.PI) / numCircles;

            // Calculate circle position
            var circleX = centerX + radius * Math.cos(angle);
            var circleY = centerY + radius * Math.sin(angle);

            // Set color
            dc.setColor(colors[i], Gfx.COLOR_TRANSPARENT);

            // Draw the circle
            dc.fillCircle(circleX, circleY, circleRadius);
        }

        // // Square size
        // var squareSize = 20;

        // // Spacing
        // var padding = 5;

        // // Columns and rows
        // var cols = width / (squareSize + padding);
        // var x = padding;
        // var y = padding;

        // for (var i = 0; i < colors.size(); i++) {
        //   if (i > 0 && i % cols == 0) {
        //       // Move to the next row
        //       x = padding;
        //       y += squareSize + padding;
        //   }

        //   // Set the color
        //   dc.setColor(colors[i], Gfx.COLOR_TRANSPARENT);

        //   // Draw the square
        //   dc.fillRectangle(x, y, squareSize, squareSize);

        //   // Update x for the next square
        //   x += squareSize + padding;
        // }
      }
    }
  }
}
