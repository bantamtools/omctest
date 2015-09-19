(MSG@startTest - G92.3.nc)

g10 l2 p6 x30 y30 z-30
g10 l2 p5 x60 y60 z-35

g59
g0 x0 y0 z0  (starting position - change as needed)

(offset should be able to be disabled and reenabled)
g92 x10 y10 z10
g00 x0 y0 z0     (should be at x20 y20 z-40)
g92.2
g00 x0 y0 z0     (should be at x30 y30 z-30)
g92.3
g00 x5 y5 z5     (should be at x25 y25 z-35)

(offset enable should carry over to other coord systems)
g58
g00 x0 y0 z0     (should be at x55 y55 z-40)

(mill should be at x55 y55 z-40 in machine coords)
(MSG@finishTest - G92.3.nc)
