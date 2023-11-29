library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demultiplexador4x1 is
    Port ( Selector : in  STD_LOGIC_VECTOR(3 downto 0);
           entrada: in  STD_LOGIC;
           saida_A, saida_B, saida_C, saida_D, saida_E, saida_F, saida_G, saida_H   : out STD_LOGIC;
			  saida_I, saida_J, saida_K, saida_L, saida_M, saida_N, saida_O, saida_P   : out STD_LOGIC);
end demultiplexador4x1;

architecture demul4x1 of demultiplexador4x1 is
begin
	with Selector select
		 saida_A <= 	entrada when "0000",
							'0' when others;
	with Selector select
		 saida_B <= 	entrada when "0001",
							'0' when others;
	with Selector select
		 saida_C <= 	entrada when "0010",
							'0' when others;
	with Selector select
		 saida_D <= 	entrada when "0011",
							'0' when others;
	with Selector select
		 saida_E <= 	entrada when "0100",
						'0' when others;
	with Selector select
		 saida_F <= 	entrada when "0101",
							'0' when others;
	with Selector select
		 saida_G <= 	entrada when "0110",
							'0' when others;
	with Selector select
		 saida_H <= 	entrada when "0111",
							'0' when others;
	with Selector select
		 saida_I <= 	entrada when "1000",
							'0' when others;
	with Selector select
		 saida_J <= 	entrada when "1001",
							'0' when others;
	with Selector select
		 saida_K <= 	entrada when "1010",
							'0' when others;
	with Selector select
		 saida_L <= 	entrada when "1011",
							'0' when others;
	with Selector select
		 saida_M <= 	entrada when "1100",
							'0' when others;
	with Selector select
		 saida_N <= 	entrada when "1101",
							'0' when others;
	with Selector select
		 saida_O <= 	entrada when "1110",
							'0' when others;
	with Selector select
		 saida_P <= 	entrada when "1111",
							'0' when others;
end demul4x1;
