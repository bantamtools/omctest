(radius format errors:)
( 1. both of the axis words for the axes of the selected plane are ommitted)
( 2. the end point of the arc is the same as the current point)
( 3. radius is omitted)
(MSG@startTest - G02_radius_negative.nc)
f1000
g00 x10 y10 z10 (starting point)
g17 (XY plane)
g02 z0 r2      (#1 - x10 y10 z0)
g02 x10 y10 r2 (#2 - x10 y10 z0)
g02 x1 y1    (#3 - x10 y10 z0)
g04 p1

x10 y10 z10 
g18 (XZ plane)
g02 y0 r2      (#1 - x10 y0 z0) 
g02 x10 z10 r2 (#2 - z10 y0 z10)
g02 x1 z1    (#3 - z10 y0 z10)
g04 p1

x10 y10 z10 
g19 (YZ plane)
g02 x0 r2      (#1 - x0 y0 z10)
g02 y10 z10 r2 (#2 - x0 y10 z10) 
g02 y1 z1    (#3 - x0 y10 z10) 
g04 p1

x10 y10 z10

(should get back something like {"r":{},"f":[1,70,20,3678]} - one per command in error)
(mill should still be at x10 y10 z10)
(MSG@finishTest - G02_radius_negative.nc)