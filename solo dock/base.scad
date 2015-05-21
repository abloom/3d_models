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
    cone_ring(resize_base, 0, 2);

    translate([0, 0, 2])
      serial_hull() {
        cone_ring(resize_base, 4*0);
        cone_ring(resize_base*(8/curve_factor), 4*1);
        cone_ring(resize_base*(4/curve_factor), 4*2);
        cone_ring(resize_base*(2/curve_factor), 4*3);
        cone_ring(resize_base*(1/curve_factor), 4*4);
        cone_ring(2, 20, 7);
      }

    // power jack tube
    translate([0, -22.5, 5.25])
      rotate([90, 0, 0])
        cylinder(h=10, d=10.5, $fn=32);

  }
}

module power_jack_cutaway() {
  radius = 4;
  width = 10.25;
  total_width = width + (radius * 2);

  translate([-total_width/2, -35.5, -1])
    difference() {
      cube([total_width, 5, 15]);

      translate([0, 5, -1])
        cylinder(r=radius, h=12, $fn=32);

      translate([total_width, 5, -1])
        cylinder(r=radius, h=12, $fn=32);
    }
}

module negative_silicone_foot(height) {
  union() {
    translate([5, 0, 0])
      cylinder(h=height, d=10, $fn=32);

    cube([10, 30, height]);

    translate([5, 30, 0])
      cylinder(h=height, d=10, $fn=32);
  }
}

module negative_silicone_feet() {
  height=2;

  union() {
    translate([15, -15, -1])
      negative_silicone_foot(height);

    translate([-25, -15, -1])
      negative_silicone_foot(height);
  }
}

module base() {
  difference() {
    cone();

    power_jack_cutaway();

    // negative space for solo
    translate([0, 0, 16])
      linear_extrude(16, true)
        solo_bottom();

    // cutout to see charging lights
    translate([-4, 15, 22])
      cube([8, 8, 8]);

    negative_power_assembly();

    negative_silicone_feet();
  }
}

base();
