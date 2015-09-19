(MSG@startTest - G92.1.nc)

g10 l2 p6 x30 y30 z-30
g10 l2 p5 x60 y60 z-35

g59
g0 x0 y0 z0  (starting position - change as needed)

g92 x10 y10 z10  (offsets x-10 y-10 z-10)
g00 x0 y0 z0     (should be at x20 y20 z-40)
g92.1            (offsets x0 y0 z0)
g00 x0 y0 z0     (should be at x30 y30 z-30)

(offset should be cancelled for all coord systems)
g58
g00 x0 y0 z0     (should be at x60 y60 z-35)
(reenabling the offset should do nothing)
g92.3            (offsets x0 y0 z0)
g00 x3 y3 z3     (should be at x63 y63 z-32)

(mill should be at x63 y63 z-32 in machine coords)
(G92 offset values should be x0 y0 z0)
(MSG@finishTest - G92.1.nc)
