include <defaults.scad>;
use <panel.scad>;

module right_endcap(width, four_by_count, edge_offset) {
  translate([two_by_height, two_by_height, 0]) {
    rotate([0, 0, 270]) {
      panel(four_by_count, width, cover=true, horizontals=false);

      if (edge_offset > 2 * two_by_height) {
        translate([edge_offset, width-two_by_height, 0])
          rotate([0, 0, 90])
            panel(four_by_count, edge_offset);

        translate([edge_offset, 0, 0])
          rotate([0, 0, 90])
            panel(four_by_count, edge_offset);
      }
    }
  }
}

module left_endcap(width, four_by_count, edge_offset) {
  translate([0, 0, four_by_count * four_by_height])
  rotate([180, 0, 0])
    right_endcap(width, four_by_count, edge_offset);
}

right_endcap(20, 4, edge_offset=6);

translate([-50, 0, 0])
  left_endcap(20, 4, edge_offset=6);
