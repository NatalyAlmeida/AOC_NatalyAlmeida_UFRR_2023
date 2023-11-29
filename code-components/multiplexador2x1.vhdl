library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexador2x1 is
    Port ( Seletor : in  STD_LOGIC_VECTOR (1 downto 0);
           entrada_A, entrada_B, entrada_C, entrada_D: in  STD_LOGIC;
           saida   : out STD_LOGIC);
end multiplexador2x1;

architecture mu2x1 of multiplexador2x1 is
begin
	with Seletor select
		 saida <= 	entrada_A when "00",
						entrada_B when "01",
						entrada_C when "10",
						entrada_D when others;
end mu2x1;
