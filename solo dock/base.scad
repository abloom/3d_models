use <shared.scad>;
use <plug.scad>;

solo_width = 44.5;
solo_depth = 37;

module solo_bottom() {
  half_width = solo_width/2;
  half_depth = solo_depth/2;

  difference() {
    circle(r=24, $fn=128);

    // round edges - width
    translate([-20, (-half_depth-10), 0])
      square([40, 10]);
    translate([-20, half_depth, 0])
      square([40, 10]);

    // round edges - depth
    translate([half_width, -10, 0])
      square([10, 20]);
    translate([(-half_width-10), -10, 0])
      square([10, 20]);
  }
}

module rounded_solo_bottom() {
  difference() {
    solo_bottom();

    wide_rounded_solo_bottom_corner();
    rotate([0, 0, 180])
      wide_rounded_solo_bottom_corner();
    mirror([1, 0, 0])
      wide_rounded_solo_bottom_corner();
    mirror([0, 1, 0])
      wide_rounded_solo_bottom_corner();
  }
}

module wide_rounded_solo_bottom_corner() {
  difference() {
    circle(r=24, $fn=128);

    translate([5, 5, 0])
      circle(r=24, $fn=128);

    translate([-27, -30, 0])
      square([30, 60]);
  }
}

module resized_bottom(extra) {
  resize([extra+solo_width, extra+solo_depth, 0])
    solo_bottom();
}


module rounded_resized_bottom(extra) {
  resize([extra+solo_width, extra+solo_depth, 0])
    rounded_solo_bottom();
}

module cone_ring(resize_base, height) {
  translate([0, 0, height])
    linear_extrude(0.1, true)
      resized_bottom(resize_base);
}

module rounded_cone_ring(resize_base, height) {
  translate([0, 0, height])
    linear_extrude(0.1, true)
      rounded_resized_bottom(resize_base);
}

module rounded_foot(foot_width) {
  difference() {
    rounded_rect([12, 12, 2], 4);

    translate([foot_width-0.25, foot_width-0.25, -1])
      rounded_rect([12, 12, 4], 4);

    translate([-3.5, -9, -1])
      cube([12, 4, 4]);

    translate([-9, -3.5, -1])
      cube([4, 12, 4]);
  }
}

module cone(resize_base) {
  curve_factor = 10;
  foot_width = 6;

  union() {
    // foot
    linear_extrude(2, true) {
      difference() {
        rounded_resized_bottom(resize_base);
        rounded_resized_bottom(resize_base-(foot_width*2));
      }
    }

    // thin rounded feet under the power jack
    translate([0, -29.5, 0])
      rounded_rect([11.5+(2*foot_width), 1.5, 2], 0.5);

    // curvey profile
    translate([0, 0, 2])
      serial_hull() {
        rounded_cone_ring(resize_base, 0);
        rounded_cone_ring(resize_base*(8/curve_factor), 4);
        cone_ring(resize_base*(4/curve_factor), 4*2);
        cone_ring(resize_base*(2/curve_factor), 4*3);
        cone_ring(resize_base*(1/curve_factor), 4*4);
        cone_ring(2, 20);
        cone_ring(2, 29);
      }

    // power jack
    translate([0, -22.5, 6])
      rotate([90, 0, 0])
        cylinder(h=8, d=12);
  }
}

module base() {
  difference() {
    cone(32);

    // negative space for power jack
    translate([0, -30.5, 6])
      rotate([90, 0, 0])
        cylinder(h=9, d=12);

    // rounded outer edges near the power jack
    translate([-10, -35.5, -1])
      difference() {
        cube([20, 5, 7]);

        translate([0, 5, -1])
          cylinder(r=4, h=9, $fn=32);

        translate([20, 5, -1])
          cylinder(r=4, h=9, $fn=32);
      }

    // rounded feet/hex nut edges
    translate([-3.5, -31.5, -1])
      difference() {
        cube([7, 4, 6]);

        translate([0, 2, -1])
          rounded_rect([3, 1, 8], 1);

        translate([7, 2, -1])
          rounded_rect([3, 1, 8], 1);
      }

    // negative space for solo
    translate([0, 0, 16])
      linear_extrude(16, true)
        solo_bottom();

    negative_power_assembly();
  }
}

