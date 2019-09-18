include <../defaults.scad>;

module earthbox() {
  color("orange")
  hull() {
    translate([0, 0, 11])
      cube(size=[earthbox_width, earthbox_length, 1]);

    translate([1, 1, 1])
      cube(size=[earthbox_width-2, earthbox_length-2, 1]);
  }
}
