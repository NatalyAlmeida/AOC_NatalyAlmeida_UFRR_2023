library ieee;
use ieee.std_logic_1164.all;

entity uninadecontrole is 
	port (
		opcode : in STD_LOGIC_VECTOR(4 downto 0);
		funct : in STD_LOGIC_VECTOR(2 downto 0);	
		ulaop, regr1, reg1 : out std_logic_vector(3 downto 0);
		r1, r2, regOrNum, lesc, salInst, sri, memOrUla : out std_logic;
		compareReg: out std_logic_vector(1 downto 0));
		
end uninadecontrole;
------obs: erro de portugues proposital, mudado agora-----------	
architecture unidadecontrole of uninadecontrole is 
begin 

		-- Flag para indicar se o valor que será escrito no registradoro 1 é prveniente da memória RAM ou da ULA--
		with opcode select
			memOrUla <= 	'0' when "10110",
								'0' when "10111",
								'0' when "11000",
								'0' when "11001",
								'1' when others;
								
		-- Flag para verificar se o salto será feito direto - valores imediatos - ou para um endereço no registrador-
		with opcode select
					sri <= 	'0' when "10000",
								'0' when "10010",
								'0' when "10011",
								'1' when others;
		
		-- Flag para verificar se deve ser checado o valor do registrador para confirmar o salto--
		with opcode select
					compareReg <= 	"00" when "10011",
								"00" when "10101",
								"11" when "10010",
								"11" when "10100",
								"10" when others;
		
		-- Flag para indicar se existe a intenção de haver um salto nas instruções--0
		with opcode select
					salInst <= 	'1' when "10000",
								'1' when "10001",
								'1' when "10010",
								'1' when "10011",
								'1' when "10100",
								'1' when "10101",
								'0' when others;
		
		-- Flag para indicar para a memória RAM se é para ler do endereço passado ou para escrever nele--
		with opcode select
					lesc <= 	'1' when "11000",
								'1' when "11001",
								'0' when others;
		
		-- O banco de registradores deve escrever o dado recebido 2 no endereço do registrador 2--
		with opcode select
					r2 <= 	'1' when "01110",
								'1' when "01111",
								'0' when others;
		
		-- O banco de registradores deve escrever o dado recebido 1 no endereço do registrador 1 --
		with opcode select
					r1 <= 	'0' when "10000",
								'0' when "10001",
								'0' when "10010",
								'0' when "10011",
								'0' when "10100",
								'0' when "10101",
								'0' when "11000",
								'0' when "11001",
								'1' when others;
		
		-- Flag para verificar se Código para saber de onde o dado 1 será lido--
		with opcode select
					regr1 <=	"0011" when "10010",
								"0011" when "10011",
								"0011" when "10100",
								"0011" when "10101",
								"0000" when others;
		
		-- Código para saber onde o dado 1 será gravado----
		with opcode select
					reg1 <=	"0010" when "01110",
								"0010" when "01111",
								
								"0011" when "01000",
								"0011" when "01001",
								"0011" when "01010",
								"0011" when "01011",
								"0011" when "01100",
								"0011" when "01101",
								
								"0000" when others;
								
		-- Código de operação que sairá para a ULA--
		with opcode select
					ulaop <=	"0000" when "00001",
								"0001" when "11010",
								opcode(3 downto 0) when others;
								
		
		-- Flag para verificar se a ULA deverá usar o valor no Registrador 2 ou o número como constante na operação--
		with opcode select
					regOrNum <= funct(0) when "01000",
									funct(0) when "01001",
									funct(0) when "01010",
									funct(0) when "01011",
									funct(0) when "01100",
									funct(0) when "01101",
									funct(0) when "01110",
									funct(0) when "01111",
									funct(0) when "11010",
									
									opcode(0) when "10110",
									opcode(0) when "10111",
									opcode(0) when "11000",
									opcode(0) when "11001",	
									opcode(0) when "00000",	
									opcode(0) when "00001",			
									
									'0' when "00101",
									'0' when "00110",
									'0' when "00111",
									
									funct(1) when "00010",
									funct(1) when "00011",
									funct(1) when "00100",
									
									'0' when others;
		
		
							
		
		

	
end unidadecontrole;
