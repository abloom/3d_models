include <../lib/defaults.scad>;
use <../lib/lumber.scad>;
use <../lib/panel.scad>;
use <../lib/earthbox.scad>;
use <../lib/fence_post.scad>;

module box(length, width, four_by_count, fence_height, edge_offset, earthbox=false, exploded=false, inside_edge=true) {
  translate([-width, length, 0]) {
    rotate([0, 0, 180]) {
      //////
      // wood frame
      //////

      // front
      panel(four_by_count, length, cover=true, edge_offset=edge_offset, horizontals=false, inside_edge=inside_edge);

      edge_addition = inside_edge ? 0 : two_by_height;
      translate([exploded ? -exploded_offset : 0, 0, 0]) {
        color("purple") {
          // left side
          translate([two_by_height, edge_offset-two_by_height+edge_addition, 0])
            rotate([0, 0, 90])
              panel(four_by_count, width);

          // right side
          translate([two_by_height, length-edge_offset-edge_addition, 0])
            rotate([0, 0, 90])
              panel(four_by_count, width);

          // back
          translate([-width + two_by_height, edge_addition, 0])
            panel(four_by_count, length-(2 * edge_addition), edge_offset=edge_offset, verticals=false);

          // front
          translate([0, edge_offset+edge_addition, 0])
            two_by_two(length-(2*edge_offset)-(2*edge_addition));
        }

        //////
        // fence posts
        //////

        // front left
        translate([-two_by_height, edge_offset+edge_addition, 0])
          fence_post(fence_height, foot_depth);

        // back left
        translate([-width+(two_by_height*2), edge_offset+edge_addition, 0])
          fence_post(fence_height, foot_depth);

        // front right
        translate([-two_by_height, length-edge_offset-0.25-edge_addition, 0])
          fence_post(fence_height, foot_depth);

        // back right
        translate([-width+(two_by_height*2), length-edge_offset-0.25-edge_addition, 0])
          fence_post(fence_height, foot_depth);
      }

      if (earthbox) {
        earthbox_x_offset = exploded ? (exploded_offset/2) : 0;
        earthbox_y = (length - 29) / 2;
        translate([-15-earthbox_x_offset, earthbox_y, 0])
          earthbox();
      }
    }
  }
}

panel_length=40;
edge_offset=two_by_height*2;
inside_edge=false;

box(panel_length, frame_depth, frame_height, fence_height, earthbox=true, edge_offset=edge_offset, inside_edge=inside_edge);

translate([0, panel_length * 1.5, 0])
  box(panel_length, frame_depth, frame_height, fence_height, edge_offset=edge_offset, inside_edge=inside_edge);

translate([0, panel_length * 3, 0])
  box(panel_length, frame_depth, frame_height, fence_height, exploded=true, edge_offset=edge_offset, inside_edge=inside_edge);

translate([0, panel_length * 4.5, 0])
  box(panel_length, frame_depth, frame_height, 0, exploded=true, edge_offset=edge_offset, inside_edge=inside_edge);
