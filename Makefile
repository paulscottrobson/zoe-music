
SOURCES = $(wildcard *.mxl */*.mxl */*/*.mxl */*/*/*.mxl)
OBJECTS = $(subst mxl,mscz,$(SOURCES))

all: compile

compile: $(OBJECTS)

%.mscz : %.mxl
	mscore -f $< -o build/temp2.xml
	python3 scripts/process.py build/temp2.xml build/temp.xml
	mscore -f build/temp.xml -o $@