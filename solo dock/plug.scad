use <shared.scad>;

module power_plug() {
  union() {
    // plug
    cylinder(r=4.5, h=12, $fn=32);

    translate([0, 0, 3])
      sphere(r=4.5, $fn=16);

    translate([0, 0, 12])
      cylinder(r=2, h=10.5);

    translate([0, -4.5, 0])
      hull() {
        rotate([90, 0, 90])
          cube([9, 7, 0.1]);

        translate([22.5, 0, 0])
          rotate([90, 0, 90])
            cube([7, 7, 0.1]);
      }
  }
}

module negative_power_plug() {
  scale([1, 1, 2])
    power_plug();
}

module power_cable_rotate_slice(idx, total, offset) {
  half = total / 2;

  translate([idx*offset, idx/half, -1*idx/half])
    rotate([idx*15, 0])
      cube([0.1, 4, 1]);
}

module power_cable() {
  // twist at beginning
  union() {
    serial_hull() {
      power_cable_rotate_slice(0, 6, 2.25);
      power_cable_rotate_slice(1, 6, 2.25);
      power_cable_rotate_slice(2, 6, 2.25);
      power_cable_rotate_slice(3, 6, 2.25);
      power_cable_rotate_slice(4, 6, 2.25);
      power_cable_rotate_slice(5, 6, 2.25);
      power_cable_rotate_slice(6, 6, 2.25);

    }
  }
}

module negative_jack_mount() {
  center = 6;

  union() {
    // recessed head
    translate([6, 3, 6])
      rotate([90, 0, 0])
        cylinder(h=4, d=10);

    // stop
    translate([6, 6, 6])
      rotate([90, 0, 0])
        cylinder(h=4, d=8.3);

    // open space
    translate([0.5, 5, -2])
      cube([11, 20, 13]);
  }
}

module negative_power_cable() {
  height = 9;

  union() {
    cube([14.5, 4, height]);

    translate([13.5, -9, 0])
      cube([2, 13, height]);

    translate([-15, -10, 0])
      cube([30.5, 2, height]);

    translate([-16, -14, 0])
      cube([2, 6, height]);
  }
}

module power_assembly() {
  union() {
    translate([-6.75, 6.5, 1])
      power_plug();

    translate([15, 3.5, 4])
      power_cable();
  }
}

module negative_power_assembly() {
  union() {
    translate([-6.75, 6.5, -6])
      negative_power_plug();

    translate([15, 3.5, -2])
      negative_power_cable();

    translate([-6, -34.5, 0])
      negative_jack_mount();
  }
}
