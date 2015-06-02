use <shared.scad>;
use <solo.scad>;

module middle(base) {
  extra = base - 3;
  middle_height = 13;
  bumper_height = middle_height + 2;

  difference() {
    serial_hull() {
      cone_ring(base + extra, 0);
      cone_ring(base, middle_height);
    }

    union() {
      translate([-6.75, 8, -1])
        negative_power_plug(bumper_height);

      translate([0, 0, -1])
        negative_wire_run(bumper_height);

      translate([0, -13, middle_height/2])
        negative_jack_mount();
    }
  }
}

module negative_jack_mount() {
  union() {
    // jack recess
    translate([0, -8, 0])
      rotate([90, 0, 0])
        cylinder(h=8, d=10.5, $fn=32);

    // small hole through the body
    translate([0, -5, 0])
      rotate([90, 0, 0])
        cylinder(h=4, d=7.7, $fn=32);
  }
}

module negative_power_plug(height) {
  // nut cutout
  translate([0, 0, height-7])
    rotate([0, 0, -90])
      cylinder(d=15.5, h=7.5, $fn=6);

  // round cutout below
  rotate([0, 0, -90])
    cylinder(d=8, h=height, $fn=32);
}

module inside_rounded_corner(height) {
  difference() {
    cube([1.5, 1.5, height]);

    translate([1.5, 1.5, -1])
      cylinder(r=1, h=height+2, $fn=32);
  }
}

module negative_wire_run(height) {
  covered_height = height - 9;

  // covered space
  translate([-6.75, 4, 0])
    cube([10, 8, covered_height]);
  translate([2.5, 4.5, 0])
    rotate([0, 0, 180])
      inside_rounded_corner(covered_height);

  // open space
  translate([7, 3, 0])
    rounded_rect([9, 17, height], 1);
  translate([0, -10.5, 0])
    rounded_rect([22, 15, height], 2);
  translate([2.5, -2.5, 0])
    rotate([0, 0, 90])
      inside_rounded_corner(height);
}

middle(10);
