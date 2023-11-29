library ieee;
use ieee.std_logic_1164.all;

entity alu is 
	port (
		opcode : IN STD_LOGIC_VECTOR(3 downto 0);
		negate : IN STD_LOGIC;
		entrada_A, entrada_B : IN STD_LOGIC_VECTOR(15 downto 0);
		saida, overflowMultDiv : OUT STD_LOGIC_VECTOR(15 downto 0)
	);	
end alu;
	
architecture ula of alu is 

	component multiplexador4x16 is
		 Port ( 	Selector : in  STD_LOGIC_VECTOR (3 downto 0);
					entrada_A, entrada_B, entrada_C, entrada_D, entrada_E, entrada_F, entrada_G, entrada_H: in  STD_LOGIC_VECTOR (15 downto 0);
					 entrada_I, entrada_J, entrada_K, entrada_L, entrada_M, entrada_N, entrada_O, entrada_P: in  STD_LOGIC_VECTOR (15 downto 0);
					saida   : out STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component somador is 
		port (
			subt: in STD_LOGIC;
			entrada_A, entrada_B: in STD_LOGIC_VECTOR(15 DOWNTO 0);
			carry_out: out STD_LOGIC;
			saida: out STD_LOGIC_VECTOR(15 DOWNTO 0));
	end component;
	
	component bitsdireita is
		 Port (
				entrada : STD_LOGIC_VECTOR (15 downto 0);
				saida : out STD_LOGIC_VECTOR (15 downto 0));
	end component;


	component bitsdireitalogic is
		 Port (
				entrada : STD_LOGIC_VECTOR (15 downto 0);
				saida : out STD_LOGIC_VECTOR (15 downto 0));
	end component;

	component bitesquerda is
		 Port (
				entrada : STD_LOGIC_VECTOR (15 downto 0);
				saida : out STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component comparador is
		 Port (
				opcodeComp : STD_LOGIC_VECTOR(2 downto 0);
				entrada_A, entrada_B : STD_LOGIC_VECTOR (15 downto 0);
				saida : out STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component multiplicador is
		Port (
				entrada_A, entrada_B : in STD_LOGIC_VECTOR (15 downto 0);
				saidMenor, saidMaior : out STD_LOGIC_VECTOR (15 downto 0);
				carryOut : out STD_LOGIC);
	end component;
	
	component divisor is
		Port (
				entrada_A, entrada_B : in STD_LOGIC_VECTOR (15 downto 0);
				saidMenor, saidMaior : out STD_LOGIC_VECTOR (15 downto 0);
				carryOut : out STD_LOGIC);
	end component;
	
	component and1 is
		 Port ( 
				  entrada_a, entrada_b: in STD_LOGIC_VECTOR (15 downto 0);
				  saidaComp   : out STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component or1 is
		 Port ( 
				  entrada_A, entrada_B: in STD_LOGIC_VECTOR (15 downto 0);
				  saidaComp   : out STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component xor1 is
		 Port ( 
				  entrada_A, entrada_B: in STD_LOGIC_VECTOR (15 downto 0);
				  saidaComp  : out STD_LOGIC_VECTOR (15 downto 0));
	end component;		

	signal saida1, saida2, saida3, saida4, saida5, saida6 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal saida7, saidaComparad : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal saida14, saida15, saida0, saidaand, saidaor, saidaxor : STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	
	signal carryoutMul, carryoutDiv, carryOutSomasub : STD_LOGIC;
	signal overMult, overDiv : STD_LOGIC_VECTOR(15 downto 0);
	
begin

	-- 0000
	-- 12
	-- Soma e Subtração
	P0: somador port map(negate, entrada_A, entrada_B, carryOutSomasub, saida0);
	
	-- 0001
	-- Retorna o segundo valor
	saida1 <= entrada_B;
	
	P2: and1 port map(entrada_A, entrada_B, saidaand);
	P3: or1 port map(entrada_A, entrada_B, saidaor);
	P4: xor1 port map(entrada_A, entrada_B, saidaxor);
	
	process(entrada_A, entrada_B) begin
		
	if(negate = '0') 
	then
		-- 0010
		-- 1
		-- And
		saida2 <= saidaand;
		
		-- 0011
		-- 1
		-- Or
		saida3 <= saidaor;
		
		-- 0100
		-- 1
		-- Xor
		saida4 <= saidaxor;
	else
		-- 0010
		-- 1
		-- Nand
		saida2 <= not saidaand;
		
		-- 0011
		-- 1
		-- Nor
		saida3 <= not saidaor;
		
		-- 0100
		-- 1
		-- Xnor
		saida4 <= not saidaxor;
	
	end if;
	
	
	if(opcode(0) = '0') then
		overflowMultDiv <= overMult;
	else
		overflowMultDiv <= overDiv;
	end if;
	
	
	end process;
	
	-- 0101
	-- Shift aritmetico para direita
	P5: bitsdireita port map(entrada_A, saida5);
	
	-- 0110
	-- Shift logico para direita
	P6: bitsdireitalogic port map(entrada_A, saida6);
	
	-- 0111
	-- Shift aritmetico e logico para esquerda
	P7: bitesquerda port map(entrada_A, saida7);
	
	-- 1000
	-- Comparadores
	P8: comparador port map(opcode(2 downto 0), entrada_A, entrada_B, saidaComparad);
	
	-- 1110
	-- 12
	-- Multiplicação
	p14: multiplicador port map(entrada_A, entrada_B, saida14, overMult, carryoutMul);
	
	-- 1111
	-- 12
	-- Divisão
	p15: divisor port map(entrada_A, entrada_B, saida15, overDiv, carryoutDiv);
		
	
	Poutput: multiplexador4x16 port map (opcode, saida0, saida1, saida2, saida3, saida4, saida5, saida6,
					saida7, saidaComparad, saidaComparad, saidaComparad, 
					saidaComparad, saidaComparad, saidaComparad, saidaComparad, saidaComparad, saida);

end ula;
