include <defaults.scad>;
use <top.scad>;
use <middle.scad>;

module other_top(pads) {
  union() {
    middle(pads, false);

    translate([0, 0, middle_height])
      top(false, false);
  }
}

other_top(true);
