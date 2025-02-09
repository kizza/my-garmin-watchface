import Toybox.Lang;
using Toybox.Math;
using Toybox.System;

module Mocks {
  typedef Mock as {
    :hours as Number,
    :minutes as Number,
    :battery as Float,
    :moveBarLevel as Number,
  };

  const mocks as Array<Mock> = [
    {
      :hours => 10,
      :minutes => 12,
      :battery => 50.0,
      :moveBarLevel => 0,
    },
    {
      :hours => 6,
      :minutes => 55,
      :battery => 60.0,
      :moveBarLevel => 3,
    },
    {
      :hours => 12,
      :minutes => 00,
      :battery => 60.0,
      :moveBarLevel => 3,
    },
    {
      :hours => 20,
      :minutes => 45,
      :battery => 100.0,
      :moveBarLevel => 5,
    }
  ];

  const SECONDS = 1;

  var lastBucket;
  function mock() {
    var bucket = Math.floor(Data.time.seconds / SECONDS); // Map seconds to a bucket
    self.run(bucket);

    if (self.lastBucket != bucket) {
      self.lastBucket = bucket;
      self.onChange();
    }
  }

  function run(bucket as Number) {
    var i = bucket % mocks.size(); // Map bucket to mock array index
    var mock = mocks[i];

    // System.println("Mocking seconds=" + seconds.toString() + " to=" + i.toString());
    Data.time.hours = mock.get(:hours);
    Data.time.minutes = mock.get(:minutes);
    Data.battery = mock.get(:battery);

    var moveBarMocks = [0, 1, 2, 3, 4, 5];
    var moveBarMock = moveBarMocks[bucket % moveBarMocks.size()];
    Data.activityInfo.moveBarLevel = moveBarMock;

    var batteryMocks = [1];//, 1, 2, 3, 4, 5];
    var batteryMock = batteryMocks[bucket % batteryMocks.size()];
    Data.battery = batteryMock;

    // if (seconds % 4 == 0) {
    //   var fonts = Fonts.resources.keys();
    //   // var fontMock = fonts[bucket % fonts.size()];
    //   Theme.Typography.primary = fonts[randomNumber(fonts.size())];
    //   Theme.Typography.secondary = fonts[randomNumber(fonts.size())];
    //   System.println("Font= " + Theme.Typography.primary.toString() + ", and "+ Theme.Typography.secondary.toString());
    // }

    var stepMocks = [
      // {:steps => 0, :stepGoal => 100},
      // {:steps => 10, :stepGoal => 100},
      // {:steps => 20, :stepGoal => 100},
      // {:steps => 30, :stepGoal => 100},
      // {:steps => 40, :stepGoal => 100},
      // {:steps => 50, :stepGoal => 100},
      // {:steps => 60, :stepGoal => 100},
      // {:steps => 70, :stepGoal => 100},
      // {:steps => 80, :stepGoal => 100},
      // {:steps => 90, :stepGoal => 100},
      // {:steps => 100, :stepGoal => 100},
      // {:steps => 150, :stepGoal => 100},
      // {:steps => 200, :stepGoal => 100},
      {:steps => 25000, :stepGoal => 10000},
    ];
    var stepMock = stepMocks[bucket % stepMocks.size()];
    Data.activityInfo.steps = stepMock.get(:steps);
    Data.activityInfo.stepGoal = stepMock.get(:stepGoal);

    // Format the values
    Data.format();
  }

  function onChange() {
    // var percent = (Data.activityInfo.steps * 1.0) / Data.activityInfo.stepGoal;
    // var mod = mod(percent, 1.0);
    // var laps = max(0, toInteger(Math.floor(percent - 0.1)));
    // debugHash({
    //   :steps => Data.activityInfo.steps,
    //   :goal => Data.activityInfo.stepGoal,
    //   :percent => percent,
    //   :mod => mod,
    //   :laps => laps,
    // });
  }
}
