library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bitsdireitalogic is
    Port (
			entrada : STD_LOGIC_VECTOR (15 downto 0);
			saida : out STD_LOGIC_VECTOR (15 downto 0));
end bitsdireitalogic;

architecture direitalogic of bitsdireitalogic is
begin
	process(entrada) is
		begin
			
			for i in 14 downto 0 loop
				saida(i) <= entrada(i + 1);
			end loop;
			saida(15) <= '0';
	end process;
end direitalogic;
