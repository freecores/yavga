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

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity waveform_RAM is
  port (
    i_DIA    : in  std_logic_vector(15 downto 0);  -- 16-bit Data Input
    -- i_DIPA   : in std_logic;                       -- 2-bit parity Input
    -- i_ENA    : in std_logic;                       -- RAM Enable Input
    i_WEA    : in  std_logic;                      -- Write Enable Input
    -- i_SSRA   : in std_logic;                       -- Synchronous Set/Reset Input
    i_clockA : in  std_logic;                      -- Clock
    i_ADDRA  : in  std_logic_vector(9 downto 0);   -- 10-bit Address Input
    --o_DOA     : out std_logic_vector(15 downto 0);  -- 16-bit Data Output
    -- o_DOPA   : out std_logic                       -- 2-bit parity Output
    --
    i_DIB    : in  std_logic_vector(15 downto 0);  -- 16-bit Data Input
    -- i_DIPB   : in std_logic;                       -- 2-bit parity Input
    -- i_ENB    : in std_logic;                       -- RAM Enable Input
    i_WEB    : in  std_logic;                      -- Write Enable Input
    -- i_SSRB   : in std_logic;                       -- Synchronous Set/Reset Input
    i_clockB : in  std_logic;                      -- Clock
    i_ADDRB  : in  std_logic_vector(9 downto 0);   -- 10-bit Address Input
    o_DOB    : out std_logic_vector(15 downto 0)   -- 16-bit Data Output
    -- o_DOPB   : out std_logic                       -- 2-bit parity Output
    );
end waveform_RAM;

architecture rtl of waveform_RAM is

