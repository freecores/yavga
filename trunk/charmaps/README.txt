########################################################
#### This file is part of the yaVGA project         ####
#### http://www.opencores.org/?do=project&who=yavga ####
########################################################

FIles:

charmaps_ROM.vhd
  chdl chunk to be completed with the output of convert.sh

chars.map
  the char maps (- = pixel off ; @ = pixel on)

convert.sh
  this file read the chars.map and write to to the standard output
  a vhdl chunk to insert in the charmaps_ROM.vhd

