include <defaults.scad>;
use <shapes.scad>;
use <screws.scad>;
use <corner_pads.scad>;
use <solo.scad>;

module top(pads, screws = true) {
  rotate([0, 0, 90])
    difference() {
      serial_hull() {
        cone_ring(middle_width, 0);
        cone_ring(middle_width - 2, 1);
        cone_ring(top_width, top_height);
      }

      // negative space for solo
      translate([0, 0, 2])
        linear_extrude(top_height, true)
          solo_bottom();

      // cutout for power plug
      translate([-6.75, 8, -1])
        cylinder(d=8, h=4, $fn=32);

      // cutout to see charging lights
      translate([-4, 15, 8])
        cube([8, 8, top_height]);

      if (screws) {
        rotate([180, 0, 0])
          narrow_screws(-2.1);
      }
    }

  if (pads) small_corner_pads();
}

top(true);
