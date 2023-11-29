library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexador3x16 is
    Port ( Seletor : in  STD_LOGIC_VECTOR (2 downto 0);
           entrada_A, entrada_B, entrada_C, entrada_D, entrada_E, entrada_F, entrada_G, entrada_H: in STD_LOGIC_VECTOR (15 downto 0);
           saida  : out STD_LOGIC_VECTOR (15 downto 0));
end multiplexador3x16;

architecture mu3x16 of multiplexador3x16 is
begin
	with Seletor select
		 saida <= 	entrada_A when "000",
						entrada_B when "001",
						entrada_C when "010",
						entrada_D when "011",
						entrada_E when "100",
						entrada_F when "101",
						entrada_G when "110",
						entrada_H when others;
end mu3x16;
