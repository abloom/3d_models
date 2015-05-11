use <shared.scad>;
use <plug.scad>;

solo_width = 44.5;
solo_depth = 37;

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

module cone_ring(resize_base, z, height=0.1) {
  translate([0, 0, z])
    linear_extrude(height, true)
      resized_bottom(resize_base);
}

module cone(resize_base) {
  resize_base = 32;
  curve_factor = 10;

  union() {
    // curvey profile
    serial_hull() {
      cone_ring(resize_base, 0);
      cone_ring(resize_base*(8/curve_factor), 4);
      cone_ring(resize_base*(4/curve_factor), 4*2);
      cone_ring(resize_base*(2/curve_factor), 4*3);
      cone_ring(resize_base*(1/curve_factor), 4*4);
      cone_ring(2, 20, 9);
    }

    // power jack tube
    difference() {
      translate([0, -22.5, 4.5])
        rotate([90, 0, 0])
          cylinder(h=8, d=10.5, $fn=32);

      translate([-5, -31.5, -2])
        cube([10, 10, 2]);
    }
  }
}

module power_jack_cutaway(extra_width=0) {
  radius = 4;
  widta = 10.5 + extra_width;
  total_width = width + (radius * 2);
  offset = (width-10.5) / 2;

  translate([-9.25-offset, -35.5, -1])
    difference() {
      cube([total_width, 5, 10]);

      translate([0, 5, -1])
        cylinder(r=radius, h=12, $fn=32);

      translate([total_width, 5, -1])
        cylinder(r=radius, h=12, $fn=32);
    }
}

module base() {
  difference() {
    cone();

    power_jack_cutaway();

    // slots to position foot ring
    translate([0, 0, -2])
      foot_ring();

    // negative space for solo
    translate([0, 0, 14])
      linear_extrude(16, true)
        solo_bottom();

    // cutout to see charging lights
    translate([-4, 15, 22])
      cube([8, 8, 8]);

    translate([0, 0, -2])
      negative_power_assembly();
  }
}

module cone_ring_with_cutaway(outer, inner, height) {
  outer_diff = 32 - outer;
  inner_diff = 32 - inner;

  difference() {
    cone_ring(outer, 0, height);

    translate([0, outer_diff/2, 0])
      power_jack_cutaway(outer_diff);

    translate([0, 0, -1])
      difference() {
        cone_ring(inner, 0, height+2);

        translate([0, inner_diff/2, 0])
          power_jack_cutaway(inner_diff);
      }
  }
}

module foot_ring() {
  union() {
    // actual foot
    cone_ring_with_cutaway(32, 28, 2);

    // tabs to line up with base
    translate([0, 0, 2])
      difference() {
        cone_ring_with_cutaway(29, 28, 1);

        // remove the outer rounded corners
        translate([35, 25, 0])
          cube([25, 25, 3], center=true);
        translate([-35, 25, 0])
          cube([25, 25, 3], center=true);
        translate([35, -25, 0])
          cube([25, 25, 3], center=true);
        translate([-35, -25, 0])
          cube([25, 25, 3], center=true);

        // remove the rounded corners and the power jack
        translate([0, -30, 0])
          cube([22, 10, 3], center=true);
      }
  }
}

translate([0, 0, 2])
  base();

foot_ring();
