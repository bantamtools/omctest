(MSG@startTest - G64.nc)
(from TinyG Gcode support: https://github.com/synthetos/TinyG/wiki/Gcode-Support#g61-g611-g64-path-control-modes)
(G64 is recognized, but is treated as exact path mode.)

g10 l2 p6 x60 y60 z-40
g59
g00 x0 y0 z0 
g61.1   (exact stop path control mode)
g00 x2 y2 
x4 y4
x6 y6
x8 y8
x10 y10 z2
y8
y6
y4
y2
y0 z4
x8
x6
x4
x2
x0 z6
y2
y4
y6
y8
y10 z8
x2 y12
x4 y14
x5 y15
x6 y14
x8 y12
x10 y10 z10
x8
x6
x4
x2
x0 z12
x2 y8
x4 y6
x6 y4
x8 y2
x10 y0 z14

(?? how long should this take to run ??)
(?? possibly in comparison to G60 ??)
(?? way to verify exact point after each move ??)
(mill should be at x70 y60 z-26)
(MSG@finishTest - G64.nc)
