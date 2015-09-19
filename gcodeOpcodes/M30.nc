(MSG@startTest - M30.nc)

g10 l2 p6 x35 y35 z-35 (set g59 offet)
g59 (switch to g59)
g00 x0 y0 z0 
g92 x10 y10 z10 (offset should put g59 origin at x25 y25 z-45)
g18 (change to xz plane)
g91 (change to incremental distance mode)
g93 (change to inverse time feed rate)
m3 s7800 (turn on spindle, lowest rpm)
g01 x0 y0 z0 F1500
m7 (mist coolant on)
g20 (change to inches mode)

M30
(From TinyG documentation: https://github.com/synthetos/TinyG/wiki/Gcode-Support#g10-set-parameters-offsets)
(program END [M2, M30]- performs the following actions:)
(    Axis offsets are set to G92.1 CANCEL offsets)
(    Set default coordinate system [uses $gco])
(    Selected plane is set to default plane [$gpl])
(    Distance mode is set to MODE_ABSOLUTE [like G90])
(    Feed rate mode is set to UNITS_PER_MINUTE [like G94])
(    The spindle is stopped [ike M5])
(    Motion mode is canceled like G80 [not set to G1])
(    Coolant is turned off [like M9])
(    Default INCHES or MM units mode is restored [$gun])
(MSG@finishTest - M30.nc)
