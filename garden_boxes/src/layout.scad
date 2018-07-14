include <../lib/defaults.scad>
use <box.scad>
use <endcap.scad>

module layout_row(box_count, fenced=true, exploded=false, earthbox=true, edge_offset, panel_length, inside_edge=true) {
  endcap_x = frame_depth + (2 * two_by_height);
  right_y = exploded ? exploded_offset : 0;
  translate([-endcap_x, -right_y, 0])
    right_endcap(frame_depth, frame_height, edge_offset=edge_offset);

  fence_z = fenced ? fence_height : 0;
  box_offset = exploded ? panel_length + exploded_offset : panel_length;
  for(i = [0 : box_count-1])
    translate([0, box_offset * i, 0])
      box(panel_length, frame_depth, frame_height, fence_z, earthbox=earthbox, exploded=exploded, edge_offset=edge_offset, inside_edge=inside_edge);

  left_y = (box_offset * box_count);
  translate([-endcap_x, left_y, 0])
    left_endcap(frame_depth, frame_height, edge_offset=edge_offset);
}

length=40;
offset=two_by_height * 2;

translate([0, exploded_offset, 0])
  layout_row(3, edge_offset=offset, panel_length=length, exploded=true, fenced=false, earthbox=false, inside_edge=false);
translate([frame_depth * 4, exploded_offset * 2, 0])
  layout_row(3, edge_offset=offset, panel_length=length, inside_edge=false);
