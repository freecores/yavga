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

-- Uncomment the following lines to use the declarations that are
-- provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity chars_RAM is
  port (
    i_clock_rw : in  std_logic;         -- Write Clock
    i_EN_rw    : in  std_logic;         -- Write RAM Enable Input
    i_WE_rw    : in  std_logic_vector(c_CHR_WE_BUS_W - 1 downto 0);  -- Write Enable Input
    i_ADDR_rw  : in  std_logic_vector(10 downto 0);  -- Write 11-bit Address Input
    i_DI_rw    : in  std_logic_vector(31 downto 0);  -- Write 32-bit Data Input
    o_DI_rw    : out std_logic_vector(31 downto 0);  -- Write 32-bit Data Input

    i_SSR : in std_logic;               -- Synchronous Set/Reset Input

    i_clock_r : in  std_logic;          -- Read Clock
    i_EN_r    : in  std_logic;
    i_ADDR_r  : in  std_logic_vector(12 downto 0);  -- Read 13-bit Address Input
    o_DO_r    : out std_logic_vector(7 downto 0)    -- Read 8-bit Data Output
    );
end chars_RAM;

architecture Behavioral of chars_RAM is
  signal s0_DO_r : std_logic_vector(7 downto 0);
  signal s1_DO_r : std_logic_vector(7 downto 0);
  signal s2_DO_r : std_logic_vector(7 downto 0);
  signal s3_DO_r : std_logic_vector(7 downto 0);

  constant c_ram_size : natural := 2**(c_CHR_ADDR_BUS_W);

  type t_ram is array (c_ram_size-1 downto 0) of
    std_logic_vector (c_INTCHR_DATA_BUS_W - 1 downto 0);

  shared variable v_ram0 : t_ram := (
    27     => X"05",  -- config "bg and curs color" (108/4 = 27)
    1126   => X"53",                    -- S
    1127   => X"72",                    -- r
    1128   => X"6D",                    -- m
    1129   => X"20",                    --  
    1130   => X"64",                    -- d
    1131   => X"6D",                    -- m
    1132   => X"65",                    -- e
    1133   => X"61",                    -- a
    1134   => X"6E",                    -- n
    others => X"00"
    );

  shared variable v_ram1 : t_ram := (
    27     => X"07",  -- config "xy coords spans on three bytes" (108/4 = 27)
    1126   => X"61",                    -- a
    1127   => X"6F",                    -- o
    1128   => X"61",                    -- a
    1129   => X"2D",                    -- -
    1130   => X"72",                    -- r
    1131   => X"74",                    -- t
    1132   => X"74",                    -- t
    1133   => X"70",                    -- p
    1134   => X"65",                    -- e
    others => X"00"
    );

  shared variable v_ram2 : t_ram := (
    27     => X"09",  -- config "xy coords spans on three bytes" (108/4 = 27)
    1126   => X"6E",                    -- n
    1127   => X"20",                    --  
    1128   => X"74",                    -- t
    1129   => X"20",                    --  
    1130   => X"6F",                    -- o
    1131   => X"40",                    -- @
    1132   => X"73",                    -- s
    1133   => X"65",                    -- e
    1134   => X"74",                    -- t
    others => X"00"
    );

  shared variable v_ram3 : t_ram := (
    27     => X"5E",  -- config "xy coords spans on three bytes" (108/4 = 27)
    1126   => X"64",                    -- d
    1127   => X"41",                    -- A
    1128   => X"6F",                    -- o
    1129   => X"73",                    -- s
    1130   => X"61",                    -- a
    1131   => X"6E",                    -- n
    1132   => X"63",                    -- c
    1133   => X"2E",                    -- .
    1134   => X"20",                    --  
    others => X"00"
    );

