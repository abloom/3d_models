use <shared.scad>;
use <solo.scad>;

module bottom(base) {
  extra = base - 3;

  difference() {
    cone_ring(base + extra, 0, 3);

    /*serial_hull() {*/
      /*cone_ring(base + extra + 1.62, 0);*/
      /*cone_ring(base + extra, 3);*/
    /*}*/

    // rubber pad cutaway
    translate([0, 0, -1])
      cone_ring(base + extra - 4, 0, 2.5);
  }
}

bottom(10);
