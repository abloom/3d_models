include <defaults.scad>;
use <shapes.scad>;
use <screws.scad>;
use <corner_pads.scad>;
use <solo.scad>;

module bottom(pads) {
  translate([0, 0, 3.5])
    rotate([180, 0, 90])
        difference() {
          serial_hull() {
            cone_ring(bottom_width - 2, 0);
            cone_ring(bottom_width, bottom_height);
          }

        // rubber pad cutaway
        translate([0, 0, -1])
          cone_ring(bottom_width - 5, 0, 2.5);

        wide_screws(1.49);
      }

  if (pads) large_corner_pads();
}

bottom(true);
