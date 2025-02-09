import Toybox.ActivityMonitor;
import Toybox.Lang;
using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.Time.Gregorian;

module Data {
  var battery = 100;
  var time = new Types.Time(12, 0, 0);
  var date = "?";
  var activityInfo = new Types.ActivityInfo();
  var notificationCount = 0;
  var phoneConnected = false;
  // var listeners = [] as Array<Components.Base>;

  function initialize(dc as Toybox.Graphics.Dc) {
  }

  // function listen(key as Symbol, element) {
  //   listeners.add(element);
  // }

  // function speak(dc) {
  //   System.println("Data speaking!");
  //   var size = listeners.size();
  //   for (var i = 0; i < size; i++) {
  //     listeners[i].draw(dc);
  //   }
  // }

  function read() {
    self.battery = (System.getSystemStats().battery + 0.5).toNumber();

    self.date = buildDate();

    var activityInfo = ActivityMonitor.getInfo();
    self.activityInfo.steps = activityInfo.steps;
    self.activityInfo.stepGoal = activityInfo.stepGoal;
    self.activityInfo.moveBarLevel = activityInfo.moveBarLevel;
    if (activityInfo.stepGoal == 0) {
      self.activityInfo.stepGoal = 5000;
    }

    var deviceSettings = System.getDeviceSettings();
    notificationCount = deviceSettings.notificationCount;
    phoneConnected = deviceSettings.phoneConnected;

    var clockTime = System.getClockTime();
    self.time.hours = clockTime.hour;
    self.time.minutes = clockTime.min;
    self.time.seconds = clockTime.sec;
    self.time.is24Hour = deviceSettings.is24Hour;

    format();
  }

  function format() {
    if (!self.time.is24Hour) {
      self.time.hours = self.time.hours % 12;
      if (self.time.hours == 0) {
        self.time.hours = 12;
      }
    }

    // self.time.minutes = self.time.minutes.format("%02d");
  }

  function lookup(key as Symbol) {
    switch (key.toString()) {
      case "battery":
        return toInteger(Data.battery);
      case "batteryPercentage":
        return percentage(Data.battery, 100.0);
      case "hours":
        return Data.time.hours;
      case "minutes":
        // return Data.time.minutes;
        return Data.time.minutes.format("%02d");
      case "seconds":
        return Data.time.seconds;
      case "date":
        return Data.date;
      case "steps":
        return Data.activityInfo.steps;
      case "stepsGoal":
        return Data.activityInfo.stepGoal;
      case "stepsPercentage":
        return percentage(Data.activityInfo.steps * 1.0, Data.activityInfo.stepGoal);
      case "rawStepsPercentage":
        return (Data.activityInfo.steps * 1.0) / Data.activityInfo.stepGoal;
    }
    return "?";
  }

  function buildDate() {
    var info = Gregorian.info(Toybox.Time.now(), Toybox.Time.FORMAT_LONG);
    return Toybox.Lang.format("$1$ $2$ $3$", [
        info.day_of_week.substring(0, 3),
        info.day,
        info.month.substring(0, 3)
      ]
    );
  }
}
