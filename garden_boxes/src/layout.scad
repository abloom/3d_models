include <../lib/defaults.scad>
use <../lib/box.scad>
use <../lib/endcap.scad>

module layout_row(box_count, fenced=true, exploded=false, earthbox=true, edge_offset, panel_length, edge_type) {
  fence_z = fenced ? fence_height : 0;
  box_offset = panel_length + (exploded ? exploded_offset : 0);

  for(i = [0 : box_count-1])
    translate([0, box_offset * i, 0])
      box(
        length=panel_length,
        width=frame_depth,
        four_by_count=frame_height,
        fence_height=fence_z,
        edge_offset=edge_offset,
        earthbox=earthbox,
        exploded=exploded,
        edge_type=edge_type,
        left_cap=i==0,
        right_cap=i==box_count-1
      );
}

length=40;
edge_offset=two_by_height * 2;
edge_type="outside";

translate([0, exploded_offset, 0])
  layout_row(
    box_count=3,
    edge_offset=edge_offset,
    panel_length=length,
    exploded=true,
    fenced=false,
    earthbox=false,
    edge_type=edge_type
  );

translate([frame_depth * 4, exploded_offset * 2, 0])
  layout_row(
    box_count=3,
    edge_offset=edge_offset,
    panel_length=length,
    edge_type=edge_type
  );
