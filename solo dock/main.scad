use <base.scad>;
use <plug.scad>;

color("grey")
  base();

color("red")
  power_assembly();

color("blue")
  translate([0, 80, 0])
    negative_power_assembly();

color("red")
  translate([0, 50, 0])
    power_assembly();
