library ieee;
use ieee.std_logic_1164.all;

entity flipflop is 
	port (
	clock, reset, enable: in STD_LOGIC;
	entrada: in STD_LOGIC_VECTOR(15 DOWNTO 0);
	saida: out STD_LOGIC_VECTOR(15 DOWNTO 0));
end flipflop;
	
architecture flipflopd of flipflop is 
	begin
	process (clock, reset, enable, entrada) is
	begin
		if(reset = '1') then
			saida <= "0000000000000000";
		elsif (clock'event AND clock = '1') then
			if(enable = '1') then
				saida <= entrada;
			end if;
		end if;
	end process;
end flipflopd;
