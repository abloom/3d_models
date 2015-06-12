module corner_pads(base_x, base_y) {
  for(x = [-base_x, base_x]) {
    for(y = [-base_y, base_y]) {
      translate([x, y, 0])
        cylinder(d=15, h=0.3);
    }
  }
}

module large_corner_pads() {
  corner_pads(25, 20);
}

module small_corner_pads() {
  corner_pads(23, 18);
}
