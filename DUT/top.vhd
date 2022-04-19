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
	SIGNAL x_previous1, x_previous2: STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	SIGNAL validCounter : INTEGER range 0 to m;
	BEGIN

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
	
	

	PROCESS(valid, rst, clk, ena, detector)
		
		BEGIN
			IF (ena = '0') THEN
				validCounter <= validCounter;
				IF (validCounter < m) THEN
					detector <= '0';
				ELSE 
					detector <= '1';
				END IF;
			ELSE IF (rst = '1') THEN
				
				validCounter <= 0;
				detector <= '0';
			
			ELSIF (rising_edge(clk)) THEN

				IF(valid = '1') THEN
					validCounter <= validCounter + 1;
				ELSE
					validCounter <= 0;
				END IF;

				IF (validCounter < m) THEN
					detector <= '0';
				ELSE 
					detector <= '1';
				END IF;
			END IF;


		END PROCESS;
	
	
	
	END arc_sys;







