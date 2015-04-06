use <shared.scad>;
use <plug.scad>;

solo_width = 44.5;
solo_depth = 37;

module solo_bottom() {
  half_width = solo_width/2;
  half_depth = solo_depth/2;

  difference() {
    circle(24, $fn=128);

    // round edges - width
    translate([-20, -1*(half_depth+10), 0])
      square([40, 10]);
    translate([-20, half_depth, 0])
      square([40, 10]);

    // round edges - depth
    translate([half_width, -10, 0])
      square([10, 20]);
    translate([-1*(half_width+10), -10, 0])
      square([10, 20]);
  }
}

module resized_bottom(extra) {
  resize([extra+ solo_width, extra+ solo_depth, 0])
    solo_bottom();
}

module tangent_cone_ring(resize_base, height, total_height) {
  angle = 80 * (height / total_height);
  test_width = (total_height / 1.5) * tan(angle);
  width = (resize_base - test_width < 2) ? resize_base - 2 : test_width;

  cone_ring(resize_base - width, height);
}

module sine_cone_ring(resize_base, height, total_height) {
  angle = 45 * (height / total_height) + 0;
  width = (resize_base-2) * sin(angle) + 2;

  cone_ring(width, height);
}

module cone_ring(resize_base, height) {
  translate([0, 0, height])
    linear_extrude(0.1, true)
      resized_bottom(resize_base);
}

module rounded_foot() {
  difference() {
    rounded_rect([12, 12, 2], 4);

    translate([1.5, 1.5, -1])
      rounded_rect([12, 12, 4], 4);

    translate([0, -9, -1])
      cube([10, 4, 4]);

    translate([-9, 0, -1])
      cube([4, 10, 4]);
  }

}

module cone(resize_base) {
  union() {
    // foot
    linear_extrude(2, true) {
      difference() {
        resized_bottom(resize_base);
        resized_bottom(resize_base-3);
      }
    }

    // curved extrusion on the right foot near the power jack
    translate([14, -26.5, 0])
      rounded_foot();

    // curved extrusion on the left foot near the power jack
    translate([-14, -26.5, 0])
      rotate([0, 0, 90])
        rounded_foot();

    // square feet under the power jack
    translate([0, -27.5, 0])
      rounded_rect([13, 4, 2], 2);

    // curvey profile
    translate([0, 0, 2])
      serial_hull() {
        cone_ring(resize_base, 0);
        cone_ring(resize_base*(3/5), 4);
        cone_ring(resize_base*(2/5), 8);
        cone_ring(resize_base*(1/5), 12);
        cone_ring(resize_base*(0.5/5), 16);
        cone_ring(2, 19);
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
        cube([7, 8, 6]);

        translate([0, 4, -1])
          rounded_rect([3, 4, 8], 2);

        translate([7, 4, -1])
          rounded_rect([3, 4, 8], 2);
      }

    // negative space for solo
    translate([0, 0, 16])
      linear_extrude(16, true)
        solo_bottom();

    negative_power_assembly();
  }
}

