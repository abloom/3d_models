include <../lib/defaults.scad>;
use <../lib/lumber.scad>;
use <../lib/panel.scad>;
use <../lib/earthbox.scad>;
use <../lib/fence_post.scad>;

foot_depth=8;
edge_offset=6;

module box(length, width, four_by_count, fence_height) {
  //////
  // wood frame
  //////

  // front
  panel(four_by_count, length, cover=true, edge_offset=edge_offset, horizontals=false);

  color("purple") {
    // left side
    translate([two_by_height, edge_offset-two_by_height, 0])
      rotate([0, 0, 90])
        panel(four_by_count, width);

    // right side
    translate([two_by_height, length-edge_offset, 0])
      rotate([0, 0, 90])
        panel(four_by_count, width);

    // back
    translate([-width + two_by_height, 0, 0])
      panel(four_by_count, length, edge_offset=edge_offset, verticals=false);
  }

  //////
  // fence posts
  //////

  // front left
  translate([-two_by_height-1, edge_offset, 0])
    fence_post(fence_height, foot_depth);

  // back left
  translate([-width+two_by_height+2.5, edge_offset, 0])
    fence_post(fence_height, foot_depth);

  // front right
  translate([-two_by_height-1, length-edge_offset-0.25, 0])
    fence_post(fence_height, foot_depth);

  // back right
  translate([-width+two_by_height+2.5, length-edge_offset-0.25, 0])
    fence_post(fence_height, foot_depth);
}

box(48, 20, 4, 5*12);

translate([-15, 9.5, 0])
  earthbox();
