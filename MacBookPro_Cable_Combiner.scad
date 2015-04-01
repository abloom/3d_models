include <roundCornersCube.scad>

difference() {
	// Widget Outline
	translate([-1,0,0]) {
		roundCornersCube(73.3,12,10,3); //80,12,10,3
	}

	// MagSafe 2 Plug
	translate([-23.5,0,1]) {
		roundCornersCube(17.3,5.4,12,2);
	}

        // MagSafe 2 LED Hole
        translate([-23.5,7,0]) {
            rotate([90,0,0])
                cylinder(r=1.5,h=14,$fn=8);
        }

	// LMP DisplayPort to HDMI Converter
	translate([-5.1,0,1]) {
		roundCornersCube(11.7,8.7,12,2);
	}

	// Apple Ethernet Converter
	translate([9,0,1]) {
		roundCornersCube(11.7,8.7,12,2);
	}

	// USB Plug
	translate([25,0,1]) {
		roundCornersCube(16.35,8.35,12,1);
	}
}
