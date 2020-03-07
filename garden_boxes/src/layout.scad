include <../lib/defaults.scad>;
use <../lib/box.scad>;
use <../lib/garage.scad>;

panel_length = 46;
post_height = 8 * 12;
exploded = true;

module boxes() {
  translate([0, 0, 0])
    box(
      panel_length=frame_length+6,
      post_height=post_height,
      left_endcap=true,
      right_endcap=true,
      exploded=exploded
    );

  translate([8*12+frame_length+6+12, 0, 0]) {
    translate([0, 0, 0])
      box(
        panel_length=panel_length,
        post_height=post_height,
        left_endcap=true,
        exploded=exploded
      );

    translate([panel_length, 0, 0])
      box(
        panel_length=panel_length,
        post_height=post_height/2,
        exploded=exploded
      );

    translate([2*panel_length, 0, 0])
      box(
        panel_length=panel_length,
        post_height=post_height/2,
        exploded=exploded
      );

    translate([3*panel_length, 0, 0])
      box(
        panel_length=panel_length,
        post_height=post_height/2,
        exploded=exploded
      );
  }
}

garage_wall();
translate([6, -(12 + frame_width), 0])
  boxes();
