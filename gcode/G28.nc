(MSG@startTest - G28_G28.1.nc)

g10 l2 p6 x25 y25 z-40
g59
g00 x0 y0 z0      (starting position - change as needed)
g00 x2 y4 z8
g28.1             (set 28.1 coords to current position - x27 y29 z-32)
g00 x90 y80 z0
g28               (should move directly to x2 y4 z-32)
g00 x50 y50 z0    (x75 y75 z-40 in machine coords)
g28 x75 y75 z-50  (axis values are in machine coords) (should move to x75 y75 z-50 first, then to x2 y4 z-32)

(mill should be at x2 y4 z-32 in machine coords)
(MSG@finishTest - G28_G28.1.nc)
