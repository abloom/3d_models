include <../lib/defaults.scad>;
use <../lib/box.scad>

panel_length = 36;
post_height = 8 * 12;


translate([-(8*12)-frame_length, 0, 0])
  box(
    panel_length=panel_length,
    post_height=post_height,
    left_endcap=true,
    right_endcap=true,
    exploded=true
  );

translate([0, 0, 0])
  box(
    panel_length=panel_length,
    post_height=post_height,
    left_endcap=true,
    exploded=true
  );

translate([frame_length+6, 0, 0])
  box(
    panel_length=panel_length,
    post_height=post_height/2,
    exploded=true
  );

translate([2*(frame_length+6), 0, 0])
  box(
    panel_length=panel_length,
    post_height=post_height/2,
    exploded=true
  );

translate([3*(frame_length+6), 0, 0])
  box(
    panel_length=panel_length,
    post_height=post_height/2,
    right_endcap=true,
    exploded=true
  );
