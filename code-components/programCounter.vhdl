library ieee;
use ieee.std_logic_1164.all;

entity programCounter is 
	port (
	clock : in STD_LOGIC;
	entrada: in STD_LOGIC_VECTOR(15 DOWNTO 0);
	saida: out STD_LOGIC_VECTOR(15 DOWNTO 0));
end ProgramCounter;
	
architecture pc of programCounter is 
	begin
	process (clock, entrada) is
	begin
		if (clock'event AND clock = '1') then
			saida <= entrada;
		end if;
	end process;
end pc;
