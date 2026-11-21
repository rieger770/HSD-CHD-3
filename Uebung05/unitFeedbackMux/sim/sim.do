# Run in ModelSim (Transcript, current dir = this sim folder):   do sim.do
# Verzoegerungszeiten (Faelle 1-7): direkt in PrimImp und Hazardfree (gleiche Werte!)
if {![file exists work]} { vlib work }

vcom -2002 -explicit ../src/FeedbackMux-e.vhd
vcom -2002 -explicit ../src/FeedbackMux-PrimImp-a.vhd
vcom -2002 -explicit ../src/FeedbackMux-Hazardfree-a.vhd
vcom -2002 -explicit ../src/TbFeedbackMux-e.vhd
vcom -2002 -explicit ../src/TbFeedbackMux-a.vhd

# +acc keeps internal signals (Yc, Yn, nEn, Impl1..3) visible in the wave window
vsim -voptargs=+acc work.TbFeedbackMux

add wave -divider Testbench
add wave /TbFeedbackMux/En /TbFeedbackMux/D
add wave /TbFeedbackMux/QPrimImp /TbFeedbackMux/QHazardfree
add wave -divider PrimImp
add wave /TbFeedbackMux/uutPrimImp/nEn /TbFeedbackMux/uutPrimImp/Impl1 /TbFeedbackMux/uutPrimImp/Impl2 /TbFeedbackMux/uutPrimImp/Yn /TbFeedbackMux/uutPrimImp/Yc
add wave -divider Hazardfree
add wave /TbFeedbackMux/uutHazardfree/nEn /TbFeedbackMux/uutHazardfree/Impl1 /TbFeedbackMux/uutHazardfree/Impl2 /TbFeedbackMux/uutHazardfree/Impl3 /TbFeedbackMux/uutHazardfree/Yn /TbFeedbackMux/uutHazardfree/Yc

run -all
wave zoom full
