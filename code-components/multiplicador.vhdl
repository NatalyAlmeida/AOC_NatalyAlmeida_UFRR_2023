library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity multiplicador is
	Port (
			entrada_A, entrada_B : in STD_LOGIC_VECTOR (15 downto 0);
			saidMenor, saidMaior : out STD_LOGIC_VECTOR (15 downto 0);
			carryOut : out STD_LOGIC);
end multiplicador;


architecture mult of multiplicador is

	begin
	
		process(entrada_A, entrada_B)
		
		variable rp : std_logic_vector (31 downto 0);
		variable carry, bnow, yadd: std_logic;
		
		function shifter (esqu : std_logic_vector(31 downto 0)) return std_logic_vector is
			  
			  variable esqu1 : std_logic_vector(31 downto 0);
		begin
			  for i in 30 downto 0 loop
				 esqu1(i) := esqu(i + 1);
			  end loop; 
			  esqu1(31) := esqu(31);
			  return esqu1;
			  
		end shifter;
		
		
		
		begin
			rp:="0000000000000000" & entrada_B;
			carry:='0';
			
			--helper := input_A * input_B;
			
			bnow := '0';
			
			for i in 0 to 15 loop
			
			yadd := bnow;
			bnow := rp(0);
			
			if(yadd = '0') then
			
				if(bnow = '1')
					then
					
					rp(31 downto 16) := rp(31 downto 16) + not(entrada_A) + 1;
				
				end if;
			
			elsif(yadd = '1') then
				
				
				if(bnow = '0') then
				
				rp (31 downto 16) := rp(31 downto 16) + entrada_A;
				
				end if;
				
			end if;
				
				rp := shifter(rp);
			
			end loop;
			
			saidMaior <= rp(31 downto 16);
			saidMenor  <= rp(15 downto 0);
		
			carryOut	<= '0';
			
		end process;
		
end mult;
