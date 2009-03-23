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

entity charmaps_ROM is
  port (
    -- i_DI    : in std_logic_vector(7 downto 0);    -- 8-bit Data Input
    -- i_DIP   : in std_logic;                       -- 1-bit parity Input
    -- i_EN    : in std_logic;                       -- RAM Enable Input
    -- i_WE    : in std_logic;                       -- Write Enable Input
    -- i_SSR   : in std_logic;                       -- Synchronous Set/Reset Input
    i_clock : in  std_logic;                      -- Clock
    i_ADDR  : in  std_logic_vector(10 downto 0);  -- 11-bit Address Input
    o_DO    : out std_logic_vector(7 downto 0)    -- 8-bit Data Output
    -- o_DOP    : out std_logic                      -- 1-bit parity Output
    );
end charmaps_ROM;

architecture rtl of charmaps_ROM is

begin
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
      INIT_00    => X"000000FF0000FF0000FF0000FF00000000000000000000000000000000000000",
      INIT_01    => X"0000242424242424242424242424000000000000FF0000FF0000FF0000FF0000",
      INIT_02    => X"0000929292929292929292929292000000004949494949494949494949490000",
      INIT_03    => X"0000AAAAAAAAAAAAAAAAAAAAAAAA000000005555555555555555555555550000",
      INIT_04    => X"0000F3FCF3FCF3FCF3FCF3FCF3FC00000000FF00FF00FF00FF00FF00FF000000",
      INIT_05    => X"00000C030C030C030C030C030C0300000000CF3FCF3FCF3FCF3FCF3FCF3F0000",
      INIT_06    => X"00000066666666000066666666000000000030C030C030C030C030C030C00000",
      INIT_07    => X"00000F0F0F0F0F0F0F0F0F0F0F0F00000000FF99999999FFFF99999999FF0000",
      INIT_08    => X"0000000000000000FFFFFFFFFFFF00000000F0F0F0F0F0F0F0F0F0F0F0F00000",
      INIT_09    => X"00000F0F0F0F0F0F0F0F0F0F0F0F00000000FFFFFFFFFFFF0000000000000000",
      INIT_0A    => X"0000007E42424242424242427E0000000000F0F0F0F0F0F0F0F0F0F0F0F00000",
      INIT_0B    => X"000024492449244924492449244900000000FF81818181818181818181FF0000",
      INIT_0C    => X"0000499249924992499249924992000000002492249224922492249224920000",
      INIT_0D    => X"0000AA55AA55AA55AA55AA55AA550000000055AA55AA55AA55AA55AA55AA0000",
      INIT_0E    => X"0000DB6DDB6DDB6DDB6DDB6DDB6D00000000DBB6DBB6DBB6DBB6DBB6DBB60000",
      INIT_0F    => X"0000FFFFFFFFFFFFFFFFFFFFFFFF00000000B66DB66DB66DB66DB66DB66D0000",
      INIT_10    => X"0000001000001010101010101010000000000000000000000000000000000000",
      INIT_11    => X"0000004444FE4444444444FE4444000000000000000000000044444444440000",
      INIT_12    => X"0000000C12924C2010086492906000000000007C921212127C909090927C0000",
      INIT_13    => X"000000000000000000101010101000000000007A84848A507090888848300000",
      INIT_14    => X"0000001008080404040404080810000000000010202040404040402020100000",
      INIT_15    => X"0000000010101010FE101010100000000000009292545438FE38545492920000",
      INIT_16    => X"0000000000000000FE0000000000000000000020100808000000000000000000",
      INIT_17    => X"0000000000804020100804020000000000000000001818000000000000000000",
      INIT_18    => X"0000003810101010101010503010000000000038448282A2928A828244380000",
      INIT_19    => X"0000007C820202027C020202827C0000000000FE808080807C020202827C0000",
      INIT_1A    => X"0000007C820202027C80808080FE00000000001C080808FE8888482818080000",
      INIT_1B    => X"00000038101010101008040202FE00000000007C828282827C808080807E0000",
      INIT_1C    => X"000000FC020202027C828282827C00000000007C828282827C828282827C0000",
      INIT_1D    => X"0000002010080800000018180000000000000000001818000000181800000000",
      INIT_1E    => X"0000000000FE0000000000FE000000000000000000020C30C0300C0200000000",
      INIT_1F    => X"0000001000101008040282824438000000000000008060180618608000000000",
      INIT_20    => X"00000082828244447C442828281000000000003C42809EA2A29E828244380000",
      INIT_21    => X"0000007C8280808080808080827C0000000000FC82828284F884828282FC0000",
      INIT_22    => X"000000FE80808080FC80808080FE0000000000F8848482828282848488F00000",
      INIT_23    => X"0000007C828282829E808080827C00000000008080808080FC80808080FE0000",
      INIT_24    => X"0000003810101010101010101038000000000082828282827C82828282820000",
      INIT_25    => X"0000008282848488F088848482820000000000708888080808080808081C0000",
      INIT_26    => X"000000828282829292AAAAAAC6820000000000FE808080808080808080800000",
      INIT_27    => X"0000007C8282828282828282827C000000000082868A8A8A92A2A2A2C2820000",
      INIT_28    => X"0000007A848AB28282828282827C00000000008080808080FC828282827C0000",
      INIT_29    => X"0000007C820202027C808080827C000000000082848890A0FC828282827C0000",
      INIT_2A    => X"0000007C82828282828282828282000000000010101010101010101092FE0000",
      INIT_2B    => X"00000082C6AAAAAA929282828282000000000010102828284444448282820000",
      INIT_2C    => X"0000001010101010282844448282000000000082824444283828444482820000",
      INIT_2D    => X"00000038202020202020202020380000000000FE824040203808040482FE0000",
      INIT_2E    => X"0000003808080808080808080838000000000000000204081020408000000000",
      INIT_2F    => X"000000FE00000000000000000000000000000000000000000082442810000000",
      INIT_30    => X"0000003AC6828282C63A00000000000000000000000000000008101020200000",
      INIT_31    => X"0000003CC2808080C23C000000000000000000B8C6828282C6B8808080800000",
      INIT_32    => X"00000038C680FC82C6380000000000000000003AC6828282C63A020202020000",
      INIT_33    => X"00000038C6027E82C638000000000000000000808080808080F88080423C0000",
      INIT_34    => X"0000000C1210101010100000100000000000008282828282C6B8808080800000",
      INIT_35    => X"000000828488B0C0B88680808000000000000070880404040404000004000000",
      INIT_36    => X"0000009292929292D2AC0000000000000000000E102020202020202020200000",
      INIT_37    => X"00000038C6828282C6380000000000000000008282828282C6B8000000000000",
      INIT_38    => X"0000000202027E82C63A000000000000000000808080FC82C6B8000000000000",
      INIT_39    => X"0000007C82027E80827C0000000000000000008080808080C6B8000000000000",
      INIT_3A    => X"0000003AC682828282820000000000000000003C4280808080F8808080800000",
      INIT_3B    => X"0000006C92929292928200000000000000000010284482828282000000000000",
      INIT_3C    => X"0000003008083C42820000000000000000000082443828448200000000000000",
      INIT_3D    => X"00000010202020408040202020100000000000FE40300804FE00000000000000",
      INIT_3E    => X"0000001008080804020408080810000000000010101010101010101010100000",
      INIT_3F    => X"00000000000000000000000000000000000000000000000C9260000000000000",
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
      EN   => '1',                      -- RAM Enable Input
      WE   => '0',                      -- Write Enable Input
      SSR  => '0',                      -- Synchronous Set/Reset Input
      CLK  => i_clock,                  -- Clock
      ADDR => i_ADDR,                   -- 11-bit Address Input
      DO   => o_DO,                     -- 8-bit Data Output
      DOP  => open                      -- 1-bit parity Output
      );


end rtl;
