onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /Adder_4bits_TB/s_A
add wave -noupdate -radix decimal /Adder_4bits_TB/s_B
add wave -noupdate /Adder_4bits_TB/s_cin
add wave -noupdate -radix decimal /Adder_4bits_TB/s_Sum
add wave -noupdate -color Red /Adder_4bits_TB/s_cout
add wave -noupdate -color Yellow /Adder_4bits_TB/s_overflow
add wave -noupdate /Adder_4bits_TB/UUT/A
add wave -noupdate /Adder_4bits_TB/UUT/B
add wave -noupdate /Adder_4bits_TB/UUT/cin
add wave -noupdate /Adder_4bits_TB/UUT/Sum
add wave -noupdate /Adder_4bits_TB/UUT/cout
add wave -noupdate /Adder_4bits_TB/UUT/overflow
add wave -noupdate -radix binary /Adder_4bits_TB/UUT/w_cout
add wave -noupdate -divider FA_instances
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_0/a
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_0/b
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_0/cin
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_0/s
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_0/cout
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_1/a
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_1/b
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_1/cin
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_1/s
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_1/cout
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_2/a
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_2/b
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_2/cin
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_2/s
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_2/cout
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_3/a
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_3/b
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_3/cin
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_3/s
add wave -noupdate -group FA_instances /Adder_4bits_TB/UUT/FA_3/cout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {111520 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 201
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {120867 ps}
