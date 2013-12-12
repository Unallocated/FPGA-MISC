--------------------------------------------------------------------------------
-- File       : lll_block.vhd
-- Author     : Xilinx Inc.
--------------------------------------------------------------------------------
-- (c) Copyright 2002-2008 Xilinx, Inc. All rights reserved.
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
--------------------------------------------------------------------------------
-- Description: This Core Block Level wrapper instantiates IOB flip-flops
--              and input/output buffers on the TBI interface of the
--              core.
--
--              All of the clock circuitry required for a single
--              instance of the core is included.
--
--
--            ----------------------------------------------
--            |          Core Block Level wrapper          |
--            |                                            |
--            |           -----------------------          |
--            |           |        Core         |          |
--            |           |                     |          |
--            |           |                     |          |
--            |           |                     |          |
--       ---------------->| GMII            TBI |--------------->
--            |           | Tx              Tx  |          |
--            |           |                     |          |
--            |           |                     |    TBI   |
--            |           |                     |    IOBs  |
--            |           |                     |          |
--            |           |                     |          |
--            |           | GMII            TBI |          |
--       <----------------| Rx              Rx  |<---------------
--            |           |                     |          |
--            |           -----------------------          |
--            |                                            |
--            |                                            |
--            ----------------------------------------------
--
--


library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;


--------------------------------------------------------------------------------
-- The entity declaration for the Core Block Level wrapper.
--------------------------------------------------------------------------------

entity lll_block is
      port(
      -- TBI Interface (PCS <=> PMA)
      ------------------------------

      gtx_clk              : in std_logic;                     -- Reference 125MHz clock.
      tx_code_group        : out std_logic_vector(9 downto 0); -- The ten bit parallel transmit data presented to the PMA.
      pma_tx_clk           : out std_logic;                    -- The 125 MHz transmit code group clock.
      loc_ref              : out std_logic;                    -- Causes the SERDES clock recovery to lock to PMA_TX_CLK.
      ewrap                : out std_logic;                    -- This instructs the PMA to loopback the data.
      rx_code_group        : in std_logic_vector(9 downto 0);  -- The ten bit parallel received data from the PMA.
      pma_rx_clk0          : in std_logic;                     -- 62.5MHz rx clock used to reclock even code-groups.
      en_cdet              : out std_logic;                    -- Enables the PMA sublayer to perform the code-group alignment function on a comma.

      -- GMII Interface (client MAC <=> PCS)
      --------------------------------------

      gmii_txd             : in  std_logic_vector(7 downto 0); -- Transmit data from client MAC.
      gmii_tx_en           : in  std_logic;                    -- Transmit control signal from client MAC.
      gmii_tx_er           : in  std_logic;                    -- Transmit control signal from client MAC.
      gmii_rxd             : out std_logic_vector(7 downto 0); -- Received Data to client MAC.
      gmii_rx_dv           : out std_logic;                    -- Received control signal to client MAC.
      gmii_rx_er           : out std_logic;                    -- Received control signal to client MAC.
      gmii_isolate         : out std_logic;                    -- Tristate control to electrically isolate GMII.

      -- Management: MDIO Interface
      -----------------------------

      mdc                  : in  std_logic;                    -- Management Data Clock
      mdio_i               : in  std_logic;                    -- Management Data In
      mdio_o               : out std_logic;                    -- Management Data Out
      mdio_t               : out std_logic;                    -- Management Data Tristate
      phyad                : in std_logic_vector(4 downto 0);  -- Port address for MDIO.
      configuration_vector : in std_logic_vector(4 downto 0);  -- Alternative to MDIO interface.
      configuration_valid  : in std_logic;                     -- Validation signal for Config vector.

      an_interrupt         : out std_logic;                    -- Interrupt to processor to signal that Auto-Negotiation has completed
      an_adv_config_vector : in std_logic_vector(15 downto 0); -- Alternate interface to program REG4 (AN ADV)
      an_adv_config_val    : in std_logic;                     -- Validation signal for AN ADV
      an_restart_config    : in std_logic;                     -- Alternate signal to modify AN restart bit in REG0
      link_timer_value     : in std_logic_vector(8 downto 0);  -- Programmable Auto-Negotiation Link Timer Control

      -- General IO's
      ---------------

      -- the following two ports are to enable the 200ms DCM reset to be
      -- bypassed during simulation
      -- NOTE: These should be tied together for normal operation
      rx_dcm_reset_200ms    : out std_logic;
      rx_dcm_reset_200ms_in : in  std_logic;

      status_vector        : out std_logic_vector(15 downto 0); -- Core status.
      reset                : in std_logic;                     -- Asynchronous reset for entire core.
      signal_detect        : in std_logic                      -- Input from PMD to indicate presence of optical input.
      );
end lll_block;


