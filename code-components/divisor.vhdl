library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divisor is
	Port (
			entrada_A, entrada_B : in STD_LOGIC_VECTOR (15 downto 0);
			saidMenor, saidMaior : out STD_LOGIC_VECTOR (15 downto 0);
			carryOut : out STD_LOGIC);
end divisor;

		
architecture divisor16 of divisor is

	begin
	
	
		process(entrada_A, entrada_B)
		
		variable Qint, resto, const : std_logic_vector (15 downto 0);
		variable carry: std_logic;
		
		
		function shiter (esq : std_logic_vector(15 downto 0)) return std_logic_vector is
			  
			  variable esq1 : std_logic_vector(15 downto 0);
		begin
			  for i in 14 downto 0 loop
				 esq1(i + 1) := esq(i);
			  end loop; 
			  esq1(0) := '0';
			  return esq1;
		end shiter;
		
		begin
			carry:='0';
			
			if(entrada_B = "0000000000000000") then
			
			saidMaior <= "0000000000000000";
			saidMenor  <= "0000000000000000";
			const  := "0000000000000001";
			
			else
			
				resto := "0000000000000000";
				Qint := "0000000000000000";
			
				for i in 15 downto 0 loop
					
					resto := shiter(resto);
						
					resto(0) := entrada_A(i);
					
					if(resto >= entrada_B) then
					
						resto := resto - entrada_B;
						Qint(i) := '1';
					
					end if;
				
				
				end loop;			
					
			saidMaior <= resto;
			saidMenor <= Qint;
			
			end if;
		
			carryOut	<= '0';
			
		end process;	
		
end divisor16;

	
