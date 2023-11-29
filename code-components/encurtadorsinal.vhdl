library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encurtadorsinal is
    Port (
			entrada : in STD_LOGIC_VECTOR (15 downto 0);
			saida : out STD_LOGIC);
end encurtadorsinal;

architecture encurtador16x1 of encurtadorsinal is
begin
	process(entrada) is
	
	variable verifica: STD_LOGIC;
	
		begin
		
		verifica := '0';
			
			for i in 15 downto 0 loop
				if(entrada(i) = '1') then
					verifica := '1';
				end if;
			end loop;
			
			saida <= verifica;
			
	end process;
	
	
end encurtador16x1;
