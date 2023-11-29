library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bitesquerda is
    Port (
			entrada : STD_LOGIC_VECTOR (15 downto 0);
			saida : out STD_LOGIC_VECTOR (15 downto 0));
end bitesquerda;

architecture bitesq of bitesquerda is
begin
	process(entrada) is
		begin
			
			for i in 15 downto 1 loop
				saida(i) <= entrada(i - 1);
			end loop;
			saida(0) <= '0';
	end process;
end bitesq;
