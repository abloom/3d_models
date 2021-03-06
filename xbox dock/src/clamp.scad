WALL_WIDTH = 2;
WALL_HEIGHT = 17;
CHANNEL_WIDTH = 0.4;
CHANNEL_HEIGHT = 0.6;
EDGE_WIDTH = (WALL_WIDTH-CHANNEL_WIDTH)/2;

module zig_zag_wall(inner) {
  lengths = [9.5, 4.5, 8.5, 8];
  extended_length = inner ?
    [
      lengths[0]-EDGE_WIDTH,
      lengths[1],
      lengths[2],
      lengths[3]+EDGE_WIDTH
    ] : [
      lengths[0],
      lengths[1]+EDGE_WIDTH,
      lengths[2]+EDGE_WIDTH,
      lengths[3]+(2*EDGE_WIDTH)
    ];

  wall_height = inner ? WALL_HEIGHT : WALL_HEIGHT + CHANNEL_HEIGHT;
  channel_height = inner ? CHANNEL_HEIGHT : CHANNEL_HEIGHT + 1;
  position = inner ?
    -lengths[1]+EDGE_WIDTH+CHANNEL_WIDTH :
    -lengths[1]+(EDGE_WIDTH/2)+CHANNEL_WIDTH;

  conditional_difference(inner) {
    union() {
      cube([lengths[0], WALL_WIDTH, wall_height]);

      translate([0, -lengths[1], 0])
        cube([WALL_WIDTH, lengths[1], wall_height]);

      translate([-lengths[2], -lengths[1], 0])
        cube([lengths[2], WALL_WIDTH, wall_height]);

      translate([-lengths[2], -lengths[1]+WALL_WIDTH, 0])
        cube([WALL_WIDTH, lengths[3], wall_height]);
    }

    translate([EDGE_WIDTH, EDGE_WIDTH, WALL_HEIGHT])
      cube([extended_length[0], CHANNEL_WIDTH, channel_height]);

    translate([EDGE_WIDTH, -lengths[1]+EDGE_WIDTH, WALL_HEIGHT])
      cube([CHANNEL_WIDTH, extended_length[1], channel_height]);

    translate([-lengths[2]+EDGE_WIDTH, -lengths[1]+EDGE_WIDTH, WALL_HEIGHT])
      cube([extended_length[2], CHANNEL_WIDTH, channel_height]);

    translate([-lengths[2]+EDGE_WIDTH, position, WALL_HEIGHT])
      cube([CHANNEL_WIDTH, extended_length[3], channel_height]);
  }
}

module straight_wall(inner) {
  lengths = [18, 8];
  extended_lengths = inner ? [
    lengths[0] - EDGE_WIDTH,
    lengths[1] + EDGE_WIDTH
  ]: [
    lengths[0] + 2,
    lengths[1] + 2
  ];

  wall_height = inner ? WALL_HEIGHT : WALL_HEIGHT + CHANNEL_HEIGHT;
  channel_height = inner ? CHANNEL_HEIGHT : CHANNEL_HEIGHT + 1;
  position = inner ? -lengths[1] : -lengths[1] - EDGE_WIDTH;

  conditional_difference(inner) {
    union() {
      cube([lengths[0], WALL_WIDTH, wall_height]);

      translate([0, -lengths[1], 0])
        cube([WALL_WIDTH, lengths[1], wall_height]);
    }

    translate([EDGE_WIDTH, EDGE_WIDTH, WALL_HEIGHT])
      cube([extended_lengths[0], CHANNEL_WIDTH, channel_height]);

    translate([EDGE_WIDTH, position, WALL_HEIGHT])
      cube([CHANNEL_WIDTH, extended_lengths[1], channel_height]);
  }
}

module conditional_difference(inner) {
  if (inner) {
    children();
  } else {
    difference() {
      children(0);
      children([1:$children-1]);
    }
  }
}

module bottom_wall() {
  cube([18, 15.5, WALL_WIDTH]);

  translate([8.5, 15.5])
    cube([9.5, 4.5, WALL_WIDTH]);
}

module peg() {
  cylinder(r=2, h=5, $fn=32);
}

module clamp(inner) {
  difference() {
    union() {
      translate([8.5, 18, 0])
        zig_zag_wall(inner);

      straight_wall(!inner);

      #bottom_wall();

      translate([7, 7, 2])
        peg();
    }

    translate([32, 7, -1])
      cylinder(r=17, h=WALL_HEIGHT+CHANNEL_HEIGHT+2, $fn=64);
  }
}

translate([0, 10, 0])
  clamp(true);

translate([0, -10, 0])
  mirror([0, 1, 0])
    clamp(false);
