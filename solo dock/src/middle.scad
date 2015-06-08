include <defaults.scad>;
use <shapes.scad>;
use <screws.scad>;
use <corner_pads.scad>;
use <solo.scad>;

module middle(pads, top_screws = true) {
  rotate([0, 0, 90])
    difference() {
      serial_hull() {
        cone_ring(bottom_width, 0);
        cone_ring(middle_width, middle_height);
      }

      translate([-6.75, 8, -1])
        power_plug(middle_height + 2);

      translate([0, 0, -1])
        wire_run(middle_height + 2);

      translate([0, -13, middle_height/2])
        jack_mount();

      if (top_screws) {
        rotate([180, 0, 0])
          narrow_screws(-middle_height - 2);
      }

      wide_screws(-2);
    }

  if (pads) large_corner_pads();
}

module jack_mount() {
  union() {
    // jack recess
    translate([0, -7, 0])
      rotate([90, 0, 0])
        cylinder(h=8, d=10.5, $fn=32);

    // small hole through the body
    translate([0, -4, 0])
      rotate([90, 0, 0])
        cylinder(h=4, d=7.8, $fn=32);
  }
}

module power_plug(height) {
  union() {
    // threaded section
    rotate([0, 0, -90])
      cylinder(d=7.15, h=height, $fn=32);

    // wider opening for the ring on the plug
    translate([0, 0, height-2])
      rotate([0, 0, -90])
        cylinder(d=8, h=2, $fn=32);
  }
}

module wire_run(height) {
  covered_height = height - 7;

  // covered space
  translate([-6.75, 4, 0])
    cube([10, 8, covered_height]);
  translate([2.5, 4.5, 0])
    rotate([0, 0, 180])
      inside_rounded_corner(covered_height);

  // open space
  translate([6.5, 3, 0])
    rounded_rect([8, 17, height], 1);
  translate([-0.5, -10, 0])
    rounded_rect([21, 14, height], 2);
  translate([2.5, -2.5, 0])
    rotate([0, 0, 90])
      inside_rounded_corner(height);
}

middle(true);
