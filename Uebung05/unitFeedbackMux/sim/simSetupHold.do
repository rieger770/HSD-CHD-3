# Aufgabe 2 - Setup/Hold (Architecture Hazardfree)
# Run in ModelSim (Transcript, current dir = this sim folder):   do simSetupHold.do
if {![file exists work]} { vlib work }

vcom -2002 -explicit ../src/FeedbackMux-e.vhd
vcom -2002 -explicit ../src/FeedbackMux-Hazardfree-a.vhd
vcom -2002 -explicit ../src/TbFeedbackMuxSetupHold-e.vhd
vcom -2002 -explicit ../src/TbFeedbackMuxSetupHold-a.vhd

vsim -voptargs=+acc work.TbFeedbackMuxSetupHold

add wave -divider Testbench
add wave -radix decimal /TbFeedbackMuxSetupHold/Shift
add wave /TbFeedbackMuxSetupHold/En /TbFeedbackMuxSetupHold/D /TbFeedbackMuxSetupHold/Q
add wave -divider Hazardfree
add wave /TbFeedbackMuxSetupHold/uut/nEn /TbFeedbackMuxSetupHold/uut/Impl1 /TbFeedbackMuxSetupHold/uut/Impl2 /TbFeedbackMuxSetupHold/uut/Impl3 /TbFeedbackMuxSetupHold/uut/Yn /TbFeedbackMuxSetupHold/uut/Yc

run -all
wave zoom full
