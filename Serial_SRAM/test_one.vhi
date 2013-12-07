
-- VHDL Instantiation Created from source file test_one.vhd -- 23:39:04 12/04/2013
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT test_one
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		start : IN std_logic;
		si : IN std_logic;
		we : IN std_logic;
		address : IN std_logic_vector(15 downto 0);
		data_in : IN std_logic_vector(7 downto 0);          
		so : OUT std_logic;
		sck : OUT std_logic;
		data_out : OUT std_logic_vector(7 downto 0);
		done : OUT std_logic
		);
	END COMPONENT;

	Inst_test_one: test_one PORT MAP(
		clk => ,
		rst => ,
		start => ,
		so => ,
		si => ,
		sck => ,
		we => ,
		address => ,
		data_in => ,
		data_out => ,
		done => 
	);


