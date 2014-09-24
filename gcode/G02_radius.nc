(MSG@startTest - G02_radius.nc)
f1000
g10 l2 p2 x60 y60 z-30
g55
g00 x0 y0 z0 (starting point)

x y z r
x y r
x z r
x r
y z r
y r
z r

g17 (XY plane)
g02 x4 y4 z4 r4 (x64 y64 z-26)
g02 x5 y5 r1    (x65 y65 z-26) 
g02 x6 z6 r0.5  (x66 y66 z-24)   
g02 x7 r1       (x67 y66 z-24)
g02 y8 z8 r0.5  (x67 y68 z-22)
g02 y9 r1       (x67 y69 z-22)

x10 y10 z10 
g18 (XZ plane)
g02 x y z r
g02 x y r
g02 x z r
g02 x r
g02 y z r
g02 z r

x10 y10 z10 
g19 (YZ plane)
g02 x y z r
g02 x y r
g02 x z r
g02 y z r
g02 y r
g02 z r

x10 y10 z10
(should get back something like {"r":{},"f":[1,70,20,3678]} - one per command in error)
(mill should still be at x10 y10 z10)
(MSG@finishTest - G02_radius.nc)
