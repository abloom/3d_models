module left_clamp() {
  rotate([90, 0, 90])
    union() {
      difference() {
        cube([20, 17, 15]);

        translate([1.5, 1.5, -1])
          cube([17, 17, 17]);

        translate([-0.25, 16.25, -1])
          cube([1, 1, 17]);

        translate([19.25, 16.25, -1])
          cube([1, 1, 17]);

        translate([12, -0.5, -1])
          cube([13, 19, 10]);
      }

      translate([9.5, 6.5, 2])
        rotate([90, 0, 0])
          cylinder(r=2, h=5);
    }
}

module right_clamp() {
  rotate([90, 0, -90])
    union() {
      difference() {
        cube([20, 17, 15]);

        translate([1.5, 1.5, -1])
          cube([17, 17, 17]);

        translate([0.75, 16.25, -1])
          cube([1, 1, 17]);

        translate([18.25, 16.25, -1])
          cube([1, 1, 17]);

        translate([-2, -0.5, -1])
          cube([10, 19, 10]);
      }

      translate([10.5, 6.5, 2])
        rotate([90, 0, 0])
          cylinder(r=2, h=5);
    }
}

translate([2.5, 0, 0])
  left_clamp();

translate([-2.5, 20, 0])
  right_clamp();
