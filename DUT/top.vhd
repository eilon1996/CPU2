LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
------------- create sub entities --------------

------------- process1 entity --------------
entity process1 is
	generic (
		n : positive := 8 ;
		m : positive := 7 ;
		k : positive := 3
	); -- where k=log2(m+1)
	port(
		rst,ena,clk : in std_logic;
		x : in std_logic_vector(n-1 downto 0);
		x_previous1, x_previous2 : out std_logic_vector(n-1 downto 0)
	);
end process1;

architecture process1_arc of process1 is

begin


end process1_arc;

--------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
------------- process2 entity --------------
entity process2 is
	generic (
		n : positive := 8 ;
		m : positive := 7 ;
		k : positive := 3
	); -- where k=log2(m+1)
	port(
		rst,ena,clk : in std_logic;
		x_previous1, x_previous2 : in std_logic_vector(n-1 downto 0);
		DetectionCode : in integer range 0 to 3;
		valid : out std_logic
	);
end process2;

architecture process2_arc of process2 is

begin


end process2_arc;

--------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
------------- process3 entity --------------
entity process3 is
	generic (
		n : positive := 8 ;
		m : positive := 7 ;
		k : positive := 3
	); -- where k=log2(m+1)
	port(
		rst,ena,clk : in std_logic;
		valid : out std_logic;
		DetectionCode : in integer range 0 to 3;
		detector : out std_logic
	);
end process3;

architecture process3_arc of process3 is

begin


end process3_arc;

-------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
------------- top entity --------------
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

begin


end arc_sys;







