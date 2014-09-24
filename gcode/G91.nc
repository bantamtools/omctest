(MSG@startTest - G91.nc)
g10 l2 p6 x30 y30 z-40
g59
g0 x0 y0 z0  (starting position - change as needed)

g91
g0 x1 y1 z1  (should be at x31 y31 z-39)
g0 x1 y1 z1  (should be at x32 y32 z-38)
g0 x-4 y-4 z-4  (should be at x28 y28 z-42)
g02 x10 y10 r10 (should be at x38 y38 z-42)
g03 y-20 j10    (should be at x38 y18 z-42)

(mill should be at x38 y18 z-42 in machine coords)
(MSG@finishTest - G91.nc)
