library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity serial_master_fifo is
	Port ( ser_clk : in  STD_LOGIC;
				 rst : in  STD_LOGIC;
				 rx : in  STD_LOGIC;
				 tx : out STD_LOGIC;
				 rx_full : out STD_LOGIC;
				 tx_full : out STD_LOGIC;
				 rx_empty : out std_logic;
	       tx_empty : out std_logic;
				 data_in : in std_logic_vector(7 downto 0);
				 data_out : out std_logic_vector(7 downto 0);
				 rd_clk : in std_logic;
	       rd_en : in std_logic;
	       wr_clk : in std_logic;
	       wr_en : in std_logic

);
end serial_master_fifo;

architecture Behavioral of serial_master_fifo is


	COMPONENT serial_rx_fifo
		PORT(
					clk : IN std_logic;
					rst : IN std_logic;
					rx : IN std_logic;
					rd_clk : IN std_logic;
					rd_en : IN std_logic;          
					data : OUT std_logic_vector(7 downto 0);
					full : OUT std_logic;
					empty : OUT std_logic
				);
	END COMPONENT;


	COMPONENT serial_tx_fifo
		PORT(
					clk : IN std_logic;
					rst : IN std_logic;
					din : IN std_logic_vector(7 downto 0);
					wr_clk : IN std_logic;
					wr_en : IN std_logic;          
					tx : OUT std_logic;
					full : OUT std_logic;
					empty : OUT std_logic
				);
	END COMPONENT;

begin

	serial_rx : serial_rx_fifo PORT MAP(
																			 clk => ser_clk,
																			 rst => rst,
																			 rx => rx,
																			 data => data_out,
																			 full => rx_full,
																			 empty => rx_empty,
																			 rd_clk => rd_clk,
																			 rd_en => rd_en
																		 );

	serial_tx: serial_tx_fifo PORT MAP(
																			clk => ser_clk,
																			rst => rst,
																			tx => tx,
																			din => data_in,
																			wr_clk => wr_clk,
																			wr_en => wr_en,
																			full => tx_full,
																			empty => tx_empty
																		);

end Behavioral;

