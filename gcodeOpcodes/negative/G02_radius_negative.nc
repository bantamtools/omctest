(radius format errors:)
( 1. both of the axis words for the axes of the selected plane are ommitted)
( 2. the end point of the arc is the same as the current point)
( 3. radius is omitted)
(MSG@startTest - G02_radius_negative.nc)
g10 l2 p6 x30 y30 z-30
g59
f1000
g00 x10 y10 z10 (starting point)
g17 (XY plane)
g02 z0 r2      (#1 - x10 y10 z0)
g02 x10 y10 r2 (#2 - x10 y10 z0)
g02 x1 y1      (#3 - x10 y10 z0)
g04 p1

x10 y10 z10    (need to reset axes between sections due to tinyg bug)
g18 (XZ plane)
g02 y0 r2      (#1 - x10 y0 z0) 
g02 x10 z10 r2 (#2 - z10 y0 z10)
g02 x1 z1      (#3 - z10 y0 z10)
g04 p1

x10 y10 z10    (need to reset axes between sections due to tinyg bug)
g19 (YZ plane)
g02 x0 r2      (#1 - x0 y0 z10)
g02 y10 z10 r2 (#2 - x0 y10 z10) 
g02 y1 z1      (#3 - x0 y10 z10) 
g04 p1

(each G02 line should generate an error code 70, 11 total errors)
(mill should be at x30 y30 z-30 in machine coords)
(MSG@finishTest - G02_radius_negative.nc)
