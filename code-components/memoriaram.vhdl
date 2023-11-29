library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity memoriaram is
  port (
    clock   : in  std_logic;
    controlmem      : in  std_logic;
    endereco : in  std_logic_vector(15 downto 0);
    entrada_dados  : in  std_logic_vector(15 downto 0);
    saida_dados : out std_logic_vector(15 downto 0)
  );
end entity memoriaram;

architecture memoriaram16 of memoriaram is

   
	type RAM is array (0 to 2000) of std_logic_vector(entrada_dados'range);
   signal ram_memory : RAM;
   signal read_address : std_logic_vector(endereco'range);

begin

	process(clock, controlmem, endereco, entrada_dados) is
	begin
		if rising_edge(clock) then
			if (controlmem = '1') 
			then
				ram_memory(to_integer(unsigned(endereco))) <= entrada_dados;
			end if;
			
			-- read_address <= endereco;---
			
		end if;
	end process ;

	saida_dados <= ram_memory(to_integer(unsigned(endereco)));

end architecture memoriaram16;	