architecture block_level of lll_block is



  ------------------------------------------------------------------------------
  -- Component Declaration for the 1000BASE-X PCS/PMA sublayer core.
  ------------------------------------------------------------------------------
   component lll
      port(

      -- TBI Interface (PCS <=> PMA)
      ------------------------------

      gtx_clk              : in std_logic;                     -- 125MHz Reference clock.
      tx_code_group        : out std_logic_vector(9 downto 0); -- The ten bit parallel transmit data presented to the PMA.
      loc_ref              : out std_logic;                    -- Causes the TBI clock recovery to lock to PMA_TX_CLK.
      ewrap                : out std_logic;                    -- This instructs the PMA to loopback the data.
      rx_code_group0       : in std_logic_vector(9 downto 0);  -- The ten bit parallel received on PMA_RX_CLK0.
      rx_code_group1       : in std_logic_vector(9 downto 0);  -- The ten bit parallel received on PMA_RX_CLK1.
      pma_rx_clk0          : in std_logic;                     -- 62.5MHz rx clock used to reclock even code-groups.
      pma_rx_clk1          : in std_logic;                     -- 62.5MHz rx clock used to reclock odd code-groups.
      en_cdet              : out std_logic;                    -- Enables the PMA sublayer to perform the code-group alignment function on a comma.

      -- GMII Interface (client MAC <=> PCS)
      --------------------------------------

      gmii_txd             : in std_logic_vector(7 downto 0);  -- Transmit data from client MAC.
      gmii_tx_en           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_tx_er           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_rxd             : out std_logic_vector(7 downto 0); -- Received Data to client MAC.
      gmii_rx_dv           : out std_logic;                    -- Received control signal to client MAC.
      gmii_rx_er           : out std_logic;                    -- Received control signal to client MAC.
      gmii_isolate         : out std_logic;                    -- Tristate control to electrically isolate GMII.

      -- Management: MDIO Interface
      -----------------------------

      mdc                  : in    std_logic;                  -- Management Data Clock
      mdio_in              : in    std_logic;                  -- Management Data In
      mdio_out             : out   std_logic;                  -- Management Data Out
      mdio_tri             : out   std_logic;                  -- Management Data Tristate
      phyad                : in std_logic_vector(4 downto 0);  -- Port address to for MDIO to recognise.
      configuration_vector : in std_logic_vector(4 downto 0);  -- Alternative to MDIO interface.
      configuration_valid  : in std_logic;                     -- Validation signal for Config vector.

      an_interrupt         : out std_logic;                    -- Interrupt to processor to signal that Auto-Negotiation has completed
      an_adv_config_vector : in std_logic_vector(15 downto 0); -- Alternate interface to program REG4 (AN ADV)
      an_adv_config_val    : in std_logic;                     -- Validation signal for AN ADV
      an_restart_config    : in std_logic;                     -- Alternate signal to modify AN restart bit in REG0
      link_timer_value     : in std_logic_vector(8 downto 0);  -- Programmable Auto-Negotiation Link Timer Control

      -- General IO's
      ---------------
      status_vector        : out std_logic_vector(15 downto 0); -- Core status.
      reset                : in std_logic;                     -- Asynchronous reset for entire core.
      signal_detect        : in std_logic                      -- Input from PMD to indicate presence of optical input.
      );

   end component;



  ------------------------------------------------------------------------------
  -- Component Declaration for the DCM Reset Logic.
  ------------------------------------------------------------------------------
  component lll_dcm_reset
    port(
      reset                : in std_logic;                     -- Asynchronous reset
      ref_clk              : in std_logic;                     -- Reliable reference clock of known frequency (125MHz)
      dcm_locked           : in  std_logic;                    -- The DCM locked signal
      dcm_reset            : out std_logic                     -- The reset signal which should be connected to the DCM
    );
  end component;



  ------------------------------------------------------------------------------
  -- internal signals used in this Block level wrapper.
  ------------------------------------------------------------------------------

  -- TBI signals
  signal tx_code_group_int : std_logic_vector(9 downto 0);     -- Internal tx_code_group signal.
  signal rx_code_group0_reg: std_logic_vector(9 downto 0);     -- rx_code_group registered in IOBs on PMA_RX_CLK0.
  signal rx_code_group1_reg: std_logic_vector(9 downto 0);     -- rx_code_group registered in IOBs on PMA_RX_CLK1.
  signal pma_rx_clk0_dcm   : std_logic;                        -- pma_rx_clk0 is routed to a DCM.  This signal is the DCM CLK0 output.
  signal pma_rx_clk0_bufg  : std_logic;                        -- pma_rx_clk0 routed through a BUFG.
  signal ewrap_int         : std_logic;                        -- Internal ewrap signal.
  signal en_cdet_int       : std_logic;                        -- Internal en_cdet signal.

  -- Reset circuirty signals for the DCM on PMA_RX_CLK0
  signal dcm_locked0       : std_logic;                        -- locked signal of DCM.
  signal dcm_reset0        : std_logic;                        -- DCM reset, at least 3 clock periods in duration.


