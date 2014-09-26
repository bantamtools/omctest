(MSG@startTest - G93.nc)

g10 l2 p6 x0 y0 z-40
g59
g0 x0 y0 z0  (starting position - change as needed)
g93
g01 x100 y100 z5 f4 (should take 15 seconds to traverse)

(movement should take 15 seconds to complete)
(mill should end at x100 y100 z-35 in machine coords)
(MSG@finishTest - G93.nc)
