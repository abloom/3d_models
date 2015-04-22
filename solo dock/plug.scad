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

        translate([22.5, 1, 0])
          rotate([90, 0, 90])
            cube([7, 7, 0.1]);
      }
  }
}

module power_cable_rotate_slice(idx, total, offset) {
  half = total / 2;

  rotate([idx*15, 0, 0])
    translate([idx*offset, 0, 0])
      cube([0.1, 4, 1], true);
}

module power_cable_90_bend() {
  rotate([0, 0, -90])
    intersection() {
      translate([-5, 0, 0])
        cube([5, 5, 4]);

      rotate_extrude()
        translate([4, 0, 0])
          square([1, 4]);
    }
}

module power_cable() {
  union() {
    serial_hull() {
      // twist at beginning
      power_cable_rotate_slice(0, 6, 1.5);
      power_cable_rotate_slice(1, 6, 1.5);
      power_cable_rotate_slice(2, 6, 1.5);
      power_cable_rotate_slice(3, 6, 1.5);
      power_cable_rotate_slice(4, 6, 1.5);
      power_cable_rotate_slice(5, 6, 1.5);
      power_cable_rotate_slice(6, 6, 1.5);
    }

    // 180 degree bend
    translate([9, -4.5, -2])
      power_cable_90_bend();

    translate([13.5, -5.75, 0])
      cube([1, 2.5, 4], true);

    translate([9, -7, -2])
      rotate([0, 0, -90])
        power_cable_90_bend();
  }
}

module power_assembly() {
  union() {
    power_plug();

    translate([22.5, 0, 4])
      power_cable();
  }
}

module negative_jack_mount() {
  center = 6;

  union() {
    // stop
    translate([6, 12.5, 5.7])
      rotate([90, 0, 0])
        cylinder(h=9, d=8.1);

    // hex cutout for nut
    translate([6, 14, 6])
      rotate([90, 0, 0])
        cylinder(h=8, d=11.5, $fn=6);

    // open space
    translate([0.25, 6, 0])
      cube([11.5, 7, 6]);
    translate([0.25, 12, -2])
      cube([11.5, 10, 12.98]);
    translate([6, 22, -2])
      rounded_rect([9.5, 4, 12.98], 2);

    // cutout to slip wires in
    translate([5, 3.5, -2])
      cube([2, 9, 5]);
  }
}

module inside_rounded_corner(height) {
  difference() {
    cube([1, 1, height+1]);

    translate([1, 1, -1])
      cylinder(r=1, h=height+3, $fn=32);
  }
}

module negative_power_plug() {
  scale([1, 1, 2])
    power_plug();
}

module negative_power_assembly() {
  union() {
    translate([-6.75, 8, -4])
      rotate([0, 0, -90])
        negative_power_plug();

    translate([0, -29, -1])
      rounded_rect([4, 18, 3], 1);

    translate([-6.75, -19, -1])
      rounded_rect([4, 10, 5], 1);

    translate([-3.25, -22, -1])
      rounded_rect([10.5, 4, 5], 1);

    translate([-4.25, -19.5, -1])
      inside_rounded_corner(4);

    rotate([0, 0, 180])
      translate([2.5, 24.5, -1])
        inside_rounded_corner(4);

    translate([-2.5, -25.5, 2])
      cube([5, 2, 2]);

    translate([-9.25, -17, 1])
      rotate([35, 0, 0])
        cube([5, 6, 3]);

    difference() {
      translate([-2.5, -29.75, -0.75])
        rotate([25, 0, 0])
          cube([5, 6, 2.5]);

      translate([-3.25, -26, 4])
        cube([10.5, 5, 5]);
    }

    /*translate([-6, -34.5, 0])*/
      /*negative_jack_mount();*/
  }
}
