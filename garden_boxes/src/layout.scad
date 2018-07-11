include <../lib/defaults.scad>
use <box.scad>
use <endcap.scad>

module layout_row(box_count, fenced=true, exploded=false, earthbox=true) {
  endcap_offset = exploded ? exploded_offset : 0;
  translate([-endcap_offset, 0, 0])
    right_endcap(frame_depth, frame_height);

  fence_z = fenced ? fence_height : 0;
  box_offset = exploded ? panel_length + exploded_offset : panel_length;
  for(i = [0 : box_count-1])
    translate([box_offset * i, 0, 0])
      box(panel_length, frame_depth, frame_height, fence_z, earthbox=earthbox, exploded=exploded);

  left_x = (box_offset * box_count);
  translate([left_x, 0, 0])
    left_endcap(frame_depth, frame_height);
}

layout_row(3, exploded=true, fenced=false, earthbox=false);

translate([exploded_offset, frame_depth * 4, 0])
  layout_row(3);
