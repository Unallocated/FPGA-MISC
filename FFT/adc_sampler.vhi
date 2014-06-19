
-- VHDL Instantiation Created from source file adc_sampler.vhd -- 23:26:57 12/09/2013
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT adc_sampler
	PORT(
		clk : IN std_logic;
		en : IN std_logic;
		rst : IN std_logic;
		adc_in : IN std_logic_vector(7 downto 0);          
		adc_clk : OUT std_logic;
		data_out : OUT std_logic_vector(7 downto 0);
		clk_out : OUT std_logic
		);
	END COMPONENT;

	Inst_adc_sampler: adc_sampler PORT MAP(
		clk => ,
		en => ,
		rst => ,
		adc_in => ,
		adc_clk => ,
		data_out => ,
		clk_out => 
	);


