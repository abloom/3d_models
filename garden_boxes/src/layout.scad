include <../lib/defaults.scad>
use <box.scad>
use <endcap.scad>

module layout_row(box_count, fenced=true, exploded=false, earthbox=true, edge_offset, panel_length) {
  endcap_x = frame_depth + (2 * two_by_height);
  right_y = exploded ? exploded_offset : 0;
  translate([-endcap_x, -right_y, 0])
    right_endcap(frame_depth, frame_height, edge_offset=edge_offset);

  fence_z = fenced ? fence_height : 0;
  box_offset = exploded ? panel_length + exploded_offset : panel_length;
  for(i = [0 : box_count-1])
    translate([0, box_offset * i, 0])
      box(panel_length, frame_depth, frame_height, fence_z, earthbox=earthbox, exploded=exploded, edge_offset=edge_offset);

  left_y = (box_offset * box_count);
  translate([-endcap_x, left_y, 0])
    left_endcap(frame_depth, frame_height, edge_offset=edge_offset);
}

lengths=[38, 40, 44];
offsets=[two_by_height*2, two_by_height*3, two_by_height*4];
boxes=[3, 3, 3];

for(i=[0 : 2]) {
  translate([0, boxes[i] * (lengths[i] + (exploded_offset*2)) * i, 0]) {
    translate([0, exploded_offset, 0])
      layout_row(boxes[i], edge_offset=offsets[i], panel_length=lengths[i], exploded=true, fenced=false, earthbox=false);
    translate([frame_depth * 4, exploded_offset * ((boxes[i] + 1)/2), 0])
      layout_row(boxes[i], edge_offset=offsets[i], panel_length=lengths[i]);
  }
}
