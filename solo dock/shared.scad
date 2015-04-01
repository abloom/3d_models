module serial_hull() {
  for(i = [0 : $children-2]) {
    hull() {
      children(i);
      children(i+1);
    }
  }
}