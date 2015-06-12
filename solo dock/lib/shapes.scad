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

module inside_rounded_corner(height, radius=1) {
  padded = radius + 0.5;

  difference() {
    cube([padded, padded, height]);

    translate([padded, padded, -1])
      cylinder(r=radius, h=height+2, $fn=32);
  }
}
