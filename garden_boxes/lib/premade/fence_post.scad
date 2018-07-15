module fence_post(height, foot_depth) {
  color("green")
  translate([0, 0, -foot_depth])
  cube(size=[1.5, 0.25, height]);
}
