
------------- create sub entities --------------

------------- process1 entity --------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
--------------------------------------------
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

------------- process2 entity --------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
--------------------------------------------
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

------------- process3 entity --------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
--------------------------------------------
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

------------- top entity --------------
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
architecture arc_sys of top is
	------------- process declare --------------
	------------- process1 --------------
		component process1 is
			port(
				rst,ena,clk : in std_logic;
				x : in std_logic_vector(n-1 downto 0);
				x_previous1, x_previous2 : out std_logic_vector(n-1 downto 0)
			);
		end component;
		------------- process2 --------------
		component process2 is
			port(
				rst,ena,clk : in std_logic;
				x_previous1, x_previous2 : in std_logic_vector(n-1 downto 0);
				DetectionCode : in integer range 0 to 3;
				valid : out std_logic
			);
		end component;
		------------- process3 --------------
		component process3 is
			port(
				rst,ena,clk : in std_logic;
				valid : out std_logic;
				DetectionCode : in integer range 0 to 3;
				detector : out std_logic
			);
		end component;

------------- signals declare --------------
SIGNAL x_previous1, x_previous2	: STD_LOGIC_VECTOR(n-1 downto 0);
SIGNAL valid	: STD_LOGIC;

begin

------------- wire up processes --------------
	------------- process1 --------------
    process1_pm: process1 port map(
        rst => rst,
        ena => ena,
        clk => clk,
        x => x,
        x_previous1 => x_previous1,
        x_previous2 => x_previous2
    );
	------------- process2 --------------
    process2_pm: process2 port map(
        rst => rst,
        ena => ena,
        clk => clk,
        x_previous1 => x_previous1,
        x_previous2 => x_previous2,
        DetectionCode => DetectionCode,
        valid => valid
    );
	------------- process3 --------------
    process3_pm: process3 port map(
        rst => rst,
        ena => ena,
        clk => clk,
        DetectionCode => DetectionCode,
        valid => valid,
        detector => detector
    );

end arc_sys;







