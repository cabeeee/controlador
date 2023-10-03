library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DSP is
	
	Port ( clk : in STD_LOGIC;
			 rst : in STD_LOGIC;
			 digitos : out STD_LOGIC_VECTOR (3 DOWNTO 0);
			 seven_seg : out STD_LOGIC_VECTOR (7 DOWNTO 0));
end DSP;

architecture Behavioral of DSP is
		signal counter1 : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
	   signal counter2 : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
		signal counter3 : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
		signal counter4 : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
		signal counter  : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
		signal secuencia: STD_LOGIC_VECTOR (1 DOWNTO 0) := "00";
		
		signal clk_counter : STD_LOGIC_VECTOR (25 DOWNTO 0) := (OTHERS => '0');
		signal clk_counter2: STD_LOGIC_VECTOR (19 DOWNTO 0) := (OTHERS => '0');
		signal seg_signals : STD_LOGIC_VECTOR (7  DOWNTO 0) := "00000000";

begin 

process (clk,rst)
	begin
		if rst = '1' then
			counter1 <= "0000";
			counter2 <= "0000";
			counter3 <= "0000";
			counter4 <= "0000";
			clk_counter <= (others => '0');
			
		elsif rising_edge(clk) then
				clk_counter <= clk_counter + 1;
			if clk_counter = "00010011000100101101000000" then
				clk_counter <= (others => '0');
				
					counter1 <= counter1 +1;
					if counter1  = "1001" then
						counter1 <= "0000";
						counter2 <= counter2 + 1;
						if counter2 = "1001" then
							counter2 <= "0000";
							counter3 <= counter3 +1;
							if counter3 = "1001" then
								counter3 <= "0000";
								counter4 <= counter4 +1;
								end if;
							end if;
						end if;
					end if;
				end if;
			
end process;

process (clk)
	begin 
	
		if rising_edge(clk) then
			clk_counter2 <= clk_counter2 + 1;
			if clk_counter2 = "00110010110111001101" then
				secuencia <= secuencia + 1;
				clk_counter2 <= (others => '0');
			end if;
		end if;
end process;
		
			
process (secuencia,counter1,counter2,counter3,counter4) 
	
	begin
		case secuencia is
			when "00" =>
					counter <= counter1;
					digitos <= "1110";
			when "01" => 
					counter <= counter2;
					digitos <= "1101";
			when "10" =>
					counter <= counter3;
					digitos <= "1011";
			when "11" =>
					counter <= counter4;
					digitos <= "0111";
			when others =>
					counter <= "1111";
					digitos <= "1111";
		end case;
end process;

process (counter)

	begin
			case counter is
				when "0000" =>
						seg_signals <= "11000000";
				when "0001" =>
						seg_signals <= "11111001";
				when "0010" =>
						seg_signals <= "10100100";
				when "0011" =>
						seg_signals <= "10110000";
				when "0100" =>
						seg_signals <= "10011001";
				when "0101" =>
						seg_signals <= "10010010";
				when "0110" =>
						seg_signals <= "10000010";
				when "0111" =>
						seg_signals <= "11111000";
				when "1000" =>
						seg_signals <= "10000000";
				when "1001" =>
						seg_signals <= "10010000";
				when others =>
						seg_signals <= "00000000";
			end case;
end process;

seven_seg <= seg_signals;

end Behavioral;
				