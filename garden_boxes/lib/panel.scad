include <defaults.scad>;
use <../lib/lumber.scad>;

module panel(four_by_count, width, foot_depth=0, cover=false, edge_offset=0, verticals=true, horizontals=true) {
  height = four_by_count * four_by_height;
  final_width=width - (edge_offset*2);

  translate([0, edge_offset, 0])
    frame(height, final_width, foot_depth, verticals, horizontals);

  if (cover) {
    translate([two_by_height, 0, 0])
      cover(four_by_count, width);
  }
}

module cover(four_by_count, width) {
  for(count = [1 : four_by_count])
    translate([0, 0, four_by_height * count])
      rotate([0, 90, 0])
        one_by_four(width);
}

module frame(height, width, foot_depth, verticals=true, horizontals=true) {
  if (horizontals) {
    final_width = verticals ? width - (two_by_height * 2) : width;
    y_position = verticals ? two_by_height : 0;

    // top 2x2
    translate([0, y_position, height-two_by_height])
      two_by_two(final_width);

    // bottom 2x2
    translate([0, y_position, 0])
      two_by_two(final_width);
  }

  if (verticals) {
    // left 2x2
    translate([0, two_by_height, -foot_depth])
      rotate([90, 0, 0])
        two_by_two(height + foot_depth);

    // right 2x2
    translate([0, width, -foot_depth])
      rotate([90, 0, 0])
        two_by_two(height + foot_depth);
  }
}

