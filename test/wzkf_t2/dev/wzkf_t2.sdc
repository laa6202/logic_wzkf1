## Generated SDC file "wzkf_t2.sdc"

## Copyright (C) 2016  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Intel and sold by Intel or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 16.1.0 Build 196 10/24/2016 SJ Standard Edition"

## DATE    "Sun Mar 18 18:04:49 2018"

##
## DEVICE  "EP4CE75F23I7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {mclk0} -period 20.000 -waveform { 0.000 10.000 } [get_ports {mclk0}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {u_clk_rst|u_sgpll|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {u_clk_rst|u_sgpll|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 2 -master_clock {mclk0} [get_pins {u_clk_rst|u_sgpll|altpll_component|auto_generated|pll1|clk[0]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {u_clk_rst|u_sgpll|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {u_clk_rst|u_sgpll|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u_clk_rst|u_sgpll|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {u_clk_rst|u_sgpll|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u_clk_rst|u_sgpll|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {u_clk_rst|u_sgpll|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u_clk_rst|u_sgpll|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {u_clk_rst|u_sgpll|altpll_component|auto_generated|pll1|clk[0]}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

