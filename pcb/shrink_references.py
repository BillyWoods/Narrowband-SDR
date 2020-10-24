import re

f = open("SDR_board.kicad_pcb", "r")
f_out = open("SDR_board_mod.kicad_pcb", "w")
prev_line = ""

for line in f:
  line_mod = line
  if "fp_text reference" in prev_line and "Silk" in prev_line:
    #line_mod = line_mod.replace("size 0.6 0.6", "size 0.4 0.4")
    line_mod = line_mod.replace("thickness 0.02", "thickness 0.07")
    f_out.write(line_mod)
  else:
    f_out.write(line_mod)
  prev_line = line

f.close()
f_out.close()


