import Toybox.Lang;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

module Components {
  enum ArcVariant {
    SOLID = 0,
    HASHED,
  }

  class RoundedArc extends Base {
    static const SOLID = 0;
    static const HASHED = 1;

    typedef Params as {
      :variant as ArcVariant or Null,
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

    var variant = SOLID;
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
    // var offsetRadius = 0;
    // var offsetAngle = 0;

    function initialize(params) {
      Base.initialize(params);
      self.start = params.get(:start);
      self.end = params.get(:end);
      self.data = params.get(:data);
      self.foreground = params.get(:foreground);
      self.background = params.get(:background);
      self.thickness = params.get(:thickness);
      self.radius = params.get(:radius);
      self.length = calculateArcLength();

      if (params.hasKey(:variant)) {self.variant = params.get(:variant);}
      if (params.hasKey(:visible)) {self.visible = params.get(:visible);}
      if (params.hasKey(:percentage)) {self.percentage = params.get(:percentage);}
    }

    // var percentage = (Data.activityInfo.steps * 100) / Data.activityInfo.stepGoal;

    function draw(dc) {
      if (visible == false) {
        return;
      }

      if (self.data != null) {
        self.percentage = Data.lookup(self.data);
      }

      var xy = offset;
      var radius = self.radius - (thickness / 2);
      var filledPortionEnd = calculateArcFillEnd();

      // Background arc
      if (background != Gfx.COLOR_TRANSPARENT) {
        dc.setColor(self.background, Gfx.COLOR_TRANSPARENT);

        if (self.variant == SOLID) {
          drawRoundedArc(dc, xy.x, xy.y, radius, self.start, self.end, self.thickness);
        } else {
          var remainderLength = traversedAngleLength(filledPortionEnd, self.end);
          var segmentCount = Math.floor(remainderLength / 8).toNumber();
          // debugHash({
          //   :start => self.start,
          //   :percentage => self.percentage,
          //   :length => self.length,
          //   :filled => filledPortionEnd,
          //   :end => self.end,
          //   :segmentCount => segmentCount,
          //   :remainderLength => remainderLength,
          // });
          dc.setPenWidth(3);
          drawAHashedArc(dc, xy.x, xy.y, self.radius, filledPortionEnd, self.end, self.thickness, segmentCount);
        }
      }

      // Filled arc
      if (self.percentage > 0) {
        dc.setColor(self.foreground, Gfx.COLOR_TRANSPARENT);
        drawRoundedArc(dc, xy.x, xy.y, radius, self.start, filledPortionEnd, self.thickness);
      }
    }

    function getWidth(dc) {
      return self.radius * 2;
    }

    function calculateArcLength() {
      return traversedAngleLength(self.start, self.end);
    }

    function calculateArcFillEnd() {
      var end = self.start + (self.percentage * self.length);
      // debugHash({
      //   :percentage => self.percentage,
      //   :length => self.length,
      //   :end => self.end,
      //   :calculatedEnd => end,
      // });
      if (end > 360) { end-= 360; } // Given possible start/end, could traverse into > 360
      return end;
    }
  }
}
