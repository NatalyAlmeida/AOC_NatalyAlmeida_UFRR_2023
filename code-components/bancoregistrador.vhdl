library ieee;
use ieee.std_logic_1164.all;

entity bancoregistrador is 
	port (
	clock, clearReset, controlRegister1, controlRegister2: in STD_LOGIC;
	regEndereco1, regEndereco2, regLer1, regEsc: in STD_LOGIC_VECTOR(3 DOWNTO 0);
	entradaDadosR1, entradaDadosR2 : in STD_LOGIC_VECTOR(15 DOWNTO 0);
	lerDados1, lerDados2: out STD_LOGIC_VECTOR(15 DOWNTO 0)	
	);
end bancoregistrador;
	
architecture bancoregistradores of bancoregistrador is 

	component flipflop is 
		port (
		clock, reset, enable: in STD_LOGIC;
		entrada: in STD_LOGIC_VECTOR(15 DOWNTO 0);
		saida: out STD_LOGIC_VECTOR(15 DOWNTO 0));
	end component;
	
	component multiplexador4x16 is
		Port ( 	
		Selector : in  STD_LOGIC_VECTOR (3 downto 0);
		entrada_A, entrada_B, entrada_C, entrada_D, entrada_E, entrada_F, entrada_G, entrada_H: in  STD_LOGIC_VECTOR (15 downto 0);
		entrada_I, entrada_J, entrada_K, entrada_L, entrada_M, entrada_N, entrada_O, entrada_P: in  STD_LOGIC_VECTOR (15 downto 0);
		saida   : out STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component demultiplexador4x1 is
		Port ( 
		Selector : in  STD_LOGIC_VECTOR(3 downto 0);
		entrada: in  STD_LOGIC;
		saida_A, saida_B, saida_C, saida_D, saida_E, saida_F, saida_G, saida_H   : out STD_LOGIC;
		saida_I, saida_J, saida_K, saida_L, saida_M, saida_N, saida_O, saida_P   : out STD_LOGIC);
	end component;
	
	component demultiplexador4x16 is
		 Port ( Selector : in  STD_LOGIC_VECTOR(3 downto 0);
				  entrada: in  STD_LOGIC_VECTOR (15 downto 0);
				  saida_A, saida_B, saida_C, saida_D, saida_E, saida_F, saida_G, saida_H   : out STD_LOGIC_VECTOR (15 downto 0);
				  saida_I, saida_J, saida_K, saida_L, saida_M, saida_N, saida_O, saida_P   : out STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component comparador is
		 Port (
				opcodeComp : STD_LOGIC_VECTOR(2 downto 0);
				entrada_A, entrada_B : STD_LOGIC_VECTOR (15 downto 0);
				saida : out STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component multiplexador1x4 is
		 Port ( Selector : in  STD_LOGIC;
				  entrada_A, entrada_B: in  STD_LOGIC_VECTOR (3 downto 0);
				  saida   : out STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component encurtadorsinal is
		 Port (
				entrada : in STD_LOGIC_VECTOR (15 downto 0);
				saida : out STD_LOGIC);
	end component;
	
	component extensorsinal is
		 Port (
				entrada : STD_LOGIC_VECTOR (3 downto 0);
				saida : out STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component multiplexador1x16 is
		 Port ( Selector : in  STD_LOGIC;
				  entrada_A, entrada_B: in  STD_LOGIC_VECTOR (15 downto 0);
				  saida   : out STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	signal resultMux2, registerValueIm1, registerValueIm2, dependWrite1orWrite2, resultComp1, resultComp2, resultComp3, saida00, saida01, saida02, saida03, saida04, saida05, saida06, saida07, saida08, saida09, saida10, saida11, saida12, saida13, saida14, saida15 : STD_LOGIC_VECTOR(15 downto 0);
	signal dadoR2, entradaDados00, entradaDados01, entradaDados02, entradaDados03, entradaDados04, entradaDados05, entradaDados06, entradaDados07, entradaDados08, entradaDados09, entradaDados10, entradaDados11, entradaDados12, entradaDados13, entradaDados14, entradaDados15 : STD_LOGIC_VECTOR(15 downto 0);
	signal lerDepend, escDepend, dependler1orler2Mux1, controlRegister100, controlRegister101, controlRegister102, controlRegister103, controlRegister104, controlRegister105, controlRegister106, controlRegister107, controlRegister108, controlRegister109, controlRegister110, controlRegister111, controlRegister112, controlRegister113, controlRegister114, controlRegister115 : STD_LOGIC;
	signal lerReg, escReg : STD_LOGIC_VECTOR(3 downto 0);
		
		BEGIN
		
			Comp1: comparador port map("000", registerValueIm1, "0000000000000000", resultComp1);
			Comp2: comparador port map("000", registerValueIm2, "0000000000000000", resultComp2);
			Comp3: comparador port map("000", dependWrite1orWrite2, "0000000000000001", resultComp3);
			
			Enc1: encurtadorsinal port map(resultComp1, lerDepend);
			Enc2: encurtadorsinal port map(resultComp2, escDepend);
			Enc3: encurtadorsinal port map(resultComp3, dependler1orler2Mux1);
			
			Ext1: extensorsinal port map(regLer1, registerValueIm1);
			Ext2: extensorsinal port map(regEsc, registerValueIm2);
			Ext3: extensorsinal port map(escReg, dependWrite1orWrite2);
			
			Mux1: multiplexador4x16 port map (lerReg, saida00, saida01, saida02, saida03, saida04, saida05, saida06, saida07, saida08, saida09, saida10, saida11, saida12, saida13, saida14, saida15, lerDados1);
			Mux2: multiplexador4x16 port map (regEndereco2, saida00, saida01, saida02, saida03, saida04, saida05, saida06, saida07, saida08, saida09, saida10, saida11, saida12, saida13, saida14, saida15, lerDados2);
			Mux3: multiplexador1x4 port map(lerDepend, regLer1, regEndereco2, lerReg);
			Mux4: multiplexador1x4 port map(escDepend, regEsc, regEndereco1, escReg);
			Mux5: multiplexador1x16 port map(controlRegister2, entradaDadosR1, entradaDadosR2, resultMux2);
			Mux6: multiplexador1x16 port map(dependler1orler2Mux1, resultMux2, entradaDadosR2, entradaDados01);
			
			Dmux1: demultiplexador4x16 port map(escReg, entradaDadosR1, entradaDados00, dadoR2, entradaDados02, entradaDados03, entradaDados04, entradaDados05, entradaDados06, entradaDados07, entradaDados08, entradaDados09, entradaDados10, entradaDados11, entradaDados12, entradaDados13, entradaDados14, entradaDados15);
			Dmux2: demultiplexador4x1 port map(escReg, controlRegister1, controlRegister100, controlRegister101, controlRegister102, controlRegister103, controlRegister104, controlRegister105, controlRegister106, controlRegister107, controlRegister108, controlRegister109, controlRegister110, controlRegister111, controlRegister112, controlRegister113, controlRegister114, controlRegister115);
			
			R00: flipflop port map (clock, clearReset, controlRegister100, 						entradaDados00, saida00); -- $zero
			R01: flipflop port map (clock, clearReset, controlRegister101 OR controlRegister2, entradaDados01, saida01); -- $highReg
			R02: flipflop port map (clock, clearReset, controlRegister102, 						entradaDados02, saida02); -- $lowReg
			R03: flipflop port map (clock, clearReset, controlRegister103, 						entradaDados03, saida03); -- $compareReg
			R04: flipflop port map (clock, clearReset, controlRegister104, 						entradaDados04, saida04); -- $s0
			R05: flipflop port map (clock, clearReset, controlRegister105, 						entradaDados05, saida05); -- $s1
			R06: flipflop port map (clock, clearReset, controlRegister106, 						entradaDados06, saida06); -- $s2
			R07: flipflop port map (clock, clearReset, controlRegister107, 						entradaDados07, saida07); -- $s3
			R08: flipflop port map (clock, clearReset, controlRegister108, 						entradaDados08, saida08); -- $s4
			R09: flipflop port map (clock, clearReset, controlRegister109, 						entradaDados09, saida09); -- $s5
			R10: flipflop port map (clock, clearReset, controlRegister110, 						entradaDados10, saida10); -- $s6
			R11: flipflop port map (clock, clearReset, controlRegister111, 						entradaDados11, saida11); -- $s7
			R12: flipflop port map (clock, clearReset, controlRegister112, 						entradaDados12, saida12); -- $t0
			R13: flipflop port map (clock, clearReset, controlRegister113, 						entradaDados13, saida13); -- $t1
			R14: flipflop port map (clock, clearReset, controlRegister114, 						entradaDados14, saida14); -- $t2
			R15: flipflop port map (clock, clearReset, controlRegister115, 						entradaDados15, saida15); -- $t3
			
end bancoregistradores;
