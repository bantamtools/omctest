(MSG@startTest - G02_radius.nc)
(f1000
(g10 l2 p6 x60 y60 z-30
(g59
g00 x0 y0 z0 (starting point)

g17 (XY plane)
g02 x4 y4 z4 r4 (x64 y64 z-26)
g02 x5 y5 r1    (x65 y65 z-26) 
g02 x6 z6 r0.5  (x66 y66 z-24)   
g02 x7 r1       (x67 y66 z-24)
g02 y8 z8 r0.5  (x67 y68 z-22)
g02 y9 r1       (x67 y69 z-22)

(not rendering correctly in Otherplan - bug or pebkac?)
g18 (XZ plane)
g02 x3 y4 z4 r4 (x63 y64 z-26)
g02 x5 y10 r1   (x65 y70 z-26)
g02 x10 z-1 r5  (x70 y70 z-31)
g02 x20 r5      (x80 y70 z-31)
g02 y5 z8 r4.5  (x80 y65 z-22)
g02 z12 r2      (x80 y65 z-18)

g19 (YZ plane)
g02 x4 y13 z4 r8  (x64 y73 z-26)
g02 x30 y15 r1    (x90 y75 z-26)
g02 x22 z-15 r9.5 (x82 y75 z-45)
g02 y0 z-21.213 r21.213  (x82 y60 z-51.213)
g02 y-4 r2        (x82 y56 z-51.213)
g02 z0 r10.6065   (x82 y56 z-30)

(no error codes should be returned in footers)
(mill should be at x82 y56 z-30 in machine coords)
(MSG@finishTest - G02_radius.nc)
