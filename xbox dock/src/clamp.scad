WALL_WIDTH = 2;

module zig_zag_wall(inner) {
  linear_extrude(17) {
    union() {
      square([9.5, WALL_WIDTH]);

      translate([0, -4.5, 0])
        square([WALL_WIDTH, 4.5]);

      translate([-8.5, -4.5, 0])
        square([8.5, WALL_WIDTH]);
    }
  }
}

module straight_wall(inner) {
  linear_extrude(17)
    square([18, WALL_WIDTH]);
}

module bottom_wall() {
  union() {
    cube([18, 15.5, WALL_WIDTH]);

    translate([8.5, 15.5])
      cube([9.5, 4.5, WALL_WIDTH]);
  }
}

module peg() {
  cylinder(r=2, h=5, $fn=32);
}

module clamp(inner) {
  difference() {
    union() {
      translate([8.5, 18, 0])
        zig_zag_wall(inner);

      straight_wall(inner);

      bottom_wall();

      translate([7, 7, 2])
        peg();
    }

    translate([32, 7, -1])
      cylinder(r=17, h=19, $fn=64);
  }
}

translate([0, 5, 0])
  clamp(true);

translate([0, -5, 0])
  mirror([0, 1, 0])
    clamp(false);
