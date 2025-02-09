using Toybox.WatchUi as Ui;

module Layout {
  var fullWidth = 0;
  var fullHeight = 0;
  var center;

  function initialize(dc as Toybox.Graphics.Dc) {
    self.fullWidth = dc.getWidth();
    self.fullHeight = dc.getHeight();
    self.center = new Types.Point(toInteger(self.fullWidth / 2), toInteger(self.fullHeight / 2));
  }
}
