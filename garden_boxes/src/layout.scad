include <../lib/defaults.scad>
use <../lib/box.scad>
use <../lib/endcap.scad>

module layout_row(box_count, fenced=true, exploded=false, earthbox=true, panel_length, edge_type, frame_inside_length, foot_depth) {
  fence_z = fenced ? fence_height : 0;
  box_offset = panel_length + (exploded ? exploded_offset : 0);

  for(i = [0 : box_count-1])
    translate([0, box_offset * i, 0])
      box(
        panel_length=panel_length,
        frame_inside_length=frame_inside_length,
        four_by_count=frame_height,
        fence_height=fence_z,
        foot_depth=foot_depth,
        earthbox=earthbox,
        exploded=exploded,
        edge_type=edge_type,
        left_endcap=i==0,
        right_endcap=i==box_count-1
      );
}

translate([0, exploded_offset, 0])
  layout_row(
    box_count=3,
    panel_length=panel_length,
    frame_inside_length=frame_inside_length,
    foot_depth=foot_depth,
    exploded=true,
    fenced=false,
    earthbox=false,
    edge_type=edge_type
  );

translate([frame_inside_length * 4, exploded_offset * 2, 0])
  layout_row(
    box_count=3,
    panel_length=panel_length,
    frame_inside_length=frame_inside_length,
    foot_depth=foot_depth,
    edge_type=edge_type
  );
