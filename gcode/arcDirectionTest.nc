(This is designed to test the CW and CCW directions for each arc plane)
(If the arcs for a plane are interpreted correctly, the result will be a rough sine wave)
(If the arcs for a plane are intereprected incorrectly, the result will be a series of touching circles)


g0 x0 y0 z10

g17 (XY plane)
g01 y10 x10
g02 y20 i5  j5
    x20 i5  j-5
g03 x30 i5  j5
    y30 i-5 j5
g02 y40 i5  j5
    x40 i5  j-5
g03 x50 i5  j5
    y50 i-5 j5
g02 y60 i5  j5
    x60 i5  j-5
g03 x70 i5  j5
    y70 i-5 j5
g01 x80 y80
    x100
    y0 z10

g18  (XZ plane)
g01 x90
g02 x80 z20 i-10
    x70 z10 k-10
g03 x60 z0  i-10
    x50 z10 k10
g02 x40 z20 i-10
    x30 z10 k-10
g03 x20 z0  i-10
    x10 z10 k10
g01 x0

g19 (YZ plane)
g01 y10
g02 y20 z20 j10
    y30 z10 k-10
g03 y40 z0  j10
    y50 z10 k10
g02 y60 z20 j10
    y70 z10 k-10
g03 y80 z0  j10
    y90 z10 k10
g01 y100

g17  (reset arc plane to XY)
