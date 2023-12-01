library IEEE;         
use IEEE.STD_LOGIC_1164.ALL;         

        
            entity miniGarage is
        
            port ( clk,btn,ir_sensor,reset : in std_logic;
                   enable,output1,output2 : out std_logic;
						 bcd_output : out STD_LOGIC_VECTOR(13 downto 0)
         
               );
        

            end miniGarage;
                
            architecture behavior of miniGarage is
				signal state: std_logic_vector(1 downto 0):="00"; --00 no motion, 01 opening, 10 closing 
            signal count : integer range 0 to 99 := 0;
				signal flag: std_logic; --for counting once
				
				begin

				enable<='1';
        
            MAIN:process(clk,reset)
        
            variable i : integer := 0;
        
            begin
        
        
            if clk'event and clk = '1'then
				    if reset='0' then
		             count<=0;
					
				    elsif btn='0' and state="00" then
					       state<="01";
						   flag<='0';
							 
				    elsif ir_sensor='0' and state="00" and flag='0'then
					       state<="10"; 
							 if count < 99 then
									count <= count + 1;
							 else
									count <= 0;
							 end if;
							 flag<='1';
					 end if;
            if i <= 1005000 then
        
              i := i + 1;
           
              output1 <= '0';
         
              output2 <= '0';
        
            elsif i > 1005000 and i < 111000000 then
        
              i := i + 1;
        
              output1 <= state(0);
        
              output2 <= state(1);
				
        
            elsif i = 111000000 then
              i := 0;
				  
				  
				  state<="00";
				  
				  output1 <= state(0);                                                                                   
        
              output2 <= state(1);
				
				else
				
			   	output1 <= '0';
               output2 <= '0';
        
            end if;           
            end if;
            end process;
				DISPLAY_PROC : process(clk)
    begin
        if rising_edge(clk) then
            case (count/10) is
                when 0 =>
                    bcd_output(13 downto 7) <= "0000001";
                when 1 =>
                    bcd_output(13 downto 7) <= "1001111";
                when 2 =>
                    bcd_output(13 downto 7) <= "0010010";
                when 3 =>
                    bcd_output(13 downto 7) <= "0000110";
                when 4 =>
                    bcd_output(13 downto 7) <= "1001100";
                when 5 =>
                    bcd_output(13 downto 7) <= "0100100";
                when 6 =>
                    bcd_output(13 downto 7) <= "0100000";
                when 7 =>
                    bcd_output(13 downto 7) <= "0001111";
                when 8 =>
                    bcd_output(13 downto 7) <= "0000000";
                when 9 =>
                    bcd_output(13 downto 7) <= "0001100";
                when others =>
                    bcd_output(13 downto 7) <= "-------";
            end case;
			   case (count rem 10) is
                when 0 =>
                    bcd_output(6 downto 0) <= "0000001";
                when 1 =>
                    bcd_output(6 downto 0) <= "1001111";
                when 2 =>
                    bcd_output(6 downto 0) <= "0010010";
                when 3 =>
                    bcd_output(6 downto 0) <= "0000110";
                when 4 =>
                    bcd_output(6 downto 0) <= "1001100";
                when 5 =>
                    bcd_output(6 downto 0) <= "0100100";
                when 6 =>
                    bcd_output(6 downto 0) <= "0100000";
                when 7 =>
                    bcd_output(6 downto 0) <= "0001111";
                when 8 =>
                    bcd_output(6 downto 0) <= "0000000";
                when 9 =>
                    bcd_output(6 downto 0) <= "0001100";
                when others =>
                    bcd_output(6 downto 0) <= "-------";
            end case;
        end if;
    end process;

        
            end behavior;