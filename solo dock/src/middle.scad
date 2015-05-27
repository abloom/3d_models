use <shared.scad>;
use <solo.scad>;
use <plug.scad>;

module middle(base) {
  extra = base - 3;

  difference() {
    serial_hull() {
      cone_ring(base + extra, 0);
      cone_ring(base, 13);
    }

    negative_power_assembly(13);
  }
}

middle(10);
