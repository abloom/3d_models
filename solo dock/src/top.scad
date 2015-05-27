use <shared.scad>;
use <solo.scad>;

module top(base) {
  difference() {
    serial_hull() {
      cone_ring(base, 0);
      cone_ring(3, 13);
    }

    // negative space for solo
    translate([0, 0, 2])
      linear_extrude(16, true)
        solo_bottom();

    // cutout to see charging lights
    translate([-4, 15, 8])
      cube([8, 8, 8]);

    // cutout for power plug
    translate([-6.75, 8, -1])
      cylinder(h=6, d=8, $fn=32);
  }
}

top(10);
