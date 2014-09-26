(MSG@startTest - G92.nc)

g10 l2 p6 x30 y30 z-30
g10 l2 p5 x60 y60 z-35
g92.1        (cancel any previous G92 offsets)

g59
g0 x0 y0 z0  
g92 x10 y10 z10  (offsets x-10 y-10 z-10)
g00 x0 y0 z0     (should be at x20 y20 z-40)

g58
g00 x0 y0 z0     (should be at x50 y50 z-45)
g92 x-3 y-4 z-5  (offsets x-7 y-6 z-5)
g00 x0 y0 z0     (should be at x53 y54 z-40)

g59
g00 x0 y0 z0     (should be at x23 y24 z-35)
g92 x1 y1        (offsets x-8 y-7 z-5)
g00 x0 y0 z0     (should be at x22 y23 z-35)
g92 x7 z7        (offsets x-15 y-7 z-12)
g00 x0 y0 z0     (should be at x15 y23 z-42)
g92 y-4 z-4      (offsets x-15 y-3 z-8)
g00 x0 y0 z0     (should be at x15 y27 z-38)
g92 x-10         (offsets x-5 y-3 z-8)
g00 x0 y0 z0     (should be at x25 y27 z-38)
g92 y-40         (offsets x-5 y37 z-8)
g00 x0 y0 z0     (should be at x25 y67 z-38)
g92 z-20         (offsets x-5 y37 z12)
g00 x0 y0 z0     (should be at x25 y67 z-18)

(mill should be at x25 y67 z-18 in machine coords)
(G92 offsets values should be x-5 y37 z12)
(MSG@finishTest - G92.nc)
