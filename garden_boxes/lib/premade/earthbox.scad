include <../defaults.scad>;

module earthbox() {
  color("orange")
  translate([0, 0, -1])
    hull() {
      translate([0, 0, earthbox_height])
        cube(size=[earthbox_length, earthbox_width, 1]);

      translate([1, 1, 1])
        cube(size=[earthbox_length-2, earthbox_width-2, 1]);
    }
}
