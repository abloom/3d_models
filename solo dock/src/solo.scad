include <defaults.scad>;

module solo_bottom() {
  half_width = solo_width/2;
  half_depth = solo_depth/2;

  difference() {
    circle(r=24, $fn=128);

    // round edges - width
    translate([-20, (-half_depth-10), 0])
      square([40, 10]);
    translate([-20, half_depth, 0])
      square([40, 10]);

    // round edges - depth
    translate([half_width, -10, 0])
      square([10, 20]);
    translate([(-half_width-10), -10, 0])
      square([10, 20]);
  }
}

module resized_bottom(extra) {
  resize([extra+solo_width, extra+solo_depth, 0])
    solo_bottom();
}

module cone_ring(resize_base, z, height=0.01) {
  translate([0, 0, z])
    linear_extrude(height, true)
      resized_bottom(resize_base);
}

