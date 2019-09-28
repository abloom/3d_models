include <defaults.scad>;
use <premade/lumber.scad>;
use <premade/earthbox.scad>;
use <premade/fence_post.scad>;
use <panel.scad>;
use <endcap.scad>;

module box(panel_length, four_by_count, fence_height, frame_inside_length,
    foot_depth, earthbox=false, exploded=false, edge_type="inside",
    left_endcap=true, right_endcap=true) {
  width=frame_inside_depth + (3 * two_by_height) + one_by_height;
  translate([-width, panel_length, 0]) {
    rotate([0, 0, 180]) {
      // front
      cover_edge_addition = edge_type == "inside" ? two_by_height :
                            edge_type == "outside" ? -two_by_height :
                            0;
      edge_offset=(panel_length-frame_inside_length)/2 - two_by_height;
      panel(four_by_count, panel_length, cover=true, edge_offset=edge_offset + cover_edge_addition, horizontals=false);

      frame_edge_addition = two_by_height;
      bottom_depth_addition = edge_type == "inside" ? -two_by_height :
                              edge_type == "inline" ? -two_by_height :
                              0;
      side_depth_addition = edge_type == "inline" ? -two_by_height : 0;
      frame_offset = exploded ? -exploded_offset : 0;

      translate([frame_offset, 0, 0]) {
        // wood frame
        color("purple") {
          // left front
          translate([0, 0, -12])
            rotate([90, 0, 0])
              two_by_two(8*12);

          // left back
          translate([-frame_inside_depth-two_by_height, 0, -12])
            rotate([90, 0, 0])
              two_by_two(8*12);

          // righr front
          translate([0, frame_inside_length+two_by_height, -12])
            rotate([90, 0, 0])
              two_by_two(8*12);

          // right back
          translate([-frame_inside_depth-two_by_height, frame_inside_length+two_by_height, -12])
            rotate([90, 0, 0])
              two_by_two(8*12);

          /*// left side*/
          /*translate([two_by_height+side_depth_addition, 2*two_by_height, 0])*/
            /*rotate([0, 0, 90])*/
              /*panel(four_by_count, frame_inside_depth+side_depth_addition + (2*two_by_height));*/

          /*// right side*/
          /*translate([two_by_height+side_depth_addition, frame_inside_length+(2*frame_edge_addition)+two_by_height, 0])*/
            /*rotate([0, 0, 90])*/
              /*panel(four_by_count, frame_inside_depth+side_depth_addition + (2*two_by_height));*/

          /*// back*/
          /*translate([-width + (2.5 * two_by_height), 3*two_by_height, 0])*/
            /*panel(four_by_count, frame_inside_length, verticals=false);*/

          /*// front*/
          /*translate([bottom_depth_addition, 3*frame_edge_addition, 0])*/
            /*two_by_two(frame_inside_length);*/
        }
      }

      if (earthbox) {
        earthbox_x_offset = exploded ? exploded_offset/4 : 0;
        earthbox_x = (-frame_inside_depth - earthbox_width) / 2;
        earthbox_y = (panel_length - earthbox_length) / 2;
        translate([earthbox_x-earthbox_x_offset, earthbox_y, 0])
          earthbox();
      }

      endcap_offset = exploded ? exploded_offset : 0;
      if (left_endcap) {
        translate([-width, panel_length + endcap_offset, 0])
          left_endcap(width, frame_height, edge_offset=0);
      }

      if (right_endcap) {
        translate([-width, -endcap_offset, 0])
          right_endcap(width, frame_height, edge_offset=0);
      }
    }
  }
}

translate([0, panel_length * 0, 0])
  box(
    panel_length=panel_length,
    four_by_count=frame_height,
    fence_height=fence_height,
    frame_inside_length=frame_inside_length,
    foot_depth=foot_depth,
    /*exploded=true,*/
    earthbox=true,
    edge_type="inside",
    left_endcap=false,
    right_endcap=false
  );

translate([0, panel_length * 1.5, 0])
  box(
    panel_length=panel_length,
    four_by_count=frame_height,
    fence_height=fence_height,
    frame_inside_length=frame_inside_length,
    foot_depth=foot_depth,
    exploded=true,
    earthbox=true,
    edge_type="inside",
    left_endcap=false,
    right_endcap=false
  );

/*translate([0, panel_length * 1.5, 0])*/
  /*box(*/
    /*panel_length=panel_length,*/
    /*four_by_count=frame_height,*/
    /*fence_height=fence_height,*/
    /*frame_inside_length=frame_inside_length,*/
    /*foot_depth=foot_depth,*/
    /*[>exploded=true,<]*/
    /*earthbox=true,*/
    /*edge_type="inside",*/
    /*left_endcap=false,*/
    /*right_endcap=false*/
  /*);*/

/*translate([0, panel_length * 3, 0])*/
  /*box(*/
    /*panel_length=panel_length,*/
    /*four_by_count=frame_height,*/
    /*fence_height=fence_height,*/
    /*frame_inside_length=frame_inside_length,*/
    /*foot_depth=foot_depth,*/
    /*[>exploded=true,<]*/
    /*earthbox=true,*/
    /*edge_type="inline",*/
    /*left_endcap=false,*/
    /*right_endcap=false*/
  /*);*/
