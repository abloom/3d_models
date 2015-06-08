module narrow_screws(z) {
  screws(16, 12, z);
}

module wide_screws(z) {
  screws(19, 15, z);
}

module screws(base_x, base_y, z) {
  for(x = [-base_x, base_x]) {
    for(y = [-base_y, base_y]) {
      translate([x, y, z])
        cylinder(d1=7, d2=0, h=4, $fn=32);

      translate([x, y, z + 2.1])
        cylinder(d=2.75, h=16, $fn=32);
    }
  }
}
