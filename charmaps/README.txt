########################################################
#### This file is part of the yaVGA project         ####
#### http://www.opencores.org/?do=project&who=yavga ####
########################################################

FIles:

charmaps_ROM.vhd
  vhdl rom generated by convert.sh

charmaps_ROM.vhd_head
  vhdl head chunk

charmaps_ROM.vhd_tail
  vhdl tail chunk

chars.map
  the char maps (- = pixel off ; @ = pixel on)

convert.sh
  this file read the chars.map and write to to the standard output
  a vhdl chunk to insert in the charmaps_ROM.vhd

