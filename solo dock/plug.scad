use <shared.scad>;

module negative_jack_mount() {
  translate([6, 12.5, 6.5])
    rotate([90, 0, 0])
      cylinder(h=9, d=7.8, $fn=32);
}

module negative_power_plug() {
  translate([0, 0, -2])
    union() {
      cylinder(d=7.5, h=24, $fn=32);
    }
}

module inside_rounded_corner(height) {
  difference() {
    cube([1.5, 1.5, height]);

    translate([1.5, 1.5, -1])
      cylinder(r=1, h=height+2, $fn=32);
  }
}

module negative_wire_run() {
  translate([0, 3, 0])
    rounded_rect([4, 10, 8], 1);

  translate([-3.25, 8, 0])
    rounded_rect([10.5, 4, 8], 1);

  translate([2, -1, 0])
    inside_rounded_corner(8);

  translate([-2, -1, 0])
    rotate([0, 0, 90])
      inside_rounded_corner(8);

  translate([-2, 6, 0])
    rotate([0, 0, 180])
      inside_rounded_corner(8);
}

module negative_power_assembly() {
  union() {
    translate([-6.75, 8, 0])
      rotate([0, 0, -90])
        negative_power_plug();

    translate([0, 0, -2])
      negative_wire_run();

    // open space
    translate([0, -11.5, -2])
      rounded_rect([9.5, 20, 13.75], 2);

    translate([-6, -34.5, 0])
      negative_jack_mount();
  }
}
