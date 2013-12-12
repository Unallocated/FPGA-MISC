--------------------------------------------------------------------------------
-- File       : lll_example_design.vhd
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
-- 
-- 
--------------------------------------------------------------------------------
-- Description: This is the top level vhdl example design for the
--              Ethernet 1000BASE-X PCS/PMA core.
--
--              This design example instantiates IOB flip-flops
--              and input/output buffers on the GMII.
--
--              A Transmitter Elastic Buffer is instantiated on the Tx
--              GMII path to perform clock compenstation between the
--              core and the external MAC driving the Tx GMII.
--
--              This design example can be synthesised.
--
--
--
--      -----------------------------------------------------------
--      |                        Example Design                   |
--      |                                                         |
--      |                -----------------------------------      |
--      |                |     Core Block (wrapper)        |      |
--      |                |                                 |      |
--      |                |    -----------------------      |      |
--      |   ---------    |    |        Core         |      |      |
--      |   |       |    |    |                     |      |      |
--      |   |  Tx   |    |    |                     |      |      |
--      |   |Elastic|    |    |                     |      |      |
--  --------|Buffer |-------->| GMII            TBI |------------------>
--      |   |       |    |    | Tx              Tx  |      |      |
--      |   ---------    |    |                     |      |      |
--      |                |    |                     | TBI  |      |
--      |  GMII          |    |                     | IOBs |      |
--      |  IOBs          |    |                     |      |      |
--      |                |    |                     |      |      |
--      |                |    | GMII            TBI |      |      |
--  <-------------------------| Rx              Rx  |<------------------
--      |                |    |                     |      |      |
--      |                |    -----------------------      |      |
--      |                |                                 |      |
--      |                -----------------------------------      |
--      |                                                         |
--      -----------------------------------------------------------
--
--


library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;


--------------------------------------------------------------------------------
-- The entity declaration for the example design
--------------------------------------------------------------------------------

entity lll_example_design is
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
      gmii_tx_clk          : in std_logic;                     -- Transmit clock from client MAC.
      gmii_rx_clk          : out std_logic;                    -- Receive clock to client MAC.
      gmii_txd             : in std_logic_vector(7 downto 0);  -- Transmit data from client MAC.
      gmii_tx_en           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_tx_er           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_rxd             : out std_logic_vector(7 downto 0); -- Received Data to client MAC.
      gmii_rx_dv           : out std_logic;                    -- Received control signal to client MAC.
      gmii_rx_er           : out std_logic;                    -- Received control signal to client MAC.
      -- Management: MDIO Interface
      -----------------------------

      mdc                  : in    std_logic;                  -- Management Data Clock
      mdio_i               : in    std_logic;                  -- Management Data In
      mdio_o               : out   std_logic;                  -- Management Data Out
      mdio_t               : out   std_logic;                  -- Management Data Tristate
      phyad                : in std_logic_vector(4 downto 0);  -- Port address for MDIO.
      configuration_valid  : in std_logic;                     -- Validation signal for Config vector.
      configuration_vector : in std_logic_vector(4 downto 0);  -- Alternative to MDIO interface.

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

      -- the following two ports are to enable the 200ms Tx DCM reset to be
      -- bypassed during simulation
      -- NOTE: These should be tied together for normal operation
      tx_dcm_reset_200ms    : out std_logic;
      tx_dcm_reset_200ms_in : in  std_logic;

      status_vector        : out std_logic_vector(15 downto 0); -- Core status.
      reset                : in std_logic;                     -- Asynchronous reset for entire core.
      signal_detect        : in std_logic                      -- Input from PMD to indicate presence of optical input.
      );
end lll_example_design;



