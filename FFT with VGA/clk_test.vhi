
-- VHDL Instantiation Created from source file clk_test.vhd -- 12:57:20 12/12/2013
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT clk_test
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		data_in : IN std_logic_vector(7 downto 0);
		en : IN std_logic;          
		data_clk : OUT std_logic;
		data_out : OUT std_logic_vector(7 downto 0);
		data_out_clk : OUT std_logic
		);
	END COMPONENT;

	Inst_clk_test: clk_test PORT MAP(
		clk => ,
		rst => ,
		data_in => ,
		data_clk => ,
		data_out => ,
		data_out_clk => ,
		en => 
	);


