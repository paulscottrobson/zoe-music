
SOURCES = $(wildcard music/*.mscz music/*/*.mscz music/*/*/*.mxl music/*/*/*/*.mscz)
OBJECTS = $(subst mscz,mxl,$(SOURCES))
MSCORE = mscore
#/backup/Arch/Install/MuseScore-Studio-4.5.2.251141401-x86_64.AppImage
all: compile

.any:

	
compile: $(OBJECTS) replicate
	echo $(OBJECTS)

%.mxl : %.mscz
	mkdir -p build
	$(MSCORE) -f $< -o build/temp2.xml || true
	python3 scripts/process.py build/temp2.xml build/temp.xml
	$(MSCORE) -f build/temp.xml -o $@ || true

generate: .any
	python3 scripts/generate.py

replicate: .any
	mkdir -p website/site
	cp -Rvn music/* website/site || true
	cp -Rvn manual/* website/site || true
	rm -f website/site/alltunes.zip
	zip -r -j -q website/site/alltunes.zip music
	zip -q -d website/site/alltunes.zip *.mxl

website: .any generate 
	cp -Rvn music/* website/docs || true	
	cp -Rvn manual/* website/docs || true	
	cd website ; mkdocs -q build

server: .any website
	cp -Rvn music/* website/docs || true	
	cp -Rvn manual/* website/docs || true	
	cd website ; mkdocs -q serve

upload: .any website replicate
	sh upload.sh
