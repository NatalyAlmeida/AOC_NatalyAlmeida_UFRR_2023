library ieee;
use ieee.std_logic_1164.all;

entity somador is 
	port (
	subt: in STD_LOGIC;
	entrada_A, entrada_B: in STD_LOGIC_VECTOR(15 DOWNTO 0);
	carry_out: out STD_LOGIC;
	saida: out STD_LOGIC_VECTOR(15 DOWNTO 0));
end somador;
	
architecture somadorsub of somador is 
begin 
	process(entrada_A, entrada_B, subt)
	
	variable sum, bounb : STD_LOGIC_VECTOR(15 downto 0);
	variable Vsubt : STD_LOGIC; 
	
	begin
		
	if (subt = '1') then
		bounb :=  NOT entrada_B;
	else
		bounb :=  entrada_B;
	end if;
		
	Vsubt := subt;
	
	for i in 0 to 15 loop
		sum(i) := entrada_A(i) xor bounb(i) xor subt;
		Vsubt := (entrada_A(i) and bOunb(i)) or ((entrada_A(i) xor bounb(i)) and subt);
	end loop;
	
	carry_out <= subt;
	saida <= sum;
	
	end process;
end somadorsub;