architecture top_level of lll_example_design is



   -----------------------------------------------------------------------------
   -- Component Declaration for the Transmitter Elastic Buffer
   -----------------------------------------------------------------------------
   component lll_tx_elastic_buffer
   port (

      reset                : in std_logic;                     -- Asynchronous Reset.

      -- Signals received from the input gmii_tx_clk_wr domain.
      gmii_tx_clk_wr       : in std_logic;                     -- Write clock domain.
      gmii_txd_wr          : in std_logic_vector(7 downto 0);  -- gmii_txd synchronous to gmii_tx_clk_wr.
      gmii_tx_en_wr        : in std_logic;                     -- gmii_tx_en synchronous to gmii_tx_clk_wr.
      gmii_tx_er_wr        : in std_logic;                     -- gmii_tx_er synchronous to gmii_tx_clk_wr.

      -- Signals transfered onto the new gmii_tx_clk_rd domain.
      gmii_tx_clk_rd       : in std_logic;                     -- Read clock domain.
      gmii_txd_rd          : out std_logic_vector(7 downto 0); -- gmii_txd synchronous to gmii_tx_clk_rd.
      gmii_tx_en_rd        : out std_logic;                    -- gmii_tx_en synchronous to gmii_tx_clk_rd.
      gmii_tx_er_rd        : out std_logic                     -- gmii_tx_er synchronous to gmii_tx_clk_rd.
   );
   end component;



  ------------------------------------------------------------------------------
  -- Component Declaration for the Core Block (core wrapper).
  ------------------------------------------------------------------------------
   component lll_block
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
  -- internal signals used in this top level example design.
  ------------------------------------------------------------------------------

  -- Clock Signals
  signal gtx_clk_bufg      : std_logic;                        -- Route gtx_clk through a BUFG: onto Global Clock Routing

  -- GMII signals
  signal gmii_tx_clk_dcm   : std_logic;                        -- gmii_tx_clk is routed to a DCM.  This signal is the DCM CLK0 output.
  signal gmii_tx_clk_bufg  : std_logic;                        -- gmii_tx_clk routed through a BUFG.
  signal gmii_isolate      : std_logic;                        -- Internal gmii_isolate signal.
  signal gmii_txd_reg      : std_logic_vector(7 downto 0);     -- Internal gmii_txd signal.
  signal gmii_tx_en_reg    : std_logic;                        -- Internal gmii_tx_en signal.
  signal gmii_tx_er_reg    : std_logic;                        -- Internal gmii_tx_er signal.
  signal gmii_txd_fifo     : std_logic_vector(7 downto 0);     -- gmii_txd signal after Tx Elastic Buffer.
  signal gmii_tx_en_fifo   : std_logic;                        -- gmii_tx_en signal after Tx Elastic Buffer.
  signal gmii_tx_er_fifo   : std_logic;                        -- gmii_tx_er signal after Tx Elastic Buffer.
  signal gmii_rxd_int      : std_logic_vector(7 downto 0);     -- Internal gmii_rxd signal.
  signal gmii_rx_dv_int    : std_logic;                        -- Internal gmii_rx_dv signal.
  signal gmii_rx_er_int    : std_logic;                        -- Internal gmii_rx_er signal.
  signal gmii_rx_clk_obuf  : std_logic;                        -- gmii_rx_clk registered in IOBs prior to an OBUF.
  signal gmii_rxd_obuf     : std_logic_vector(7 downto 0);     -- gmii_rxd registered in IOBs prior to an OBUF.
  signal gmii_rx_dv_obuf   : std_logic;                        -- gmii_rx_dv registered in IOBs prior to an OBUF.
  signal gmii_rx_er_obuf   : std_logic;                        -- gmii_rx_er registered in IOBs prior to an OBUF.

  -- Reset circuirty signals for the DCM on GMII_TX_CLK
  signal dcm_locked        : std_logic;                        -- locked signal of DCM.
  signal dcm_rst           : std_logic;                        -- DCM reset, at least 3 clock periods in duration.


  -- Extra registers to ease IOB placement
  signal status_vector_int : std_logic_vector(15 downto 0);



