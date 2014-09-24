(MSG@startTest - G21.nc)
g10 l6 p2 x0 y0 z-40
g59
g00 x0 y0 z0  (starting position - change as needed)
g21           (switch to millimeters)
g00 x30 y30 z10
g20 
g91           (switch to incremental distance mode)
g00 x1 y1 z0.5 (x55.4 y55.4 z-17.3)
g21
g00 x-25 y-25 z-20 (x30.4 y30.4 z-37.3) 
g90           (clean up)

(mill should be at x30.4 y30.4 z-37.3 in machine coords)
(MSG@finishTest - G21.nc)
