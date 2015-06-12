include <defaults.scad>;

module narrow_screws(z, size) {
  screws(19, 7, 12, 15, z);
}

module wide_screws(z, size) {
  screws(22.5, 9, 10, 18.5, z);
}

module screw(head_diameter, head_depth, shaft_diameter) {
  union() {
    cylinder(d1=head_diameter, d2=shaft_diameter + 0.6, h=head_depth + 0.4, $fn=32);

    translate([0, 0, head_depth])
      cylinder(d=shaft_diameter, h=14-head_depth, $fn=32);
  }
}

module screws(x1, y1, x2, y2, z) {
  for(x = [-x1, x1]) {
    for(y = [-y1, y1]) {
      translate([x, y, z])
        screw(6, 2, 2.25);
    }
  }

  for(x = [-x2, x2]) {
    for(y = [-y2, y2]) {
      translate([x, y, z])
        screw(6, 2, 2.25);
    }
  }
}
