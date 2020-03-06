module TwistedCube(x, y, z, twist, corner_radius) {
  linear_extrude(height = z, twist = twist, $fa = 1, $fs = 0.5)
    rounded_square([x, y], corner_radius = corner_radius, center = true);
}

module RoundedCube(x, y, z, corner_radius) {
  linear_extrude(height = z, twist = 0)
    rounded_square([x, y], corner_radius = corner_radius, center = true);
}

module fillet(r, h) {
  translate([r / 2, r / 2, 0])
    difference() {
      cube([r + 0.01, r + 0.01, h], center = true);

      translate([r/2, r/2, 0])
        cylinder(r = r, h = h + 1, center = true);
  }
}

module rounded_square(dimensions, corner_radius = 10, center = false) {
  x = dimensions[0];
  y = dimensions[1];

  if (center) {
    translate([-x/2, -y/2, 0])
      _rounded_square(dimensions, corner_radius);
  } else {
    _rounded_square(dimensions, corner_radius);
  }
}

module _rounded_square(dimensions, corner_radius) {
  x = dimensions[0];
  y = dimensions[1];

  difference() {
    square(dimensions);
    projection(cut = true)
      fillet(r = corner_radius, h = 1);
    translate([x, 0, 0])
      rotate([0, 0, 90])
        projection(cut = true)
          fillet(r = corner_radius, h = 1);
    translate([x, y, 0])
      rotate([0, 0, 180])
        projection(cut = true)
          fillet(r = corner_radius, h = 1);
    translate([0, y, 0])
      rotate([0, 0, 270])
        projection(cut = true)
          fillet(r = corner_radius, h = 1);
  }
}

module AngledCube(left_x, left_z, right_x, right_z, y) {
  hull() {
    cube([left_x, 1, left_z]);

    translate([0, y, 0])
      cube([right_x, 1, right_z]);
  }
}

module Wedge(twisted_cube, height, rotation, twist, corner_radius, thickness = 30) {
  x = twisted_cube[0];
  y = twisted_cube[1];
  z = twisted_cube[2];
  reduced_y = y;

  intersection() {
    TwistedCube(x=x, y=y, z=z, twist=twist, corner_radius=corner_radius);
    rotate([0, 0, rotation]) {
      translate([-x, -y/35, height]) {
        AngledCube(left_x=x*2, left_z=0.1, right_x=x*2, right_z=thickness/2, y=reduced_y);
        mirror([0, 0, 1])
          AngledCube(left_x=x*2, left_z=0.1, right_x=x*2, right_z=thickness/2, y=reduced_y);
      }
    }
  }
}

module DiceTower(x, y, z, wall_thickness=2, twist=180, corner_radius=10) {
  union() {
    difference() {
      TwistedCube(x=x, y=y, z=z, twist=twist, corner_radius=corner_radius);
      TwistedCube(x=x-wall_thickness, y=y-wall_thickness, z=z, twist=twist, corner_radius=corner_radius);

      // cutout the top
      translate([0, 0, z-0.1])
        RoundedCube(x-wall_thickness, y-wall_thickness, 1, corner_radius);

      // cutout the bottom
      translate([0, 0, -0.9])
        RoundedCube(x-wall_thickness, y-wall_thickness, 1, corner_radius);
    }

    for(i = [1:3])
      Wedge(twisted_cube = [x, y, z], height = z/4*i, rotation = 135 * i, twist = twist, corner_radius = corner_radius);
  }
}

DiceTower(x=60, y=60, z=145, wall_thickness=3, corner_radius=7.5);
