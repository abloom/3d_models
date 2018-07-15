include <defaults.scad>;
use <premade/lumber.scad>;
use <premade/earthbox.scad>;
use <premade/fence_post.scad>;
use <panel.scad>;
use <endcap.scad>;

module box(length, width, four_by_count, fence_height, edge_offset, earthbox=false, exploded=false, edge_type="inside", left_cap=true, right_cap=true) {
  translate([-width, length, 0]) {
    rotate([0, 0, 180]) {
      //////
      // wood frame
      //////

      // front
      cover_edge_addition = edge_type == "inside" ? two_by_height :
                            edge_type == "outside" ? 0 :
                            edge_type == "inline" ? 0 :
                            0;
      panel(four_by_count, length, cover=true, edge_offset=edge_offset + cover_edge_addition, horizontals=false);

      frame_edge_addition = edge_type == "inside" ? two_by_height :
                            edge_type == "outside" ? two_by_height * 2 :
                            edge_type == "inline" ? two_by_height :
                            0;
      frame_depth_addition = edge_type == "inside" ? 0 :
                             edge_type == "outside" ? 0 :
                             edge_type == "inline" ? two_by_height :
                             0;
      translate([exploded ? -exploded_offset : 0, 0, 0]) {
        color("purple") {
          // left side
          translate([two_by_height-frame_depth_addition, edge_offset-two_by_height+frame_edge_addition, 0])
            rotate([0, 0, 90])
              panel(four_by_count, width-frame_depth_addition);

          // right side
          translate([two_by_height-frame_depth_addition, length-edge_offset-frame_edge_addition, 0])
            rotate([0, 0, 90])
              panel(four_by_count, width-frame_depth_addition);

          // back
          translate([-width + two_by_height, frame_edge_addition, 0])
            panel(four_by_count, length-(2 * frame_edge_addition), edge_offset=edge_offset, verticals=false);

          // front
          translate([0-frame_depth_addition, edge_offset+frame_edge_addition, 0])
            two_by_two(length-(2*edge_offset)-(2*frame_edge_addition));
        }

        //////
        // fence posts
        //////

        // front left
        translate([-two_by_height, edge_offset+frame_edge_addition, 0])
          fence_post(fence_height, foot_depth);

        // back left
        translate([-width+(two_by_height*2), edge_offset+frame_edge_addition, 0])
          fence_post(fence_height, foot_depth);

        // front right
        translate([-two_by_height, length-edge_offset-0.25-frame_edge_addition, 0])
          fence_post(fence_height, foot_depth);

        // back right
        translate([-width+(two_by_height*2), length-edge_offset-0.25-frame_edge_addition, 0])
          fence_post(fence_height, foot_depth);
      }

      if (earthbox) {
        earthbox_x_offset = exploded ? (exploded_offset/2) : 0;
        earthbox_y = (length - 29) / 2;
        translate([-15-earthbox_x_offset, earthbox_y, 0])
          earthbox();
      }

      endcap_offset = exploded ? exploded_offset : 0;
      if (left_cap) {
        translate([-width, length + endcap_offset, 0])
          left_endcap(width, frame_height, edge_offset=0);
      }

      if (right_cap) {
        translate([-width, -endcap_offset, 0])
          right_endcap(width, frame_height, edge_offset=0);
      }
    }
  }
}

panel_length=40;
edge_offset=0;

translate([0, panel_length * 0, 0])
  box(panel_length, frame_depth, frame_height, fence_height, earthbox=true, edge_offset=edge_offset, edge_type="inside");

translate([0, panel_length * 1.5, 0])
  box(panel_length, frame_depth, frame_height, fence_height, earthbox=true, edge_offset=edge_offset, edge_type="outside");

translate([0, panel_length * 3, 0])
  box(panel_length, frame_depth, frame_height, fence_height, earthbox=true, edge_offset=edge_offset, edge_type="inline");
