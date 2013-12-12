--------------------------------------------------------------------------------
-- File       : lll_dcm_reset.vhd
-- Author     : Xilinx
--------------------------------------------------------------------------------
-- (c) Copyright 2008 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES. 
-- 
-- 

--------------------------------------------------------------------------------
-- Description:  DCM Reset Logic.
--
--               The reset will fire under the following conditions:
--
--                  * When the DCM timeout counter wraps around
--                  * When the falling edge of DCM locked is detected
--
--               The timeout counter will time a > 1ms interval.  If the DCM
--               locked signal has been low for this duration then it will be
--               issued with a reset and the timer will reset.  This is
--               required for DCMs connected to Ethernet PHYs since the PHYs
--               may source discontinuous clocks under certain network
--               conditions.
--------------------------------------------------------------------------------

library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--------------------------------------------------------------------------------
-- The entity declaration for the DCM Reset Logic.
--------------------------------------------------------------------------------
entity lll_dcm_reset is
    port(
        reset                       : in  std_logic;            -- Synchronous reset in ref_clk domain
        ref_clk                     : in  std_logic;            -- Reliable reference clock of known frequency (125MHz)
        dcm_locked                  : in  std_logic;            -- The DCM locked signal
        dcm_reset                   : out std_logic             -- The reset signal which should be connected to the DCM
  );
end lll_dcm_reset;


architecture rtl of lll_dcm_reset is


  ------------------------------------------------------------------------------
  -- Component declaration for the synchronisation flip-flop pair
  ------------------------------------------------------------------------------
  component lll_sync_block
  port (
    clk                             : in  std_logic;            -- clock to be sync'ed to
    data_in                         : in  std_logic;            -- Data to be 'synced'
    data_out                        : out std_logic             -- synced data
    );
  end component;


  ------------------------------------------------------------------------------
  -- Signals used in this module
  ------------------------------------------------------------------------------

  -- signals required for DCM timeout reset in the reference clock domain
  signal dcm_locked_sync           : std_logic;                 -- dcm_locked registered twice in the reference clock domain.
  signal dcm_locked_sync_reg       : std_logic;                 -- dcm_locked registered thrice in the DCM clock domain.
  signal timeout_bit16_reg         : std_logic;
  signal timeout                   : unsigned(16 downto 0);     -- the timeout counter
  signal timeout_reset             : std_logic;                 -- a reset created by a timeout condition
  signal dcm_reset_init            : std_logic;                 -- automatic reset pulse applied to dcm on loss of lock.
  signal reset_counter             : unsigned(8 downto 0);
  signal reset_200ms_int           : std_logic;

  -- These attributes will stop timing errors from propogating in back annotated
  -- SDF simulation.
  attribute ASYNC_REG                  : string;
  attribute ASYNC_REG of timeout_reset : signal is "TRUE";


begin


  -------------------------
  -- Reference clock domain
  -------------------------

  -- The reference clock will always be present and of frequency 125MHz.  Since
  -- this clock is predictable, it is used to create the DCM timeout counter.
  -- This counter will increment when the locked signal is low (not locked).
  -- When the timer expires, a further reset of the DCM will be issued.

   -- Reclock DCM locked in the reference clock domain
   dcm_locked_sync_tx : lll_sync_block
   port map(
      clk            => ref_clk,
      data_in        => dcm_locked,
      data_out       => dcm_locked_sync
   );


   -- When the DCM is locked, the timeout counter is held at zero.
   -- When not locked the timeout counter will increment.
   dcm_timeout_counter : process (ref_clk)
   begin
     if ref_clk'event and ref_clk = '1' then
       if timeout_reset = '1' then
          timeout           <= (others => '0');
          timeout_bit16_reg <= '0';
       else
          timeout_bit16_reg <= timeout(16);
          if dcm_locked_sync = '1' and reset_200ms_int = '0' then
             timeout   <= (others => '0');
          else
             timeout   <= timeout + "00000000000000001";
          end if;
       end if;
     end if;
   end process dcm_timeout_counter;


   -- A reset pulse is generated when the timeout counter wraps around.
   dcm_timeout_reset_p : process (ref_clk, reset)
   begin
     if reset = '1' then
        timeout_reset <= '1';
     elsif ref_clk'event and ref_clk = '1' then
       timeout_reset <= (not timeout(16)) and timeout_bit16_reg
                            and (not dcm_locked_sync) and (not reset_200ms_int);
     end if;
   end process dcm_timeout_reset_p;


   -- Create a reset to fire under the following conditions:
   -- * When the DCM timeout counter wraps around
   -- * When the falling edge of DCM locked is detected
   reset_dcm_prelim: process (ref_clk)
   begin
      if ref_clk'event and ref_clk = '1' then
         if timeout_reset = '1' then
            dcm_locked_sync_reg  <= '1';
            dcm_reset_init       <= '1';
         else
            dcm_locked_sync_reg  <= dcm_locked_sync;
            dcm_reset_init       <= (not dcm_locked_sync) and dcm_locked_sync_reg;
         end if;
      end if;
   end process reset_dcm_prelim;


   -- generate a large counter to time ~200ms
   dcm_reset_timer_p : process (ref_clk)
   begin
      if ref_clk'event and ref_clk = '1' then
         if dcm_reset_init = '1' then
            reset_counter        <= "110000000";
            reset_200ms_int      <= '1';
         else
            if reset_counter = "000000000" then
               reset_200ms_int   <= '0';
            else
               reset_200ms_int   <= '1';

               if (timeout(16) xor timeout_bit16_reg) = '1' then
                  reset_counter  <= reset_counter - "000000001";
               end if;

            end if;
         end if;
      end if;
   end process dcm_reset_timer_p;


   -- This is the produced reset signal for the Virtex-4 DCM
   dcm_reset <= reset_200ms_int;


end rtl;

