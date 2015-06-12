include <../lib/defaults.scad>;
use <top.scad>;
use <middle.scad>;

module combined_top(pads) {
  union() {
    middle(pads, false);

    translate([0, 0, middle_height])
      top(false, false);
  }
}

combined_top(true);
