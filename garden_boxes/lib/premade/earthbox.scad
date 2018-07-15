module earthbox() {
  color("orange")
  hull() {
    translate([0, 0, 11])
      cube(size=[13.5, 29, 1]);

    translate([1, 1, 1])
      cube(size=[11.5, 27, 1]);
  }
}
