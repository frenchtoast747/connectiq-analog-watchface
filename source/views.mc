using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Math as Math;

class View extends Ui.View{
    var background;
    var center_x;
    var center_y;
    var minute_radius;
    var hour_radius;
    var TWO_PI = 2 * Math.PI;
    // noon starts at the top, not the
    // 3 o'clock position. factor in this
    // adjustment of 90 degrees
    var ANGLE_ADJUST = Math.PI / 2.0;

    //! Load your resources here
    function onLayout(dc) {
        background = Ui.loadResource(Rez.Drawables.background);
        // calculate these once since the watch's screen will
        // hopefully not change size
        center_x = dc.getWidth() / 2;
        center_y = dc.getHeight() / 2;
        var smallest;
        if(center_x < center_y){
            smallest = center_x;
        }
        else{
            smallest = center_y;
        }
        // use the smaller dimension to determine the hand sizes
        minute_radius = 7/8.0 * smallest;
        // I want the hour hand to be 2/3 of the minute hand
        hour_radius = 2/3.0 * minute_radius;
        minute_radius = 7/8.0 * smallest;
        // I want the hour hand to be 2/3 of the minute hand
        hour_radius = 2/3.0 * minute_radius;
    }

    function onUpdate(dc) {
        // Set background image
        dc.drawBitmap(0, 0, background);
        var now = Sys.getClockTime();
        var hour = now.hour;
        var minute = now.min;

        // what part of the hour is this?
        var hour_fraction = minute / 60.0;
        var minute_angle = hour_fraction * TWO_PI;
        var hour_angle = (((hour % 12) / 12.0) + (hour_fraction / 12.0)) * TWO_PI;

        // compensate the starting position
        minute_angle -= ANGLE_ADJUST;
        hour_angle -= ANGLE_ADJUST;

        // draw the minute hand
        dc.drawLine(center_x, center_y,
            (center_x + minute_radius * Math.cos(minute_angle)),
            (center_y + minute_radius * Math.sin(minute_angle)));
        // draw the hour hand
        dc.drawLine(center_x, center_y,
            (center_x + hour_radius * Math.cos(hour_angle)),
            (center_y + hour_radius * Math.sin(hour_angle)));
    }
}
