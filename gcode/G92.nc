(MSG@startTest - G92.nc)
g10 l2 p6 x30 y30 z-30
g10 l2 p5 x60 y60 z-35

g59
g0 x0 y0 z0  (starting position - change as needed)

g92 x10 y10 z10
g00 x0 y0 z0     (should be at x20 y20 z-40)

g58
g00 x0 y0 z0     (should be at x50 y50 z-45)
g92 x-3 y-4 z-5
g00 x0 y0 z0     (should be at x53 y54 z-40)

g59
g00 x0 y0 z0     (should be at x23 y24 z-35)
g92 x1 y1 
g00 x0 y0 z0     (should be at x22 y23 z-35)
g92 x7 z7    
g00 x0 y0 z0     (should be at x15 y23 z-42)
g92 y-4 z-4
g00 x0 y0 z0     (should be at x15 y27 z-38)
g92 x-10 
g00 x0 y0 z0     (should be at x25 y27 z-38)
g92 y-40
g00 x0 y0 z0     (should be at x25 y67 z-38)
g92 z-20
g00 x0 y0 z0     (should be at x25 y67 z-18)

(mill should be at x25 y67 z-18 in machine coords)
(MSG@finishTest - G92.nc)
