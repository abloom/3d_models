use <shared.scad>;
use <plug.scad>;

solo_width = 44.5;
solo_depth = 37;

module solo_bottom() {
  half_width = solo_width/2;
  half_depth = solo_depth/2;

  difference() {
    circle(24, $fn=128);

    // round edges - width
    translate([-20, -1*(half_depth+10), 0])
      square([40, 10]);
    translate([-20, half_depth, 0])
      square([40, 10]);

    // round edges - depth
    translate([half_width, -10, 0])
      square([10, 20]);
    translate([-1*(half_width+10), -10, 0])
      square([10, 20]);
  }
}

module resized_bottom(extra) {
  resize([extra+ solo_width, extra+ solo_depth, 0])
    solo_bottom();
}

module cone() {
  union() {
    // angled bottom
    serial_hull() {
      linear_extrude(3, true)
        resized_bottom(32);

      translate([0, 0, 9])
        linear_extrude(0.1, true)
          resized_bottom(12);

      translate([0, 0, 13])
        linear_extrude(0.1, true)
          resized_bottom(6);

      translate([0, 0, 16])
        linear_extrude(0.1, true)
          resized_bottom(3);

      translate([0, 0, 18])
        linear_extrude(0.1, true)
          resized_bottom(2);
    }

    // vertical walls
    translate([0, 0, 17])
      linear_extrude(10, true)
        resized_bottom(2);

    // power jack
    translate([-6, -34.5, 0])
      cube([12, 12, 12]);
  }
}

module base() {
  difference() {
    cone();

    // negative space for solo
    translate([0, 0, 14])
      linear_extrude(14, true)
        solo_bottom();

    negative_power_assembly();
  }
}

