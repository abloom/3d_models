OPEN_SCAD_PATH=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
OUTPUT_FILES=dist/record_player_stand.stl

# explicit wildcard expansion suppresses errors when no files are found
include $(wildcard *.deps)

default: build

clean:
	rm -rf dist
	mkdir dist

build: $(OUTPUT_FILES)

dist/%.stl: %.scad
	$(OPEN_SCAD_PATH) -m make -o $@ -d $@.deps $<

all: clean build

.PHONY: clean all build

