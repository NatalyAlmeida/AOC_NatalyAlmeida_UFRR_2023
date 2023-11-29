library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexador1x16 is
    Port ( Selector : in  STD_LOGIC;
           entrada_A, entrada_B: in  STD_LOGIC_VECTOR (15 downto 0);
           saida   : out STD_LOGIC_VECTOR (15 downto 0));
end multiplexador1x16;

architecture mu1x16 of multiplexador1x16 is
begin
	with Selector select
		 saida <= 	entrada_A when '0',
						entrada_B when others;
end mu1x16;
