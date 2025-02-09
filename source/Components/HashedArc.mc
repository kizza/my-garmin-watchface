import Toybox.Lang;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

module Components {
  class HashedArc extends Ui.Drawable {
    typedef Params as {
      :visible as Boolean,
      :start as Number,
      :end as Number,
      :radius as Number,
      :data as Symbol,
      :foreground as Number,
      :background as Number,
      :thickness as Number,
      :offsetRadius as Number or Null,
      :offsetAngle as Number or Null,
    };

    var visible = true;
    var start = 0;
    var end = 180;
    var percentage = 0.5;
    var data;
    var radius = 120;
    var foreground = Graphics.COLOR_WHITE;
    var background = Graphics.COLOR_DK_GRAY;
    var thickness = 2;
    var length = 20;
    var offsetRadius = 0;
    var offsetAngle = 0;

    function initialize(params) {
      Drawable.initialize(params);
      self.start = params.get(:start);
      self.end = params.get(:end);
      self.data = params.get(:data);
      self.foreground = params.get(:foreground);
      self.background = params.get(:background);
      self.thickness = params.get(:thickness);
      self.radius = params.get(:radius);
      self.length = calculateArcLength();

      if (params.hasKey(:visible)) {
        self.visible = params.get(:visible);
      }

      if (params.hasKey(:offsetRadius)) {
        self.offsetRadius = params.get(:offsetRadius);
        self.offsetAngle = params.get(:offsetAngle);
      }
    }

    // var percentage = (Data.activityInfo.steps * 100) / Data.activityInfo.stepGoal;

    function draw(dc) {
      if (visible == false) {
        return;
      }

      self.percentage = Data.lookup(self.data);

      var xy = offsetFromCenter(rem(self.offsetRadius), self.offsetAngle);
      var radius = self.radius - (thickness / 2);

      dc.setColor(self.background, Gfx.COLOR_TRANSPARENT);
      // dc.setColor(Colours.PINK, Gfx.COLOR_TRANSPARENT);
      drawRoundedArc(dc, xy.x, xy.y, radius, self.start, self.end, self.thickness);

      // dc.setColor(self.color, Gfx.COLOR_TRANSPARENT);
      // dc.setPenWidth(2);
      // drawHashedArc(dc, Layout.fullWidth / 2, ratio, maxDegrees, position, 20, thickness);
    }

    // function getWidth(dc) {
    //   return self.radius * 2;
    // }

    function calculateArcLength() {
      var start = self.start;
      var end = self.end;
      if (end < start) { end = end + 360; }
      return end - start;
    }

    function calculateArcFillEnd() {
      return self.start + (self.percentage * self.length);
    }
  }
}