begin

  p_rw0_port : process (i_clock_rw)
  begin
    if rising_edge(i_clock_rw) then
      if i_SSR = '1' then
        o_DI_rw(31 downto 24) <= (others => '0');
      elsif (i_EN_rw = '1') then
        o_DI_rw(31 downto 24) <= v_ram0(conv_integer(i_ADDR_rw));
        if (i_WE_rw(0) = '1') then
          v_ram0(conv_integer(i_ADDR_rw)) := i_DI_rw(31 downto 24);
        end if;
      end if;
    end if;
  end process;

  p_rw1_port : process (i_clock_rw)
  begin
    if rising_edge(i_clock_rw) then
      if i_SSR = '1' then
        o_DI_rw(23 downto 16) <= (others => '0');
      elsif (i_EN_rw = '1') then
        o_DI_rw(23 downto 16) <= v_ram1(conv_integer(i_ADDR_rw));
        if (i_WE_rw(1) = '1') then
          v_ram1(conv_integer(i_ADDR_rw)) := i_DI_rw(23 downto 16);
        end if;
      end if;
    end if;
  end process;

  p_rw2_port : process (i_clock_rw)
  begin
    if rising_edge(i_clock_rw) then
      if i_SSR = '1' then
        o_DI_rw(15 downto 8) <= (others => '0');
      elsif (i_EN_rw = '1') then
        o_DI_rw(15 downto 8) <= v_ram2(conv_integer(i_ADDR_rw));
        if (i_WE_rw(2) = '1') then
          v_ram2(conv_integer(i_ADDR_rw)) := i_DI_rw(15 downto 8);
        end if;
      end if;
    end if;
  end process;

  p_rw3_port : process (i_clock_rw)
  begin
    if rising_edge(i_clock_rw) then
      if i_SSR = '1' then
        o_DI_rw(7 downto 0) <= (others => '0');
      elsif (i_EN_rw = '1') then
        o_DI_rw(7 downto 0) <= v_ram3(conv_integer(i_ADDR_rw));
        if (i_WE_rw(3) = '1') then
          v_ram3(conv_integer(i_ADDR_rw)) := i_DI_rw(7 downto 0);
        end if;
      end if;
    end if;
  end process;


  p_ro0_port : process (i_clock_r)
  begin
    if rising_edge(i_clock_r) then
      if i_SSR = '1' then
        s0_DO_r <= (others => '0');
      elsif (i_EN_r = '1') then
        s0_DO_r <= v_ram0(conv_integer(i_ADDR_r(i_ADDR_r'left downto 2)));
      end if;
    end if;
  end process;

  p_ro1_port : process (i_clock_r)
  begin
    if rising_edge(i_clock_r) then
      if i_SSR = '1' then
        s1_DO_r <= (others => '0');
      elsif (i_EN_r = '1') then
        s1_DO_r <= v_ram1(conv_integer(i_ADDR_r(i_ADDR_r'left downto 2)));
      end if;
    end if;
  end process;

  p_ro2_port : process (i_clock_r)
  begin
    if rising_edge(i_clock_r) then
      if i_SSR = '1' then
        s2_DO_r <= (others => '0');
      elsif (i_EN_r = '1') then
        s2_DO_r <= v_ram2(conv_integer(i_ADDR_r(i_ADDR_r'left downto 2)));
      end if;
    end if;
  end process;

  p_ro3_port : process (i_clock_r)
  begin
    if rising_edge(i_clock_r) then
      if i_SSR = '1' then
        s3_DO_r <= (others => '0');
      elsif (i_EN_r = '1') then
        s3_DO_r <= v_ram3(conv_integer(i_ADDR_r(i_ADDR_r'left downto 2)));
      end if;
    end if;
  end process;

  o_DO_r <=
    s0_DO_r when i_ADDR_r(1 downto 0) = "00" else
    s1_DO_r when i_ADDR_r(1 downto 0) = "01" else
    s2_DO_r when i_ADDR_r(1 downto 0) = "10" else
    s3_DO_r when i_ADDR_r(1 downto 0) = "11" else
    (others => 'X');
end Behavioral;
