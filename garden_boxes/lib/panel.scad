include <defaults.scad>;
use <premade/lumber.scad>;

module panel(
  six_by_count,
  width,
  frame_width,
  foot_depth=0,
  edge_offset=0,
  verticals=true,
  horizontals=true,
  avoid_left_endcap=false,
  avoid_right_endcap=false
) {
  height = six_by_count * six_by_height;

  translate([0, edge_offset, 0])
    frame(height, frame_width, foot_depth, verticals, horizontals);

  offset = width == frame_width ? 0 : ((width - frame_width - two_by_height) / 2);
  translate([two_by_height, -offset, 0])
    cover(six_by_count, width, frame_width, avoid_left_endcap, avoid_right_endcap);
}

module cover(six_by_count, width, frame_width, avoid_left_endcap=false, avoid_right_endcap=false) {
  left_offset = avoid_left_endcap ? 2*two_by_height+2*one_by_height : width;
  right_offset = avoid_right_endcap? width-two_by_height : width;

  difference() {
    for(count = [1 : six_by_count])
      translate([0, 0.125, six_by_height * count])
        rotate([0, 90, 0])
          one_by_six(width - 0.25);

    translate([-one_by_height / 2, -left_offset, -1])
      avoidance_subtractor(six_by_count, width, frame_width);

    translate([-one_by_height / 2, right_offset, -1])
      avoidance_subtractor(six_by_count, width, frame_width);
  }
}

module avoidance_subtractor(six_by_count, width, frame_width) {
  avoidance_width = width - frame_width;
  color("BurlyWood")
  cube(size = [two_by_height, avoidance_width, 2+(six_by_height * six_by_count)]);
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
    translate([0, width-two_by_height, -foot_depth])
      rotate([90, 0, 0])
        two_by_two(height + foot_depth);
  }
}

