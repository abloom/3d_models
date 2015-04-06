module serial_hull() {
  for(i = [0 : $children-2]) {
    hull() {
      children(i);
      children(i+1);
    }
  }
}

module rounded_rect(size, radius) {
  x = size[0];
  y = size[1];
  z = size[2];

  linear_extrude(height=z)
  hull() {
    // place 4 circles in the corners, with the given radius
    translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius, $fn=32);

    translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius, $fn=32);

    translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius, $fn=32);

    translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius, $fn=32);
  }
}
