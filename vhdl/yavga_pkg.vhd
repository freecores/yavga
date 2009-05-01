--      Package File Template
--
--      Purpose: This package defines supplemental types, subtypes, 
--               constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;

package yavga_pkg is

-- Declare constants

  -- chars address and data bus size
  constant c_CHR_ADDR_BUS_W : integer := 11;
  constant c_CHR_DATA_BUS_W : integer := 32;
  constant c_CHR_WE_BUS_W   : integer := 4;

  -- internal used chars address and data bus size 
  constant c_INTCHR_ADDR_BUS_W : integer := 13;
  constant c_INTCHR_DATA_BUS_W : integer := 8;

  -- internal ROM chmaps address and data bus
  constant c_INTCHMAP_ADDR_BUS_W : integer := 11;
  constant c_INTCHMAP_DATA_BUS_W : integer := 8;

  -- waveform address and data bus size
  constant c_WAVFRM_ADDR_BUS_W : integer := 10;
  constant c_WAVFRM_DATA_BUS_W : integer := 16;

  constant c_GRID_SIZE : std_logic_vector(6 downto 0) := "1111111";
  constant c_GRID_BIT  : integer                      := 6;

  --
  -- horizontal timing signals (in pixels count )
  constant c_H_DISPLAYpx    : integer := 800;
  constant c_H_BACKPORCHpx  : integer := 63;  -- also 60;
  constant c_H_SYNCTIMEpx   : integer := 120;
  constant c_H_FRONTPORCHpx : integer := 56;  --also 60;
  constant c_H_PERIODpx     : integer := c_H_DISPLAYpx +
                                         c_H_BACKPORCHpx +
                                         c_H_SYNCTIMEpx +
                                         c_H_FRONTPORCHpx;
  constant c_H_COUNT_W : integer := 11;       -- = ceil(ln2(c_H_PERIODpx))

  --
  -- vertical timing signals (in lines count)
  constant c_V_DISPLAYln    : integer := 600;
  constant c_V_BACKPORCHln  : integer := 23;
  constant c_V_SYNCTIMEln   : integer := 6;
  constant c_V_FRONTPORCHln : integer := 37;
  constant c_V_PERIODln     : integer := c_V_DISPLAYln +
                                         c_V_BACKPORCHln +
                                         c_V_SYNCTIMEln +
                                         c_V_FRONTPORCHln;
  constant c_V_COUNT_W : integer := 10;  -- = ceil(ln2(c_V_PERIODln))

  constant c_X_W : integer := c_H_COUNT_W;
  constant c_Y_W : integer := c_V_COUNT_W;

--  constant c_CHARS_WIDTH: std_logic_vector(2 downto 0) := "111";
--  constant c_CHARS_HEIGHT: std_logic_vector(3 downto 0) := "1111";
--  constant c_CHARS_COLS: std_logic_vector(6 downto 0) := "1100011";
--  constant c_CHARS_ROWS: std_logic_vector(5 downto 0) := "100100";

  -- to manage the background and cursor colors
  constant c_CFG_BG_CUR_COLOR_ADDR : std_logic_vector(12 downto 0) := "0000001101100";  -- 108 BG:5..3 CUR:2..0

  -- to manage the cursor position  
  constant c_CFG_CURS_XY1 : std_logic_vector(12 downto 0) := "0000001101101";  -- 109
  constant c_CFG_CURS_XY2 : std_logic_vector(12 downto 0) := "0000001101110";  -- 110
  constant c_CFG_CURS_XY3 : std_logic_vector(12 downto 0) := "0000001101111";  -- 111
  
end yavga_pkg;


package body yavga_pkg is

end yavga_pkg;
