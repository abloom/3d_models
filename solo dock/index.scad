include <lib/defaults.scad>;
use <src/top.scad>;
use <src/middle.scad>;
use <src/bottom.scad>;
use <src/combined_top.scad>;

module offset() {
  translate([0, 70, 0])
    top(true);

  translate([0, 0, 0])
    middle(true);

  translate([0, -70, 0])
    bottom(true);
}

module assembled() {
  translate([0, 0, bottom_height + middle_height])
    top();

  translate([0, 0, bottom_height])
    middle();

  translate([0, 0, bottom_height])
    rotate([180, 0, 0])
      bottom();
}

translate([50, 0, 0])
  offset();

translate([-50, 0, 0])
  assembled();

translate([150, 0, 0])
  combined_top(true);
