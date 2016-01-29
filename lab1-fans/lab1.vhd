library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

-- The above libaries lines must be included in every VHDL file, before EVERY ENTITY!

--
-- Main circuit Entity: connects all wires to the FPGA IO pins.
-- PORT mapping - declare all wire connections to INput or OUTput pins.
-- Note that all signal names here are fixed by the "DE2_pins.csv" file which you must use for every lab
--   

entity Lab1 is port(
      
      key   : in  std_logic_vector(2 downto 0); -- 3 push buttons on the board - HIGH when not pressed
      sw    : in  std_logic_vector(1 downto 1); -- use 1 out of 18 switches on the board LOW when down towards edge of board

      ledr  : out std_logic_vector(0 downto 0); -- 1 red LED, if lit, indicates brake control is on
      ledg  : out std_logic_vector(0 downto 0)  -- 1 green LED, if lit, indicates gas control is on
);
end Lab1;

architecture CarSimulator of Lab1 is

--
-- Create the temporary variables reprensting our input signals
--
-- Signals are either a vector or not.  A vector is a group of two or more signals
--
-- Note that there are two basic types and we nearly always use std_logic:
-- UNSIGNED is a signal which can be used to perform math operations such as +, -, *
-- std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--

signal gas, clutch, brake, override: std_logic;  -- four signals for inputs
signal gas_control, brake_control: std_logic;  -- two signals for LED outputs (one green and one red)

-- The function of CarSimulator entity is defined here

begin

-- Associate the input signals with the corresponding engine function

   gas <= key(0); 
   clutch <= key(1); 
   brake <= key(2);
   override <= sw(1);

-- The outputs of gas_control and brake_control are defined with the following boolean functions

   gas_control <= (not override) and (not brake) and (not clutch) and gas;
   brake_control <= override or brake;
   
 
-- assign intermediate signals to output ports

   ledg(0) <= gas_control;
   ledr(0) <= brake_control;	

end CarSimulator;
