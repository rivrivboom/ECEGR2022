onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tmemory_vhd/clock
add wave -noupdate /tmemory_vhd/reset
add wave -noupdate /tmemory_vhd/oe
add wave -noupdate /tmemory_vhd/we
add wave -noupdate /tmemory_vhd/writeReg
add wave -noupdate /tmemory_vhd/writeCmd
add wave -noupdate /tmemory_vhd/address
add wave -noupdate /tmemory_vhd/dataIn
add wave -noupdate /tmemory_vhd/dataOut
add wave -noupdate /ram/Reset
add wave -noupdate /ram/Clock
add wave -noupdate /ram/OE
add wave -noupdate /ram/WE
add wave -noupdate /ram/Address
add wave -noupdate /ram/DataIn
add wave -noupdate /ram/DataOut
add wave -noupdate /ram/i_ram
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {73 ns} {175 ns}
