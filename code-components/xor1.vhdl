library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor1 is
    Port ( 
           entrada_A, entrada_B: in STD_LOGIC_VECTOR (15 downto 0);
           saidaComp   : out STD_LOGIC_VECTOR (15 downto 0));
end xor1;

architecture xorlogic of xor1 is
begin
	saidaComp <= 	entrada_A XOR entrada_B;
end xorlogic;
