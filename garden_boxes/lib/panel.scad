include <defaults.scad>;
use <premade/lumber.scad>;

module panel(six_by_count, width, foot_depth=0, cover=false, edge_offset=0, verticals=true, horizontals=true) {
  height = six_by_count * six_by_height;
  frame_width = earthbox_length+2+(2*two_by_height)-(2*edge_offset);

  translate([0, edge_offset, 0])
    frame(height, frame_width, foot_depth, verticals, horizontals);

  if (cover) {
    offset = ((width - frame_width) / 2) - edge_offset;
    translate([two_by_height, -offset, 0])
      cover(six_by_count, width);
  }
}

module cover(six_by_count, width) {
  for(count = [1 : six_by_count])
    translate([0, 0.125, six_by_height * count])
      rotate([0, 90, 0])
        one_by_six(width - 0.25);
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

