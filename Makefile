
SOURCES = $(wildcard music/*.mxl music/*/*.mxl music/*/*/*.mxl music/*/*/*/*.mxl)
OBJECTS = $(subst mxl,mscz,$(SOURCES))
MSCORE = mscore
#/backup/Arch/Install/MuseScore-Studio-4.5.2.251141401-x86_64.AppImage
all: compile

.any:

	
compile: $(OBJECTS) replicate

%.mscz : %.mxl
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
	zip -r -j website/site/alltunes.zip music
	zip -d website/site/alltunes.zip *.mxl

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