begin
  -- wave form or video-line memory
  -- |------| |-------------------------------------------|
  -- | P  P | |  D  D  D |  D  D  D | D D D D D D D D D D |
  -- |======| |===========================================|
  -- |17 16 | | 15 14 13 | 12 11 10 | 9 8 7 6 5 4 3 2 1 0 |
  -- |======| |===========================================|
  -- | Free | |  Reserv. |  R  G  B |      vert. pos.     |
  -- |------| |-------------------------------------------|
  --

  Inst_waveform_RAM : RAMB16_S18_S18
    generic map (
      WRITE_MODE_A => "READ_FIRST",     -- "WRITE_FIRST";
      INIT_A       => B"000000000000000000",
      SRVAL_A      => B"000000000000000000",
      --                
      WRITE_MODE_B => "READ_FIRST",     -- "WRITE_FIRST";
      INIT_B       => B"000000000000000000",
      SRVAL_B      => B"000000000000000000",
      --
      --INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00      => X"112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C",
      INIT_01      => X"112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D",
      INIT_02      => X"112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E",
      INIT_03      => X"112F112F112F112F112F112F112F112F112F112F112F112F112F112F112F112F",
      INIT_04      => X"112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E",
      INIT_05      => X"112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D",
      INIT_06      => X"112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C",
      INIT_07      => X"112B112B112B112B112B112B112B112B112B112B112B112B112B112B112B112B",

      --INIT_08 => X"112A112A112A112A112A112A112A112A112A112A112A112A112A112A112A112A",
      INIT_08 => X"112A114011C211F4117C10FA110E112A112A112A112A112A112A112A112A192A",

      --INIT_09 => X"1129112911291129112911291129112911291129112911291129112911291129",
      INIT_09 => X"1129112911291129112911291129112911291129112911291129112911291529",

      INIT_0A  => X"1128112811281128112811281128112811281128112811281128112811281128",
      INIT_0B  => X"1127112711271127112711271127112711271127112711271127112711271127",
      INIT_0C  => X"1126112611261126112611261126112611261126112611261126112611261126",
      INIT_0D  => X"1125112511251125112511251125112511251125112511251125112511251125",
      INIT_0E  => X"1124112411241124112411241124112411241124112411241124112411241124",
      INIT_0F  => X"1123112311231123112311231123112311231123112311231123112311231123",
      --
      INIT_10  => X"1123112311231123112311231123112311231123112311231123112311231123",
      INIT_11  => X"1124112411241124112411241124112411241124112411241124112411241124",
      INIT_12  => X"1125112511251125112511251125112511251125112511251125112511251125",
      INIT_13  => X"1126112611261126112611261126112611261126112611261126112611261126",
      INIT_14  => X"1127112711271127112711271127112711271127112711271127112711271127",
      INIT_15  => X"1128112811281128112811281128112811281128112811281128112811281128",
      INIT_16  => X"1129112911291129112911291129112911291129112911291129112911291129",
      INIT_17  => X"112A112A112A112A112A112A112A112A112A112A112A112A112A112A112A112A",
      INIT_18  => X"112B112B112B112B112B112B112B112B112B112B112B112B112B112B112B112B",
      INIT_19  => X"112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C",
      INIT_1A  => X"112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D",
      INIT_1B  => X"112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E",
      INIT_1C  => X"112F112F112F112F112F112F112F112F112F112F112F112F112F112F112F112F",
      INIT_1D  => X"112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E",
      INIT_1E  => X"112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D",
      INIT_1F  => X"112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C",
      --
      INIT_20  => X"112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C",
      INIT_21  => X"112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D",
      INIT_22  => X"112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E",
      INIT_23  => X"112F112F112F112F112F112F112F112F112F112F112F112F112F112F112F112F",
      INIT_24  => X"112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E",
      INIT_25  => X"112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D",
      INIT_26  => X"112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C",
      INIT_27  => X"112B112B112B112B112B112B112B112B112B112B112B112B112B112B112B112B",
      INIT_28  => X"112A112A112A112A112A112A112A112A112A112A112A112A112A112A112A112A",
      INIT_29  => X"1129112911291129112911291129112911291129112911291129112911291129",
      INIT_2A  => X"1128112811281128112811281128112811281128112811281128112811281128",
      INIT_2B  => X"1127112711271127112711271127112711271127112711271127112711271127",
      INIT_2C  => X"1126112611261126112611261126112611261126112611261126112611261126",
      INIT_2D  => X"1125112511251125112511251125112511251125112511251125112511251125",
      INIT_2E  => X"1124112411241124112411241124112411241124112411241124112411241124",
      INIT_2F  => X"1123112311231123112311231123112311231123112311231123112311231123",
      --
      INIT_30  => X"1123112311231123112311231123112311231123112311231123112311231123",
      INIT_31  => X"1124112411241124112411241124112411241124112411241124112411241124",
      INIT_32  => X"1125112511251125112511251125112511251125112511251125112511251125",
      INIT_33  => X"1126112611261126112611261126112611261126112611261126112611261126",
      INIT_34  => X"1127112711271127112711271127112711271127112711271127112711271127",
      INIT_35  => X"1128112811281128112811281128112811281128112811281128112811281128",
      INIT_36  => X"1129112911291129112911291129112911291129112911291129112911291129",
      INIT_37  => X"112A112A112A112A112A112A112A112A112A112A112A112A112A112A112A112A",
      INIT_38  => X"112B112B112B112B112B112B112B112B112B112B112B112B112B112B112B112B",
      INIT_39  => X"112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C",
      INIT_3A  => X"112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D",
      INIT_3B  => X"112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E",
      INIT_3C  => X"112F112F112F112F112F112F112F112F112F112F112F112F112F112F112F112F",
      INIT_3D  => X"112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E112E",
      INIT_3E  => X"112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D112D",
      INIT_3F  => X"112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C112C",
      --
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000"
      )
    port map(
      DIA   => i_DIA,                   -- 16 bit data Input
      DIPA  => (others => '1'),         -- 2 bit data parity Input
      ENA   => '1',                     -- 1-bit RAM enable Input
      WEA   => i_WEA,                   -- 1-bit Write Enable Input
      SSRA  => '0',                     -- 1-bit Synchronous Set/Reset Input
      CLKA  => i_clockA,                -- 1-bit Clock Input
      ADDRA => i_ADDRA,                 -- 10-bit Address Input
      DOA   => open,  -- o_DOA,      -- 16-bit Data Output
      DOPA  => open,                    -- 2-bit Data Parity Output
      --
      DIB   => i_DIB,                   -- 16 bit data Input
      DIPB  => (others => '1'),         -- 2 bit data parity Input
      ENB   => '1',                     -- 1-bit RAM enable Input
      WEB   => i_WEB,                   -- 1-bit Write Enable Input
      SSRB  => '0',                     -- 1-bit Synchronous Set/Reset Input
      CLKB  => i_clockB,                -- 1-bit Clock Input
      ADDRB => i_ADDRB,                 -- 10-bit Address Input
      DOB   => o_DOB,                   -- 16-bit Data Output
      DOPB  => open                     -- 2-bit Data Parity Output
      );

end rtl;
