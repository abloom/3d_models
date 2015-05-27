use <shared.scad>;

module negative_jack_mount() {
  union() {
    // jack recess
    translate([0, -6, 0])
      rotate([90, 0, 0])
        cylinder(h=10, d=10.5, $fn=32);

    // small hole through the body
    rotate([90, 0, 0])
      cylinder(h=15, d=7.7, $fn=32);
  }
}

module negative_power_plug(height) {
  translate([0, 0, height-5.5])
    rotate([0, 0, -90])
      cylinder(d=14.6, h=7,5, $fn=6);

  rotate([0, 0, -90])
    cylinder(d=7.75, h=height, $fn=32);
}

module inside_rounded_corner(height) {
  difference() {
    cube([1.5, 1.5, height]);

    translate([1.5, 1.5, -1])
      cylinder(r=1, h=height+2, $fn=32);
  }
}

module negative_wire_run(height) {
  translate([3.75, 2.5, 0])
    rounded_rect([11.5, 15, height-6.5], 1);

  translate([-5, 5.5, 0])
    cube([10.5, 5, height-6.5]);

  translate([0, -9.5, 0])
    rounded_rect([18, 12, height], 2);

  translate([-2, -3, 0])
    rotate([0, 0, 90])
      inside_rounded_corner(height-6.5);

  translate([-2, 6, 0])
    rotate([0, 0, 180])
      inside_rounded_corner(height-6.5);
}

module negative_power_assembly(middle_height) {
  middle = middle_height / 2;
  height = middle_height + 2;

  union() {
    translate([-6.75, 8, -1])
      negative_power_plug(height);

    translate([0, 0, -1])
      negative_wire_run(height);

    translate([0, -13, middle])
      negative_jack_mount();
  }
}
