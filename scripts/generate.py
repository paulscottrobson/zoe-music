import os


for root,dirs,files in os.walk("website/docs"):
	name = root[13:].strip()
	if name != "":
		h = open("website/docs/"+name+".md","w")
		heading = name.replace("_"," ").title()
		h.write("## {0}\n\n".format(heading))
		files.sort()
		for f in files:
			if f.endswith(".mscz"):
				fStem = f[:-5]
				fName = fStem.replace("_"," ").title()
				h.write("- {0} [MuseScore](./{1}.mscz) [MusicXML](./{1}.mxl)\n".format(fName,fStem))
		h.close()