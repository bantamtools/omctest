(MSG@startTest - ReorderingWords.nc)
X0 Y0 


(MSG@finishTest - ReorderingWords.nc)

(MSG@startTest - <name>.nc)
g90 g0 x0 y0 z0  (starting position - change as needed)
y10 f800 g55 g1 g91 s7800 m3 x10 (x10 y10, spindle on at 7800rpm)
g90 z-5 g1 x50 g53 m5 y50        (x50 y50 z-5 in machine coord, spindle off)
f1000 s12800 x10 g21 y10 m3 g91  (x60 y60, spindle on at 12800rpm)
m5								 (spindle off)
 i0 x10 y-10 g02 j-10             (x70 y50)
g03 g90 z10 m3 f500 x80 y40 i10  (x80 y40 z10+material height, spindle on)
m5								 (spindle off)

(final position should be x80 y40 z10+material height, spindle off, no errors should be reported by TinyG)
(MSG@finishTest - <name>.nc)