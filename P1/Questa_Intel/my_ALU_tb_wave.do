onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color {Orange Red} /my_ALU_tb/rst
add wave -noupdate /my_ALU_tb/clk
add wave -noupdate -color Gray90 /my_ALU_tb/enable
add wave -noupdate -color Magenta -radix decimal /my_ALU_tb/A
add wave -noupdate -color Cyan -radix decimal /my_ALU_tb/B
add wave -noupdate -color {Green Yellow} -radix hexadecimal /my_ALU_tb/Control
add wave -noupdate -color {Medium Blue} -radix decimal /my_ALU_tb/Result
add wave -noupdate -color Gold /my_ALU_tb/carry
add wave -noupdate -color Orange /my_ALU_tb/overflow
add wave -noupdate -divider UUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {95 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {136 ns}
