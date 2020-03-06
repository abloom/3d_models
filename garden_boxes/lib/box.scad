include <defaults.scad>;
use <premade/lumber.scad>;
use <premade/earthbox.scad>;
use <panel.scad>;
use <endcap.scad>;

frame_length=earthbox_length+2+two_by_height;

module box(
  panel_length,
  post_height,
  earthbox=true,
  left_endcap=false,
  right_endcap=false,
  exploded=false,
) {
  frame(post_height);

  panel_offset = exploded ? -16 : 0;
  translate([0, panel_offset, 0])
    rotate([0, 0, 270])
      panel(
        six_by_count=3,
        width=panel_length,
        cover=true,
        horizontals=false,
        edge_offset=two_by_height,
        foot_depth=-two_by_height
      );

  if (left_endcap) {
    translate([-two_by_height-one_by_height, -(frame_width+two_by_height)/2, 0])
      panel(
        six_by_count=3,
        width=frame_width+two_by_height,
        cover=true,
        horizontals=false,
        verticals=false
      );
  }

  if (right_endcap) {
    translate([frame_length, -(frame_width+two_by_height)/2, 0])
      panel(
        six_by_count=3,
        width=frame_width+two_by_height,
        cover=true,
        horizontals=false,
        verticals=false
      );
  }

  if (earthbox) {
    translate([two_by_height+1, 1, two_by_height])
      earthbox();
  }
}

module frame(post_height) {
  // vertical posts
  // front left
  translate([0, 0, -foot_depth])
    rotate([90, 0, 0])
      two_by_two(post_height);
  //front right
  translate([frame_length, 0, -foot_depth])
    rotate([90, 0, 0])
      two_by_two(post_height);
  // back left
  translate([0, frame_width, -foot_depth])
    rotate([90, 0, 0])
      two_by_two(post_height);
  // back right
  translate([frame_length, frame_width, -foot_depth])
    rotate([90, 0, 0])
      two_by_two(post_height);

  // bottom ring
  // left
  translate([0, 0, 0])
    two_by_two(earthbox_width+2);
  // right
  translate([earthbox_length+two_by_height+2, 0, 0])
    two_by_two(earthbox_width+2);
  //front
  translate([two_by_height, 0, 0])
    rotate([0, 0, -90])
      two_by_two(earthbox_length+2);
  // back
  translate([two_by_height, earthbox_width+2+two_by_height, 0])
    rotate([0, 0, -90])
      two_by_two(earthbox_length+2);

  // middle ring
  middle_ring_height=earthbox_height+two_by_height+1;
  // left
  translate([0, 0, middle_ring_height])
    two_by_two(earthbox_width+2);
  // right
  translate([earthbox_length+two_by_height+2, 0, middle_ring_height])
    two_by_two(earthbox_width+2);
  // back
  translate([two_by_height, earthbox_width+2+two_by_height, middle_ring_height])
    rotate([0, 0, -90])
      two_by_two(earthbox_length+2);

  // top ring
  top_ring_height=post_height-foot_depth-two_by_height;
  // left
  translate([0, 0, top_ring_height])
    two_by_two(earthbox_width+2);
  // right
  translate([earthbox_length+two_by_height+2, 0, top_ring_height])
    two_by_two(earthbox_width+2);
  //front
  translate([two_by_height, 0, top_ring_height])
    rotate([0, 0, -90])
      two_by_two(earthbox_length+2);
  // back
  translate([two_by_height, earthbox_width+2+two_by_height, top_ring_height])
    rotate([0, 0, -90])
      two_by_two(earthbox_length+2);
}

