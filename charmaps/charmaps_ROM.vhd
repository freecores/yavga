--------------------------------------------------------------------------------
----                                                                        ----
---- This file is part of the yaVGA project                                 ----
---- http://www.opencores.org/?do=project&who=yavga                         ----
----                                                                        ----
---- Description                                                            ----
---- Implementation of yaVGA IP core                                        ----
----                                                                        ----
---- To Do:                                                                 ----
----                                                                        ----
----                                                                        ----
---- Author(s):                                                             ----
---- Sandro Amato, sdroamt@netscape.net                                     ----
----                                                                        ----
--------------------------------------------------------------------------------
----                                                                        ----
---- Copyright (c) 2009, Sandro Amato                                       ----
---- All rights reserved.                                                   ----
----                                                                        ----
---- Redistribution  and  use in  source  and binary forms, with or without ----
---- modification,  are  permitted  provided that  the following conditions ----
---- are met:                                                               ----
----                                                                        ----
----     * Redistributions  of  source  code  must  retain the above        ----
----       copyright   notice,  this  list  of  conditions  and  the        ----
----       following disclaimer.                                            ----
----     * Redistributions  in  binary form must reproduce the above        ----
----       copyright   notice,  this  list  of  conditions  and  the        ----
----       following  disclaimer in  the documentation and/or  other        ----
----       materials provided with the distribution.                        ----
----     * Neither  the  name  of  SANDRO AMATO nor the names of its        ----
----       contributors may be used to  endorse or  promote products        ----
----       derived from this software without specific prior written        ----
----       permission.                                                      ----
----                                                                        ----
---- THIS SOFTWARE IS PROVIDED  BY THE COPYRIGHT  HOLDERS AND  CONTRIBUTORS ----
---- "AS IS"  AND  ANY EXPRESS OR  IMPLIED  WARRANTIES, INCLUDING,  BUT NOT ----
---- LIMITED  TO, THE  IMPLIED  WARRANTIES  OF MERCHANTABILITY  AND FITNESS ----
---- FOR  A PARTICULAR  PURPOSE  ARE  DISCLAIMED. IN  NO  EVENT  SHALL  THE ----
---- COPYRIGHT  OWNER  OR CONTRIBUTORS  BE LIABLE FOR ANY DIRECT, INDIRECT, ----
---- INCIDENTAL,  SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, ----
---- BUT  NOT LIMITED  TO,  PROCUREMENT OF  SUBSTITUTE  GOODS  OR SERVICES; ----
---- LOSS  OF  USE,  DATA,  OR PROFITS;  OR  BUSINESS INTERRUPTION) HOWEVER ----
---- CAUSED  AND  ON  ANY THEORY  OF LIABILITY, WHETHER IN CONTRACT, STRICT ----
---- LIABILITY,  OR  TORT  (INCLUDING  NEGLIGENCE  OR OTHERWISE) ARISING IN ----
---- ANY  WAY OUT  OF THE  USE  OF  THIS  SOFTWARE,  EVEN IF ADVISED OF THE ----
---- POSSIBILITY OF SUCH DAMAGE.                                            ----
--------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

use work.yavga_pkg.all;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity charmaps_ROM is
  port (
    -- i_DI    : in std_logic_vector(7 downto 0);    -- 8-bit Data Input
    -- i_DIP   : in std_logic;                       -- 1-bit parity Input
    -- i_WE    : in std_logic;                       -- Write Enable Input
    -- i_SSR   : in std_logic;                       -- Synchronous Set/Reset Input
    i_EN    : in  std_logic;            -- RAM Enable Input
    i_clock : in  std_logic;            -- Clock
    i_ADDR  : in  std_logic_vector(c_INTCHMAP_ADDR_BUS_W - 1 downto 0);  -- 11-bit Address Input
    o_DO    : out std_logic_vector(c_INTCHMAP_DATA_BUS_W - 1 downto 0)  -- 8-bit Data Output
    -- o_DOP    : out std_logic                      -- 1-bit parity Output
    );
end charmaps_ROM;

architecture rtl of charmaps_ROM is
  signal s_EN : std_logic;
begin
  s_EN <= i_EN;
  -- charmaps
  -- |------| |-----------------|
  -- |   P  | | D D D D D D D D |
  -- |======| |=================|
  -- |   8  | | 7 6 5 4 3 2 1 0 |
  -- |======| |=================|
  -- | Free | | Row char pixels |
  -- |------| |-----------------|

  Inst_charmaps_rom : RAMB16_S9
    generic map (
      write_mode => "NO_CHANGE",   --  WRITE_FIRST, READ_FIRST or NO_CHANGE
      INIT       => B"000000000",  --  Value of output RAM registers at startup
      SRVAL      => B"000000000",       --  Ouput value upon SSR assertion
      --
      -- START REPLACE HERE THE OUTPUT FROM convert.sh
      -- INIT_00 => ...
      -- ...
      -- ...
      -- ...
      -- INIT_3F => ...
      -- STOP REPLACE
      --
      --
      INITP_00   => X"0000000000000000000000000000000000000000000000000000000000000000",  -- free
      INITP_01   => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02   => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03   => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04   => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05   => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06   => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07   => X"0000000000000000000000000000000000000000000000000000000000000000"
      )
    port map(
      DI   => (others => '1'),          -- 8-bit Data Input
      DIP  => (others => '1'),          -- 1-bit parity Input
      EN   => s_EN,                     -- RAM Enable Input
      WE   => '0',                      -- Write Enable Input
      SSR  => '0',                      -- Synchronous Set/Reset Input
      CLK  => i_clock,                  -- Clock
      ADDR => i_ADDR,                   -- 11-bit Address Input
      DO   => o_DO,                     -- 8-bit Data Output
      DOP  => open                      -- 1-bit parity Output
      );


end rtl;
