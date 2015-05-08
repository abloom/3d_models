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

/*module rounded_solo_bottom() {*/
  /*difference() {*/
    /*solo_bottom();*/

    /*wide_rounded_solo_bottom_corner();*/
    /*rotate([0, 0, 180])*/
      /*wide_rounded_solo_bottom_corner();*/
    /*mirror([1, 0, 0])*/
      /*wide_rounded_solo_bottom_corner();*/
    /*mirror([0, 1, 0])*/
      /*wide_rounded_solo_bottom_corner();*/
  /*}*/
/*}*/

/*module wide_rounded_solo_bottom_corner() {*/
  /*difference() {*/
    /*circle(r=24, $fn=128);*/

    /*translate([5, 5, 0])*/
      /*circle(r=24, $fn=128);*/

    /*translate([-27, -30, 0])*/
      /*square([30, 60]);*/
  /*}*/
/*}*/

module resized_bottom(extra) {
  resize([extra+solo_width, extra+solo_depth, 0])
    solo_bottom();
}


/*module rounded_resized_bottom(extra) {*/
  /*resize([extra+solo_width, extra+solo_depth, 0])*/
    /*rounded_solo_bottom();*/
/*}*/

module cone_ring(resize_base, height) {
  translate([0, 0, height])
    linear_extrude(0.1, true)
      resized_bottom(resize_base);
}

/*module rounded_cone_ring(resize_base, height) {*/
  /*translate([0, 0, height])*/
    /*linear_extrude(0.1, true)*/
      /*rounded_resized_bottom(resize_base);*/
/*}*/

module cone(resize_base) {
  curve_factor = 10;
  foot_width = 6;

  union() {
    // curvey profile
    translate([0, 0, 0])
      serial_hull() {
        /*rounded_cone_ring(resize_base, 0);*/
        /*rounded_cone_ring(resize_base, 2);*/
        /*rounded_cone_ring(resize_base*(8/curve_factor), 6);*/
        cone_ring(resize_base, 0);
        cone_ring(resize_base, 2);
        cone_ring(resize_base*(8/curve_factor), 6);
        cone_ring(resize_base*(4/curve_factor), 4*2+2);
        cone_ring(resize_base*(2/curve_factor), 4*3+2);
        cone_ring(resize_base*(1/curve_factor), 4*4+2);
        cone_ring(2, 22);
        cone_ring(2, 31);
      }

    // power jack
    translate([0, -22.5, 6.5])
      rotate([90, 0, 0])
        cylinder(h=8, d=10.5, $fn=32);
  }
}

module base() {
  difference() {
    cone(32);

    // rounded outer edges near the power jack
    translate([-9.25, -35.5, -1])
      difference() {
        cube([18.5, 5, 10]);

        translate([0, 5, -1])
          cylinder(r=4, h=12, $fn=32);

        translate([18.5, 5, -1])
          cylinder(r=4, h=12, $fn=32);
      }

    // negative space for solo
    translate([0, 0, 16])
      linear_extrude(16, true)
        solo_bottom();

    negative_power_assembly();
  }
}

base();
