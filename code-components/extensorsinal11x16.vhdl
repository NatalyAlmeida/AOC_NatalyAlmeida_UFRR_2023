library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity extensorsinal11x16 is
    Port (
			entrada: STD_LOGIC_VECTOR (10 downto 0);
			saida: out STD_LOGIC_VECTOR (15 downto 0));
end extensorsinal11x16;

architecture extensor11x16 of extensorsinal11x16 is
begin
	process(entrada) is
		begin
			
			for i in 10 downto 0 loop
				saida(i) <= entrada(i);
			end loop;
			
			for i in 15 downto 10 loop
				saida(i) <= entrada(10);
			end loop;
	end process;
end extensor11x16;
