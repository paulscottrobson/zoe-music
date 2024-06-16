#
#		So I will learn AWK one day ....
#
import os,re,sys
h = open(sys.argv[2],"w")
for s in open(sys.argv[1]).readlines():
	s = s.rstrip()
	if s.find("print new-page") > 0:
		s = s.replace("yes","no")
	h.write(s+"\n")
h.close()

