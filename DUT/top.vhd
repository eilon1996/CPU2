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

	PROCESS (x, rest, clk, ena)

		BEGIN
			IF (ena = '0')	THEN
				x_previous2 <= x_previous2;
				x_previous1 <= x_previous1;
			ELSIF (rst = '1') THEN
				x_previous2 <= <= (others => '0');
				x_previous1 <= <= (others => '0');
			ELSIF (rising_edge(clk)) THEN
				x_previous2 <= x_previous1;
				x_previous1 <= x;
			END IF;
		END PROCESS;
					



begin
	
				
	
	
	
end arc_sys;







