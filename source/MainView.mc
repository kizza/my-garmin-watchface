import Toybox.Lang;

using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Timer;

var fullWidth = 240;
var fullHeight = 240;
var themeColour = 0x56FFAC;
var themeColours = {
  :placeholder => 0x2B2B2B
};
var partialUpdatesAllowed = false;
// var dateTime;
// var activityInfo;
var deviceSettings;
// var batteryPercentage;
// var clockTime;
var settings;

var theme;
// var store;

class MainView extends WatchUi.WatchFace {
  var font;
  var iconFont;
  var isAwake;
  // var screenShape;
  // var screenCenterPoint;
  var timer;
  var _layout;

  var containers as Array<Components.Container> = [];

  function initialize() {
    System.println("initialize");
    WatchFace.initialize();
    partialUpdatesAllowed = ( Toybox.WatchUi.WatchFace has :onPartialUpdate );

    // font = WatchUi.loadResource(Rez.Fonts.DigitalFont);
    iconFont = WatchUi.loadResource(Rez.Fonts.IconFont);

    Theme.Typography.initialize();
  }

  function onLayout(dc) {
    System.println("onLayout");
    Layout.initialize(dc);
    Data.read();
    self._layout = Rez.Layouts.White(dc);
    setLayout(self._layout);
    // setLayout(Rez.Layouts.Digital(dc));

    System.println("About to connect children");
    self.containers = [
      View.findDrawableById("timeContainer") as Components.Container,
      View.findDrawableById("stepsContainer") as Components.Container,
    ];

    for (var i = 0; i < self.containers.size(); i++) {
      if (self.containers[i] != null) {
        resolveContainerChildNodes(self.containers[i]);
      }
    }

    handleSettingsChange();
  }

  function resolveContainerChildNodes(container as Components.Container) {
    for (var i = 0; i < container.size; i++) {
      container.childNodes.add(
        View.findDrawableById(container.children[i])
      );
    }
  }

  function onUpdate(dc) {
    // System.println("\nWatchface onUpdate");
    Data.read();

    if (isSimulator()) {
      Mocks.mock();
    }

    for (var i = 0; i < self.containers.size(); i++) {
      if (self.containers[i] != null) {
        self.containers[i].onUpdate(dc);
      }
    }

    // var hours = View.findDrawableById("hours") as Components.Label;
    // var minutes = View.findDrawableById("hours") as Components.Label;
    // var timeContainer = View.findDrawableById("timeContainer") as Components.Container;
    // System.println("onUpdate found with " + hours.toString());
    // System.println("Total width " + hours.getWidth(dc).toString());
    // System.println("Total width " + timeContainer.layout(dc));

    // var hours = View.findDrawableById("hours")

    // _timeLabel = View.findDrawableById("TimeLabel");
    // ThemePreview.previewData();
    // ThemePreview.tick(dc);
    View.onUpdate(dc);
  }

  // function onPartialUpdate(dc) {
  //   System.println("onPartialUpdate");
  //   // ThemePreview.tick(dc);
  //   dc.setClip(132,80,30,30);
		// dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
		// dc.drawText(
  //     132,
  //     82,
  //     Graphics.FONT_MEDIUM,
  //     Data.time.seconds,
  //     Graphics.TEXT_JUSTIFY_LEFT
		// );
  //   dc.clearClip();
    // Data.speak(dc);
  // }

  function handleSettingsChange() {
    // settings = getSettings();
    Settings.read();
    themeColour = Settings.get(:themeColour);//settings[:themeColour];
  }

  // This method is called when the device re-enters sleep mode.
  // Set the isAwake flag to let onUpdate know it should stop rendering the second hand.
  function onEnterSleep() {
    System.println("On enter sleep");
    isAwake = false;
    WatchUi.requestUpdate();
  }

  // This method is called when the device exits sleep mode.
  // Set the isAwake flag to let onUpdate know it should render the second hand.
  function onExitSleep() {
    System.println("On exit sleep");
    isAwake = true;
    WatchUi.requestUpdate();
  }
}

class WatchDelegate extends WatchUi.WatchFaceDelegate {
  function initialize() {
    WatchFaceDelegate.initialize();
  }

  // The onPowerBudgetExceeded callback is called by the system if the
  // onPartialUpdate method exceeds the allowed power budget. If this occurs,
  // the system will stop invoking onPartialUpdate each second, so we set the
  // partialUpdatesAllowed flag here to let the rendering methods know they
  // should not be rendering a second hand.
  function onPowerBudgetExceeded(powerInfo) {
    System.println( "Average execution time: " + powerInfo.executionTimeAverage );
    System.println( "Allowed execution time: " + powerInfo.executionTimeLimit );
    partialUpdatesAllowed = false;
  }
}
