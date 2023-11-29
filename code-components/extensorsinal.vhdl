library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity extensorsinal is
    Port (
			entrada : STD_LOGIC_VECTOR (3 downto 0);
			saida : out STD_LOGIC_VECTOR (15 downto 0));
end extensorsinal;

architecture extensor4x16 of extensorsinal is
begin
	process(entrada) is
		begin
			
			for i in 3 downto 0 loop
				saida(i) <= entrada(i);
			end loop;
			saida(15 downto 4) <= "000000000000";
	end process;
end extensor4x16;
