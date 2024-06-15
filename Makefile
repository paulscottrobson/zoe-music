

SOURCES = $(wildcard *.mxl */*.mxl */*/*.mxl */*/*/*.mxl)
OBJECTS = $(subst mxl,mscz,$(SOURCES))

all: compile

compile: $(OBJECTS)

%.mscz : %.mxl
	echo $< $@
	mscore -f $< -o $@