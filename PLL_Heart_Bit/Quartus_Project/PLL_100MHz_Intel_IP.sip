set_global_assignment -entity "PLL_100MHz_Intel_IP" -library "lib_PLL_100MHz_Intel_IP" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "PLL_100MHz_Intel_IP" -library "lib_PLL_100MHz_Intel_IP" -name IP_TOOL_VERSION "23.1"
set_global_assignment -entity "PLL_100MHz_Intel_IP" -library "lib_PLL_100MHz_Intel_IP" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_PLL_100MHz_Intel_IP" -name SPD_FILE [file join $::quartus(sip_path) "PLL_100MHz_Intel_IP.spd"]

set_global_assignment -library "lib_PLL_100MHz_Intel_IP" -name MISC_FILE [file join $::quartus(sip_path) "PLL_100MHz_Intel_IP_sim/PLL_100MHz_Intel_IP.vo"]
