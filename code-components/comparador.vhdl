library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparador is
    Port (
			opcodeComp : STD_LOGIC_VECTOR(2 downto 0);
			entrada_A, entrada_B : STD_LOGIC_VECTOR (15 downto 0);
			saida  : out STD_LOGIC_VECTOR (15 downto 0));
end comparador;

architecture comparador16 of comparador is

component multiplexador3x16 is
    Port ( Seletor : in  STD_LOGIC_VECTOR (2 downto 0);
           entrada_A, entrada_B, entrada_C, entrada_D, entrada_E, entrada_F, entrada_G, entrada_H: in STD_LOGIC_VECTOR (15 downto 0);
           saida   : out STD_LOGIC_VECTOR (15 downto 0));
end component;

	signal saida000, saida001, saida010, saida011, saida100, saida101, saida111 : STD_LOGIC_Vector(15 downto 0); 

begin

	saida000 <= "1111111111111111" when  (entrada_A = entrada_B)   else "0000000000000000";
	saida001 <= "1111111111111111" when  (entrada_A /= entrada_B)  else "0000000000000000";
	saida010 <= "1111111111111111" when  (entrada_A < entrada_B)   else "0000000000000000";
	saida011 <= "1111111111111111" when  (entrada_A <= entrada_B)  else "0000000000000000";
	saida100 <= "1111111111111111" when  (entrada_A > entrada_B)   else "0000000000000000";
	saida101 <= "1111111111111111" when  (entrada_A >= entrada_B)  else "0000000000000000";
	saida111 <= "0000000000000000";
	

F1: multiplexador3x16 port map (opcodeComp, saida000,saida001 ,saida010 ,saida011 ,saida100 , saida101, saida111, saida111, saida);

end comparador16;
