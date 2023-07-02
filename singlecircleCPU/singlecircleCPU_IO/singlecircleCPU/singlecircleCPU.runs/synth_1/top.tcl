# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.cache/wt [current_project]
set_property parent.project_path D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo d:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_mem {
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/imports/singlecircleCPU/memfile.dat
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/imports/singlecircleCPU/memfileExt.dat
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/TestIO.dat
}
read_verilog -library xil_defaultlib -sv {
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/Hex7Seg.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/adder.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/alu.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/aludec.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/controller.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/dMemoryDecoder.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/datapath.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/dmem.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/flopr.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/imem.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/io.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/m7seg.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/maindec.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/mips.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/mux2.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/regfile.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/signext.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/signzero.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/sl2.sv
  D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/sources_1/new/top.sv
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/constrs_1/imports/vivadoprogram/Nexys4DDR_Master.xdc
set_property used_in_implementation false [get_files D:/vivadoprogram/singlecircleCPU/singlecircleCPU_IO/singlecircleCPU/singlecircleCPU.srcs/constrs_1/imports/vivadoprogram/Nexys4DDR_Master.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top top -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]