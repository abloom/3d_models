include <../lib/defaults.scad>;
use <../lib/panel.scad>;

module right_endcap(width, four_by_count) {
  translate([two_by_height, two_by_height, 0]) {
    rotate([0, 0, 180]) {
      panel(four_by_count, width, cover=true, horizontals=false);

      translate([two_by_height, width-two_by_height, 0])
        rotate([0, 0, 90])
          panel(four_by_count, edge_offset-two_by_height);

      translate([two_by_height, 0, 0])
        rotate([0, 0, 90])
          panel(four_by_count, edge_offset-two_by_height);
    }
  }
}

module left_endcap(width, four_by_count) {
  translate([0, 0, four_by_count * four_by_height])
  rotate([0, 180, 0])
    right_endcap(width, four_by_count);
}

right_endcap(20, 4);

translate([-50, 0, 0])
  left_endcap(20, 4);
