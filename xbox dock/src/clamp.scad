module clamp(move) {
  rotate([90, 0, 90])
    union() {
      difference() {
        cube([20, 17, 13]);

        translate([1.5, 1.5, -1])
          cube([17, 17, 17]);

        translate([12, -0.5, -1])
          cube([11, 19, 8]);

        // large rail
        translate([-0.25+move, 16.25, -1])
          cube([1, 1, 17]);

        // small rail
        translate([19.25-move, 16.25, -1])
          cube([1, 1, 17]);
      }

      translate([8, 6.5, 2])
        rotate([90, 0, 0])
          cylinder(r=2, h=5);
    }
}

translate([0, 5, 0])
clamp(0);

translate([0, -5, 0])
  mirror([0, 1, 0])
    clamp(1);
