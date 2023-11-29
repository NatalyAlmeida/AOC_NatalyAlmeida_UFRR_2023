library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or1 is
    Port ( 
           entrada_A, entrada_B: in STD_LOGIC_VECTOR (15 downto 0);
           saidaComp  : out STD_LOGIC_VECTOR (15 downto 0));
end or1;

architecture orlogic of or1 is
begin
	saidaComp <= 	entrada_A OR entrada_B;
end orlogic;
