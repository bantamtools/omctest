(MSG@startTest - G80.nc)
g90
g10 l2 p6 x0 y0 z-60
g59
g00 x0 y0 z0  (starting position - change as needed)
g91           (incremental movement - easier to track errors)
g01 x1 y1 z1 f800
g80           (motion mode should no longer be G01)
x2 y2 z2      (no motion should occur, this should return an error)
g00 x4 y4 
g80
x8 y8 z4
g01 x16 y16
g80
x32 y32 z8
g90           (switch back to absolute movement for the arcs)
g02 x25 i2
g80
x64 y64 z16
g03 y25 j2


(there should be no error codes from the arcs - if so it means we were in the wrong origin or a previous value carried over)
(mill should be at x25 y25 z-59 in machine coords)
(MSG@finishTest - G80.nc)
