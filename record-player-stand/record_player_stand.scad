CIRCLE_SEGMENTS = 32;
BASE_X = 15.25;
BASE_Y = 15;
SCREW_DIAMETER = 1.5;
SCREW_LENGTH = 12;

module rounded_triangle(x, y) {
  resize([x, y, 0])
    linear_extrude(0.1, true) {
      difference() {
        hull() {
          translate([10.25, 0, 0])
            circle(r=6, $fn=CIRCLE_SEGMENTS);

          translate([0, -7.5, 0])
            square([0.1, 15]);
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
        cylinder(r=radius, h=length+2, $fn=CIRCLE_SEGMENTS);
    }
}

module tone_arm_cutout() {
  rotate([90, 0, 0])
    cylinder(r=4, h=15, $fn=CIRCLE_SEGMENTS);

  translate([0, -15, -4])
    cube([8, 15, 8]);
}

module screw_holes() {
  translate([1.75, 4.75, -1])
    cylinder(d=SCREW_DIAMETER, h=SCREW_LENGTH, $fn=CIRCLE_SEGMENTS);

  translate([1.75, -4.75, -1])
    cylinder(d=SCREW_DIAMETER, h=SCREW_LENGTH, $fn=CIRCLE_SEGMENTS);

  translate([13.25, 0, -1])
    cylinder(d=SCREW_DIAMETER, h=SCREW_LENGTH, $fn=CIRCLE_SEGMENTS);
}

module obelisk(wall_thickness, top) {
  hull() {
    rounded_triangle(BASE_X, BASE_Y);

    translate([0, 0, top])
      rounded_triangle(BASE_X - 2, BASE_Y - 4);
  }
}

module stand(cutout_bottom) {
  top = cutout_bottom + 4 + 10;

  difference() {
    obelisk(1.5, top);

    translate([-0.5, -6.5, top+0.6])
      inside_rounded_corner(13, 5);

    translate([8.5, 7.5, cutout_bottom+4])
      tone_arm_cutout();

    screw_holes();
  }
}

stand(50);
