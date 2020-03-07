garage_door_width = 8*12;

module garage_wall() {
  // concrete base
  color("grey")
  cube([282, 10, 8]);

  // wall w/siding
  translate([0, 0, 8])
    union() {
      difference() {
        color("MintCream")
        cube([282, 4, garage_door_width]);

        // cutout for garage door
        color("MintCream")
        translate([50, -2, -1])
          cube([garage_door_width, 8, (7*12)+1]);
      }

      // garage door
      color("white")
      translate([50, 2, 0])
        for(count = [1 : 4])
          translate([0, 0, (count-1) * 21])
            garage_door_panel();
    }

  // fence
  color("SaddleBrown")
  translate([279, -3, 0])
    cube([46, 3, 4*12]);
}

module garage_door_panel() {
  union() {
    half_garage_door_panel();
    translate([0, 0, 21])
      mirror([0, 0, 1])
        half_garage_door_panel();
  }
}

module half_garage_door_panel() {
  difference() {
    cube([garage_door_width, 1, 10.5]);

    translate([-1, 0, -1])
      rotate([15, 0, 0])
        cube([garage_door_width+2, 1, 3]);
  }
}
