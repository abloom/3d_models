use <src/top.scad>;
use <src/middle.scad>;
use <src/bottom.scad>;

module offset() {
  translate([35, 30, 0])
    top(10);

  translate([35, -30, 0])
    middle(10);

  translate([-35, 0, 3])
    rotate([180, 0, 0])
      bottom(10);
}

module stacked() {
  translate([0, 0, 36])
    top(10);

  translate([0, 0, 13])
    middle(10);

  bottom(10);
}

module assembled() {
  translate([0, 0, 16])
    top(10);

  translate([0, 0, 3])
    middle(10);

  bottom(10);
}

offset();
/*stacked();*/
/*assembled();*/
