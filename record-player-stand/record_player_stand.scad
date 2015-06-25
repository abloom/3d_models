CIRCLE_SEGMENTS = 32;

module rounded_triangle() {
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

module scaled_rounded_triangle(x, y) {
  scale([x, y, 1])
    rounded_triangle();
}

module resized_rounded_triangle(x, y) {
  resize([x, y, 0])
    rounded_triangle();
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

module stand(cutout_bottom) {
  top = cutout_bottom + 4 + 10;

  difference() {
    hull() {
      rounded_triangle();

        translate([0, 0, top])
          resized_rounded_triangle(13, 11);
    }

    translate([-0.5, -6.5, cutout_bottom+4+10+0.6])
      inside_rounded_corner(13, 5);

    translate([7.75, 7.5, cutout_bottom+4])
      tone_arm_cutout();

    translate([-0.1, 0, 0])
      hull() {
        translate([0, 0, 12])
          resized_rounded_triangle(13, 11.25);
          /*scaled_rounded_triangle(0.8, 0.8, 1);*/

        translate([0, 0, top+0.1])
          resized_rounded_triangle(11, 9);
          /*scaled_rounded_triangle(0.8, 0.8, 1);*/
      }

    screw_holes();
  }
}

stand(40);
