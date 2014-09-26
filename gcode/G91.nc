(MSG@startTest - G91.nc)

g10 l2 p6 x30 y30 z-40
g59
g0 x0 y0 z0  (starting position - change as needed)

g91
m3 s7900
g00 x10 y10 z10  (should be at x40 y40 z-30)
g00 x10 y10 z10  (should be at x50 y50 z-20)
g00 x-4 y-4 z-4  (should be at x46 y46 z-24)
g02 x10 y10 r10  (should be at x56 y56 z-24)
g03 y-20 j10     (should be at x56 y36 z-24)
g01 x10 f750     (should be at x66 y36 z-24)
s 6000           (spindle speed should not change, make sure S isn't also treated incrementally with G91)
g01 y40 f750     (should be at x66 y76 z-24, feedrate should be 500, make sure it's not treated incrementally)
g53 x15 y15 z10  (should be at x81 y91 z-14, G53 shouldn't matter since it's incremental movement)
m30

(mill should be at x81 y91 z-14 in machine coords)
(MSG@finishTest - G91.nc)
