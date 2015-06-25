CIRCLE_SEGMENTS = 32;
BASE_X = 15.25;
BASE_Y = 15;

module rounded_triangle(x, y) {
  resize([x, y, 0])
    linear_extrude(0.1, true) {
      difference() {
        hull() {
          translate([10.25, 0, 0])
            circle(r=5, $fn=CIRCLE_SEGMENTS);

          translate([0, 5, 0])
            circle(r=2.5, $fn=CIRCLE_SEGMENTS);

          translate([0, -5, 0])
            circle(r=2.5, $fn=CIRCLE_SEGMENTS);
        }

        translate([-5, -7.5, 0])
          square([5, 15]);
      }
    }
  }

module inside_rounded_corner(length, radius=1) {
  padded = radius + 0.5;

  rotate([-90, 0, 0])
    difference() {
      cube([padded, padded, length]);

      translate([padded, padded, -1])
        cylinder(r=radius, h=length+2, $fn=32);
    }
}

module tone_arm_cutout() {
  rotate([90, 0, 0])
    cylinder(r=4, h=15, $fn=CIRCLE_SEGMENTS);

  translate([0, -15, -4])
    cube([12, 15, 8]);
}

module screw_holes() {
  translate([1.75, 4.75, -1])
    cylinder(r=0.75, h=12, $fn=CIRCLE_SEGMENTS);

  translate([1.75, -4.75, -1])
    cylinder(r=0.75, h=12, $fn=CIRCLE_SEGMENTS);

  translate([13.25, 0, -1])
    cylinder(r=0.75, h=12, $fn=CIRCLE_SEGMENTS);
}

module obelisk(wall_thickness, top) {
  difference() {
    hull() {
      rounded_triangle(BASE_X, BASE_Y);

      translate([0, 0, top])
        rounded_triangle(BASE_X - 2, BASE_Y - 4);
    }

    difference() {
      translate([-0.1, 0, 0.1])
        hull() {
          rounded_triangle(BASE_X - wall_thickness, BASE_Y - (wall_thickness * 2));

          translate([0, 0, top])
            rounded_triangle(BASE_X - 2 - wall_thickness, BASE_Y - 4 - (wall_thickness * 2));
        }

      translate([0, -BASE_Y/2, 0])
        cube([BASE_X+0.1, BASE_Y+0.1, 15]);
    }
  }
}

module stand(cutout_bottom) {
  top = cutout_bottom + 4 + 10;

  difference() {
    obelisk(1.5, top);

    translate([-0.5, -6.5, top+0.6])
      inside_rounded_corner(13, 5);

    translate([7.75, 7.5, cutout_bottom+4])
      tone_arm_cutout();

    screw_holes();
  }
}

stand(40);
