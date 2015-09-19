(MSG@startTest - G90.nc)

g10 l2 p6 x30 y30 z-40
g59
g0 x0 y0 z0  (starting position - change as needed)

g90
g0 x1 y1 z1  (should be at x31 y31 z-39)
g0 x1 y1 z1  (should be at x31 y31 z-39)
g0 x-4 y-4 z-4  (should be at x26 y26 z-44)
g02 x10 y10 r14 (should be at x40 y40 z-44)
g03 y-20 j15    (should be at x40 y10 z-44)

(mill should be at x40 y10 z-44 in machine coords)
(MSG@finishTest - G90.nc)
