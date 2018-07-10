include <../lib/defaults.scad>;
use <../lib/lumber.scad>;
use <../lib/panel.scad>;

foot_depth=8;
edge_offset=6;

module box(length, width, four_by_count) {
  // front
  panel(four_by_count, length, cover=true, edge_offset=edge_offset, horizontals=false);

  color("purple") {
    // left side
    translate([two_by_height, edge_offset-two_by_height, 0])
      rotate([0, 0, 90])
        panel(four_by_count, width, foot_depth=foot_depth);

    // right side
    translate([two_by_height, length-edge_offset, 0])
      rotate([0, 0, 90])
        panel(four_by_count, width, foot_depth=foot_depth);

    // back
    translate([-width + two_by_height, 0, 0])
      panel(four_by_count, length, edge_offset=edge_offset, verticals=false);
  }
}

box(48, 20, 4);
