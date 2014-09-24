(MSG@startTest - G92.2.nc)
g10 l2 p6 x30 y30 z-30
g10 l2 p5 x60 y60 z-35

g59
g0 x0 y0 z0  (starting position - change as needed)

g92 x10 y10 z10
g00 x0 y0 z0      (should be at x20 y20 z-40)
g92.2
g00 x25 y25 z10   (should be at x55 y55 z-20)

g58
g00 x3 y3 z3      (should be at x62 y62 z-33)

(mill should be at x62 y62 z-33 in machine coords)
(MSG@finishTest - G92.2.nc)
