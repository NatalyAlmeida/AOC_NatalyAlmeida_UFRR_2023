library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LogPose is
 
port( 
	clock : in std_logic
 );
    
end LogPose;

architecture LP of LogPose is

-- Pc --
component programCounter is 
	port (
	clock : in STD_LOGIC;
	entrada: in STD_LOGIC_VECTOR(15 DOWNTO 0);
	saida: out STD_LOGIC_VECTOR(15 DOWNTO 0));
end component;

-- Memória de Instruções --
component MemoriaROM is
	port(
	endereco : in  std_logic_vector(15 downto 0);
	dados: out std_logic_vector(15 downto 0));
end component;

-- Unidade de Controle --
component uninadecontrole is 
	port (
		opcode : in STD_LOGIC_VECTOR(4 downto 0);
		funct : in STD_LOGIC_VECTOR(2 downto 0);	
		ulaop, regr1, reg1 : out std_logic_vector(3 downto 0);
		r1, r2, regOrNum, lesc, salInst, sri, memOrUla : out std_logic;
		compareReg : out std_logic_vector(1 downto 0));
end component;

--  Banco de Registradores --
component bancoregistrador is 
	port (
	clock, clearReset, controlRegister1, controlRegister2: in STD_LOGIC;
	regEndereco1, regEndereco2, regLer1, regEsc: in STD_LOGIC_VECTOR(3 DOWNTO 0);
	entradaDadosR1, entradaDadosR2 : in STD_LOGIC_VECTOR(15 DOWNTO 0);
	lerDados1, lerDados2: out STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
end component;


-- Unidade Lógica Aritmética ALU --
component alu is 
	port (
		opcode : IN STD_LOGIC_VECTOR(3 downto 0);
		negate : IN STD_LOGIC;
		entrada_A, entrada_B : IN STD_LOGIC_VECTOR(15 downto 0);
		saida, overflowMultDiv : OUT STD_LOGIC_VECTOR(15 downto 0)
	);	
end component;

-- Memória de Dados (Memória RAM)--
component memoriaram is
  port (
     clock   : in  std_logic;
    controlmem      : in  std_logic;
    endereco : in  std_logic_vector(15 downto 0);
    entrada_dados  : in  std_logic_vector(15 downto 0);
    saida_dados : out std_logic_vector(15 downto 0)
  );
end component;

-- Extensor de sinal de 11 para 16 bits --
component extensorsinal11x16 is
    Port (
			entrada : STD_LOGIC_VECTOR (10 downto 0);
			saida : out STD_LOGIC_VECTOR (15 downto 0));
end component;

-- Extensor de sinal de 4 para 16 bits --
component extensorsinal is
    Port (
			entrada : STD_LOGIC_VECTOR (3 downto 0);
			saida : out STD_LOGIC_VECTOR (15 downto 0));
end component;

-- Multiplexador com 1 bit de seleção para 16 bits --
component multiplexador1x16 is
    Port ( 
	        Selector : in  STD_LOGIC;
           entrada_A, entrada_B: in  STD_LOGIC_VECTOR (15 downto 0);
           saida   : out STD_LOGIC_VECTOR (15 downto 0));
end component;

-- Encurtador de sinal de 16 para 1 bit --
component encurtadorsinal is
    Port (
			entrada : STD_LOGIC_VECTOR (15 downto 0);
			saida   : out STD_LOGIC);
end component;

-- Multiplexador com 2 bits de seleção para 1 bit --
component multiplexador2x1 is
    Port ( Seletor : in  STD_LOGIC_VECTOR (1 downto 0);
           entrada_A, entrada_B, entrada_C, entrada_D: in  STD_LOGIC;
           saida   : out STD_LOGIC);
end component;

-- Somador de 16 bits --
component somador is 
	port (
	subt: in STD_LOGIC;
	entrada_A, entrada_B: in STD_LOGIC_VECTOR(15 DOWNTO 0);
	carry_out: out STD_LOGIC;
	saida: out STD_LOGIC_VECTOR(15 DOWNTO 0));
end component;



----------------




-- 16 bits
signal proxInstPC, pcToROM, atualInst, resultadoDado1, resultadoDado2HighMultDiv, register1Value, register2Value : STD_LOGIC_vector(15 downto 0);
signal jumpEnd, endJump, register2DirectValue, trueRegister2Value, saidaALU, saidaMemoria, proxInstOuNao : std_logic_vector(15 downto 0);
signal talInst, instJump : std_logic_vector(15 downto 0);

-- 4 bits
signal ulaOpcode, regEscem, regLerpara, regEndereco1, regEndereco2 : STD_LOGIC_VECTOR(3 downto 0);

-- 2 bits
signal compareRegOuNao : std_logic_vector(1 downto 0);

-- 1  bit
signal controlRegister1, controlRegister2, reg2Number, lerEscMem, condJump, regOrImediateJump : std_logic;
signal saidaMemUla, regCompareValue, compareRegMul, shouldJumpNow, dontCarePcAdder, dontCareJumpSubtractor : std_logic;
signal dontCareAddressSum : std_logic;

begin
	
	-- Controle de instruções --
	COM1 : 	programCounter port map(clock, proxInstPC, pcToROM);
	
	-- Memória De instruções --
	COM2 : 	MemoriaROM port map(pcToROM, atualInst);
	
	-- Unidade de Controle --
	COM3 :	uninadecontrole port map(atualInst(15 downto 11), atualInst(2 downto 0), ulaOpcode, regEscem, 
				regLerpara, controlRegister1, controlRegister2, reg2Number, lerEscMem, condJump, 
				regOrImediateJump, saidaMemUla, compareRegOuNao );
				
	-- Banco de Registradores --
	COM4 :	bancoregistrador port map(clock, '0',  controlRegister1, controlRegister2, 
				atualInst(10 downto 7), atualInst(6 downto 3),
				regLerpara,  regEscem, resultadoDado1, 
				resultadoDado2HighMultDiv, register1Value, register2Value);

	-- Extensor de sinal do endereço de salto condicional direto--	
	EXT1 :	extensorsinal11x16 port map(atualInst(10 downto 0), jumpEnd);
		
	-- Multiplexador endereço direto ou o valor do registrador--
	MUX1 :	multiplexador1x16 port map(regOrImediateJump, register2Value, jumpEnd, endJump);
	
	-- Extensor de sinal que pega o endereço literal do segundo regsitardor como constante--
	EXT2 :	extensorsinal port map(atualInst(6 downto 3), register2DirectValue);
	
	-- Multiplexador que seleciona o valor que estava no registrador2 ou o seu valor como constante - direto--
	MUX2 : 	multiplexador1x16 port map(reg2Number, register2Value, register2DirectValue, trueRegister2Value);
	
	-- Unidade Lógica e Aritmética (ALU)--
	COM5 :	alu port map(ulaOpcode, atualInst(0), register1Value, trueRegister2Value, saidaALU, resultadoDado2HighMultDiv);
		
	-- Memória de Dados RAM--
	COM6 : 	memoriaram port map(clock, lerEscMem, trueRegister2Value, register1Value, saidaMemoria);
		
	-- Multiplexador que seleciona se o valor gravado será o da ULA ou o da memória--
	MUX3 :	multiplexador1x16 port map(saidaMemUla, saidaMemoria, saidaALU, resultadoDado1);
	
	-- Encurtador de sinal que pega o valor do registrador e transforma em 1 bit--
	SHT1 :	encurtadorsinal port map(register1Value, regCompareValue);
	
	-- Multiplexador que seleciona se o salto condicional depende do valor--
	MUX4 :	multiplexador2x1 port map(compareRegOuNao, not regCompareValue, '1', '1', regCompareValue, compareRegMul);
	
	-- Checando para confirmar que haverá um salto condicional.--
	shouldJumpNow <= compareRegMul AND condJump;
	
	-- Somador automático para a próxima instrução--
	COM7 :	somador port map('0', pcToROM, "0000000000000001", dontCarePcAdder, proxInstOuNao);
	
	-- Somador que retira a soma automática do PC para calcular o novo endereço depois do salto--
	COM8 :	somador port map('1', endJump, "0000000000000001", dontCareJumpSubtractor, talInst);
	
	-- Somador que Calcula o endereço da próxima instrução--
	COM9 :	somador port map('0', proxInstOuNao,  talInst, dontCareAddressSum, instJump);
	
	-- Multiplexador que seleciona o endereço da próxima instrução natural ou com salto--
	MUX5 :	multiplexador1x16 port map(shouldJumpNow, proxInstOuNao, instJump, proxInstPC);
		
end LP;