begin


  ------------------------------------------------------------------------------
  -- gtx_clk Clock Management.  This is the 125MHz reference source
  -- clock for the core.
  ------------------------------------------------------------------------------

   --  Route gtx_clk through a BUFG (onto Global Clock Routing)
   bufg_gtx_clk : BUFG
     port map (I => gtx_clk,
               O => gtx_clk_bufg);



  ------------------------------------------------------------------------------
  -- Instantiate the Core Block (core wrapper).
  ------------------------------------------------------------------------------

  core_wrapper : lll_block
    port map (

      gtx_clk              => gtx_clk_bufg,
      tx_code_group        => tx_code_group,
      pma_tx_clk           => pma_tx_clk,
      loc_ref              => loc_ref,
      ewrap                => ewrap,
      rx_code_group        => rx_code_group,
      pma_rx_clk0          => pma_rx_clk0 ,
      en_cdet              => en_cdet,
      gmii_txd             => gmii_txd_fifo,
      gmii_tx_en           => gmii_tx_en_fifo,
      gmii_tx_er           => gmii_tx_er_fifo,
      gmii_rxd             => gmii_rxd_int,
      gmii_rx_dv           => gmii_rx_dv_int,
      gmii_rx_er           => gmii_rx_er_int,
      gmii_isolate         => gmii_isolate,
      mdc                  => mdc,
      mdio_i               => mdio_i,
      mdio_o               => mdio_o,
      mdio_t               => mdio_t,
      phyad                => phyad,
      configuration_vector => configuration_vector,
      configuration_valid  => configuration_valid,
      an_interrupt         => an_interrupt,
      an_adv_config_vector => an_adv_config_vector,
      an_adv_config_val    => an_adv_config_val,
      an_restart_config    => an_restart_config,
      link_timer_value     => link_timer_value,

      -- the following two ports are to enable the 200ms DCM reset to be
      -- bypassed during simulation
      -- NOTE: These should be tied together for normal operation
      rx_dcm_reset_200ms    => rx_dcm_reset_200ms,
      rx_dcm_reset_200ms_in => rx_dcm_reset_200ms_in,

      status_vector        => status_vector_int,
      reset                => reset,
      signal_detect        => signal_detect
      );


   -----------------------------------------------------------------------------
   -- GMII transmitter clock logic
   -----------------------------------------------------------------------------

   -- A DCM must be used with Virtex4 devices to meet the GMII input
   -- setup and hold specifications.
   -- Note: Phase shift is set in UCF file.
   gmii_tx_dcm : DCM
      port map (
         CLKIN    => gmii_tx_clk,
         CLKFB    => gmii_tx_clk_bufg,
         DSSEN    => '0',
         PSINCDEC => '0',
         PSEN     => '0',
         PSCLK    => '0',
         RST      => tx_dcm_reset_200ms_in,
         CLK0     => gmii_tx_clk_dcm,
         STATUS   => open,
         PSDONE   => open,
         LOCKED   => dcm_locked,
         CLKFX180 => open,
         CLKFX    => open,
         CLKDV    => open,
         CLK90    => open,
         CLK2X180 => open,
         CLK2X    => open,
         CLK270   => open,
         CLK180   => open
         );

   -- Route gmii_tx_clk_dcm through a BUFG and onto global clock routing
   drive_tx_clk : BUFG
     port map (I => gmii_tx_clk_dcm,
               O => gmii_tx_clk_bufg);


   -- Instantiate DCM reset circuitry
   dcm_reset_logic : lll_dcm_reset
    port map(
        reset         => reset,
        ref_clk       => gtx_clk_bufg,
        dcm_locked    => dcm_locked,
        dcm_reset     => tx_dcm_reset_200ms
    );


   -----------------------------------------------------------------------------
   -- GMII transmitter data logic
   -----------------------------------------------------------------------------


   -- Drive input GMII signals through IOB input flip-flops (inferred).
   process (gmii_tx_clk_bufg)
   begin
      if gmii_tx_clk_bufg'event and gmii_tx_clk_bufg = '1' then
         gmii_txd_reg    <= gmii_txd;
         gmii_tx_en_reg  <= gmii_tx_en;
         gmii_tx_er_reg  <= gmii_tx_er;

      end if;
   end process;


   -- Component Instantiation for the Transmitter Elastic Buffer
   tx_elastic_buffer_inst : lll_tx_elastic_buffer
   port map (
      reset            => reset,
      gmii_tx_clk_wr   => gmii_tx_clk_bufg,
      gmii_txd_wr      => gmii_txd_reg,
      gmii_tx_en_wr    => gmii_tx_en_reg,
      gmii_tx_er_wr    => gmii_tx_er_reg,
      gmii_tx_clk_rd   => gtx_clk_bufg,
      gmii_txd_rd      => gmii_txd_fifo,
      gmii_tx_en_rd    => gmii_tx_en_fifo,
      gmii_tx_er_rd    => gmii_tx_er_fifo
   );



   -----------------------------------------------------------------------------
   -- GMII receiver clock logic
   -----------------------------------------------------------------------------

   -- This instantiates a DDR output register.  This is a nice way to
   -- drive the GMII output clock since the clock-to-PAD delay will the
   -- same as that of data driven from an IOB Ouput flip-flop.  This is
   -- set to produce an inverted clock w.r.t. gtx_clk_bufg so that clock
   -- rising edge appears in the centre of GMII data.
  rx_clk_ddr_iob : ODDR
  port map(
      Q  => gmii_rx_clk_obuf,

      C  => gtx_clk_bufg,
      CE => '1',
      D1 => '0',
      D2 => '1',
      R  => '0',
      S  => '0'
    );


   -- Finally the clock is driven onto the PAD from an Output Buffer.
   drive_gmii_gtx_clk: OBUFT
     port map (I => gmii_rx_clk_obuf,
               O => gmii_rx_clk, T => gmii_isolate);



   -----------------------------------------------------------------------------
   -- GMII receiver data logic
   -----------------------------------------------------------------------------


   -- Drive input GMII signals from PADS through IOB output flip-flops.
   process (gtx_clk_bufg)
   begin
      if gtx_clk_bufg'event and gtx_clk_bufg = '1' then
         gmii_rxd_obuf    <= gmii_rxd_int;
         gmii_rx_dv_obuf  <= gmii_rx_dv_int;
         gmii_rx_er_obuf  <= gmii_rx_er_int;

      end if;
   end process;


   --  drive GMII Rx signals through output PADS.
   rx_data_valid : OBUFT
     port map (I => gmii_rx_dv_obuf,
               O => gmii_rx_dv,
               T => gmii_isolate);

   rx_data_error : OBUFT
     port map (I => gmii_rx_er_obuf,
               O => gmii_rx_er,
               T => gmii_isolate);

   rx_data_bus: for I in 7 downto 0 generate
      rx_data_bits : OBUFT
        port map (I => gmii_rxd_obuf(I),
                  O => gmii_rxd(I),
                  T => gmii_isolate);
   end generate;



  ------------------------------------------------------------------------------
  -- Extra registers to ease IOB placement
  ------------------------------------------------------------------------------
   process (gtx_clk_bufg)
   begin
      if gtx_clk_bufg'event and gtx_clk_bufg = '1' then
         status_vector <= status_vector_int;
      end if;
   end process;


end top_level;

