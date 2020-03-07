include <../defaults.scad>;

module two_by_two(length) {
  lumber(two_by_height, two_by_height, length);
}

module one_by_six(length) {
  lumber(one_by_height, six_by_height, length);
}

module one_by_four(length) {
  lumber(one_by_height, four_by_height, length);
}

lumber_radius=0.125;
module lumber(height, width, length) {
  color("BurlyWood")
  hull() {
    // front
    four_half_spheres(height, width);

    // back
    translate([width, length, 0])
      rotate([0, 0, 180])
        four_half_spheres(height, width);
  }
}

module four_half_spheres(height, width) {
  translate([lumber_radius, 0, lumber_radius])
    half_sphere();
  translate([width - lumber_radius, 0, height - lumber_radius])
    half_sphere();
  translate([width - lumber_radius, 0, lumber_radius])
    half_sphere();
  translate([lumber_radius, 0, height - lumber_radius])
    half_sphere();
}

module half_sphere() {
  difference() {
    sphere(r=lumber_radius, $fn=12);
    translate([-0.5, -1, -0.5])
      cube(1);
  }
}
