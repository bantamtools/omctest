(MSG@startTest - G30_G30.1.nc)

g10 l2 p6 x10 y10 z-40
g59
g00 x0 y0 z0  (starting position - change as needed)
g00 x2 y4 z8
g30.1         (set 30.1 coords to current position - x2 y4 z-32)
g00 x100 y100 z0
g30           (should move directly to x2 y4 z-32)
(?? add pause and verify ?)
g00 x50 y50 z0
g30 x75 y75 z-10  (should move to x75 y75 z-10 first [in machine coords], then to x2 y4 z-32)

(mill should be at x2 y4 z-32 in machine coords)
(MSG@finishTest - G30_G30.1.nc)
