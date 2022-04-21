LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------------------------------
entity top is
	generic (
		n : positive := 8 ;
		m : positive := 7 ;
		k : positive := 3
	); -- where k=log2(m+1)
	port(
		rst,ena,clk : in std_logic;
		x : in std_logic_vector(n-1 downto 0);
		DetectionCode : in integer range 0 to 3;
		detector : out std_logic
	);
end top;
------------- complete the top Architecture code --------------
architecture arc_sys of top is

SIGNAL x_previous2_subtruct : std_logic_vector(n-1 DOWNTO 0);
SIGNAL x_previous1, x_previous2, diff : STD_LOGIC_VECTOR(n-1 downto 0);
SIGNAL valid	: STD_LOGIC;
SIGNAL cout	: STD_LOGIC;


BEGIN

-------------- process1 --------------------
PROCESS (x, rst, clk, ena)

		BEGIN
			IF (ena = '0')	THEN
				x_previous2 <= x_previous2;
				x_previous1 <= x_previous1;
			ELSIF (rst = '1') THEN
				x_previous2 <= (others => '0');
				x_previous1 <= (others => '0');
			ELSIF (rising_edge(clk)) THEN
				x_previous2 <= x_previous1;
				x_previous1 <= x;
			END IF;
		END PROCESS;



-------------- process2 --------------------
------ calculate diff -----
x_previous2_subtruct <= not x_previous2;
adder_pm: Adder port map(
	a => x_previous1,
	b => x_previous2_subtruct,
	cin => '0',		-- note that the diff need to be [diff - 1 = DetectionCode]
					-- so we insted of puting 1 in the cin like subtraction should be, we put 0
	s => diff
);					-- cout is not relevent to us, so we dont connect it

------ calculate valid -----
PROCESS(CLK, ena, rst, valid)

BEGIN
	IF (rst='1') then
		valid <= '0';
	elsif (ena='0') then
		valid <= valid;
	elsif(falling_edge(clk)) THEN
		if diff=DetectionCode and 							-- note that diff here is actually diff-1
			0 <= DetectionCode and DetectionCode <= 3 then	-- check that DetectionCode is valid
		valid <= '1';
		else
		valid <= '0';
		end if;
	END IF;

END PROCESS;


-------------- process3 --------------------
PROCESS(valid, rst, clk, ena)
    variable validCounter : INTEGER := 0;
    variable detector_buffer : std_logic := '0';

	BEGIN
		IF (ena = '0') THEN
			validCounter := validCounter;
			detector_buffer := detector_buffer;
		ELSIF (rst = '1') THEN
			validCounter := 0;
			detector_buffer := '0';

		ELSIF (rising_edge(clk)) THEN

			IF(valid = '1') THEN
				validCounter := validCounter + 1;
			ELSE
				validCounter := 0;
			END IF;

			IF (validCounter < m) THEN
				detector_buffer := '0';
			ELSE
				detector_buffer := '1';
			END IF;
		END IF;

		detector <= detector_buffer;
END PROCESS;



END arc_sys;







