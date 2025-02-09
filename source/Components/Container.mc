import Toybox.Lang;
using Toybox.WatchUi as Ui;

module Components {
  class Container extends Ui.Drawable {
    typedef Params as {
      :children as Array<String or Label>,
      :xOffset as Float or Null,
      :yOffset as Float or Null,
      :xGap as Float or Null,
    };

    var children as Array<String> = [];
    var size as Number = 0;
    var xOffset as Float = 0.0;
    var yOffset as Float = 0.0;
    var xGap as Number = 0;
    var childNodes as Array = [];
    var childWidths as Array<Number> = [];
    var childHeights as Array<Number> = [];
    var totalWidth as Number = 0, totalHeight as Number = 0;
    var offsetRadius, offsetAngle;

    function initialize(params) {
      Drawable.initialize(params);
      System.println("Container: initizlised " + identifier);
      self.children = params.get(:children);
      self.size = children.size();
      if (params.hasKey(:childNodes)) { // When passed directly
        self.childNodes = params.get(:childNodes);
      }
      if (params.hasKey(:xOffset)) { self.xOffset = params.get(:xOffset); }
      if (params.hasKey(:yOffset)) { self.yOffset = params.get(:yOffset); }
      if (params.hasKey(:xGap)) { self.xGap = params.get(:xGap); }
    }

    function draw(dc) {
      // No op
    }

    function onUpdate(dc) {
      updateChildStates();
      calculateChildWidths(dc);
      // calculateChildHeights(dc);

      // if (self.offsetRadius != null) {
      //   updateState();
      //   self.positionWithOffset(dc);
      // }

      // var totalWidth = countTotalWidths();
      var center = Layout.center.x;
      var left = center - (totalWidth / 2);
      var top = center;
      var overWidth = totalWidth - Layout.fullWidth;
      if (overWidth > 0) {
        // System.println("Overwidth of " + overWidth);
        left = left - (overWidth / 3);
      }
      // var top = Layout.center.y;// (Layout.fullHeight / 2) - (Gfx.getFontHeight(typography.minuteFont.resource) / 2);
      // var top = Layout.center.y;

      // System.println("Total width="+ totalWidth +" and height="+ totalHeight);
      for (var i = 0; i < self.size; i++) {
        self.childNodes[i].setOffset(
          left + rem(self.xOffset) + (childWidths[i] / 2),
          top + rem(self.yOffset)
        );
        left = left + self.childWidths[i] + self.xGap;
      }
    }

    function updateChildStates() {
      for (var i = 0; i < self.size; i++) {
        self.childNodes[i].updateState();
      }
    }

    function calculateChildWidths(dc) {
      childWidths = [];
      totalWidth = 0;
      for (var i = 0; i < self.size; i++) {
        childWidths.add(self.childNodes[i].getWidth(dc));
        totalWidth += childWidths[i];
      }
      totalWidth += ((self.size - 1) * self.xGap); // Add gap between children
    }

    function calculateChildHeights(dc) {
      childHeights = [];
      totalHeight = 0;
      for (var i = 0; i < self.size; i++) {
        childHeights.add(self.childNodes[i].getHeight(dc));
        if (childHeights[i] > totalHeight) {
          totalHeight = childHeights[i];
        }
      }
    }

    // function countTotalWidths() {
    //   var width = 0;
    //   for (var i = 0; i < self.size; i++) {
    //     width = width + self.childWidths[i];
    //   }
    //   width = width + ((self.size - 1) * self.xGap);
    //   return width;
    // }
  }
}