begin



  ------------------------------------------------------------------------------
  -- Instantiate the core
  ------------------------------------------------------------------------------

  gig_eth_pcs_pma_core : lll
    port map (
      gtx_clk              => gtx_clk,
      tx_code_group        => tx_code_group_int,
      loc_ref              => loc_ref,
      ewrap                => ewrap_int,
      rx_code_group0       => rx_code_group0_reg,
      rx_code_group1       => rx_code_group1_reg,
      pma_rx_clk0          => pma_rx_clk0_bufg,
      pma_rx_clk1          => pma_rx_clk0_bufg,
      en_cdet              => en_cdet_int,
      gmii_txd             => gmii_txd,
      gmii_tx_en           => gmii_tx_en,
      gmii_tx_er           => gmii_tx_er,
      gmii_rxd             => gmii_rxd,
      gmii_rx_dv           => gmii_rx_dv,
      gmii_rx_er           => gmii_rx_er,
      gmii_isolate         => gmii_isolate,
      mdc                  => mdc,
      mdio_in              => mdio_i,
      mdio_out             => mdio_o,
      mdio_tri             => mdio_t,
      phyad                => phyad,
      configuration_vector => configuration_vector,
      configuration_valid  => configuration_valid,
      an_interrupt         => an_interrupt,
      an_adv_config_vector => an_adv_config_vector,
      an_adv_config_val    => an_adv_config_val,
      an_restart_config    => an_restart_config,
      link_timer_value     => link_timer_value,
      status_vector        => status_vector,
      reset                => reset,
      signal_detect        => signal_detect

      );


  ------------------------------------------------------------------------------
  -- TBI Transmitter Clock Management : derive pma_tx_clk from gtx_clk
  ------------------------------------------------------------------------------

  -- Instantiate a DDR output register.  This is a good way to drive
  -- pma_tx_clk since the clock-to-PAD delay will be the same as that
  -- for data driven from IOB Ouput flip-flops eg tx_code_group[9:0].
  -- This is set to produce an inverted clock w.r.t. gtx_clk so
  -- that the rising edge is centralised within the tx_code_group[9:0]
  -- valid window.

  pma_tx_clk_ddr_iob : ODDR
  port map(
      Q  => pma_tx_clk,

      C  => gtx_clk,
      CE => '1',
      D1 => '0',
      D2 => '1',
      R  => '0',
      S  => '0'
    );



   -----------------------------------------------------------------------------
   -- TBI Transmitter Logic : drive TX signals through IOBs onto TBI
   -----------------------------------------------------------------------------

   -- Infer IOB Output flip-flops.
   output_tx_ffs : process (gtx_clk)
   begin
      if gtx_clk'event and gtx_clk = '1' then
         tx_code_group <= tx_code_group_int;
      end if;
   end process output_tx_ffs;


   -----------------------------------------------------------------------------
   -- TBI Control Signals : drive TBI control through IOBs signals onto
   -- TBI
   -----------------------------------------------------------------------------

   -- Infer IOB Output flip-flops.
   output_ffs : process (gtx_clk)
   begin
      if gtx_clk'event and gtx_clk = '1' then
         ewrap   <= ewrap_int;
         en_cdet <= en_cdet_int;

      end if;
   end process output_ffs;


  ------------------------------------------------------------------------------
  -- TBI Receiver Clock Management : receive PMA_RX_CLK0/PMA_RX_CLK1
  -- through IOBs from TBI
  ------------------------------------------------------------------------------

   -- A DCM must be used with Virtex4 devices to meet the TBI input
   -- setup and hold specifications.
   -- Note: Phase shift is set in UCF file.
   tbi_rx_clk0_dcm : DCM
      port map (
         CLKIN    => pma_rx_clk0,
         CLKFB    => pma_rx_clk0_bufg,
         DSSEN    => '0',
         PSINCDEC => '0',
         PSEN     => '0',
         PSCLK    => '0',
         RST      => rx_dcm_reset_200ms_in,
         CLK0     => pma_rx_clk0_dcm,
         STATUS   => open,
         PSDONE   => open,
         LOCKED   => dcm_locked0,
         CLKFX180 => open,
         CLKFX    => open,
         CLKDV    => open,
         CLK90    => open,
         CLK2X180 => open,
         CLK2X    => open,
         CLK270   => open,
         CLK180   => open
         );

   -- Route DCM outputs through BUFGs onto global clock networks
   bufg_pma_rx_clk0 : BUFG
     port map (I   => pma_rx_clk0_dcm,
               O   => pma_rx_clk0_bufg);


   -- Instantiate DCM reset circuitry
   dcm_reset_logic0 : lll_dcm_reset
    port map(
        reset      => reset,
        ref_clk    => gtx_clk,
        dcm_locked => dcm_locked0,
        dcm_reset  => rx_dcm_reset_200ms
    );



  ------------------------------------------------------------------------------
  -- TBI Receiver Logic : receive RX signals through IOBs from TBI
  ------------------------------------------------------------------------------

   tbi_rx_data_bus: for I in 9 downto 0 generate
   begin

     -- Instantiate Double-Data_Rate Registers synchronous to pma_rx_clk0.
     rx_code_group_ddr : IDDR
       generic map (
         DDR_CLK_EDGE => "SAME_EDGE")
       port map (
         Q1 => rx_code_group0_reg(I),
         Q2 => rx_code_group1_reg(I),
         C  => pma_rx_clk0_bufg,
         CE => '1',
         D  => rx_code_group(I),
         R  => reset,
         S  => '0');

   end generate;



end block_level;

