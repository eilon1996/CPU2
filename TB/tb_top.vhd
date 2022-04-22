library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
--------------------------------------------------------------------
entity tb_top is
	constant n : integer := 8;
	constant m : integer := 7;
	constant k : integer := 3; -- where k=log2(m+1)
end tb_top;
--------------------------------------------------------------------

architecture rtb of tb_top is

	-- component top is
	-- generic (
	-- 	n : positive := 8 ;
	-- 	m : positive := 7 ;
	-- 	k : positive := 3
	-- ); -- where k=log2(m+1)
	-- port(
	-- 	rst,ena,clk : in std_logic;
	-- 	x : in std_logic_vector(n-1 downto 0);
	-- 	DetectionCode : in integer range 0 to 3;
	-- 	detector : out std_logic
	-- );
	-- end component;

	SIGNAL rst,ena, clk : std_logic;
	SIGNAL x : std_logic_vector(n-1 downto 0);
	SIGNAL DetectionCode : integer range 0 to 3;
	SIGNAL detector : std_logic;

begin
	L0 : top generic map (n,m,k) port map(rst,ena,clk, x, DetectionCode, detector);

	gen_clk : process
				begin
					clk <='1','0' after 50 ns;
					wait;
				end process;

	gen_x : process
				begin
					x <= (others => '0');
				  	for i in 0 to 25 loop
						wait for 100 ns;
						x <= x+2;
				  	end loop;
				end process;

	gen_cond: process
				begin
					DetectionCode <= 0;
					for j in 0 to 5 loop
						for i in 1 to 3 loop
							wait for 100 ns;
							DetectionCode <= DetectionCode + 1;
						end loop;
							wait for 100 ns;
							DetectionCode <= 0;
					end loop;
					wait;
				end process;

	gen_rst : process
				begin
					rst <='1','0' after 200 ns;
					wait;
				end process;

	gen_ena : process
				begin
					ena <='1','0' after 400 ns;
					wait;
				end process;


end architecture rtb;
