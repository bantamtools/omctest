(MSG@startTest - G02_center.nc)
g10 l2 p6 x50 y50 z-40
g59
f1000
g00 x0 y0 z0 
g17
(full cirlces, no axis words)
g02 i20.0 j0.0 
g02 i-20.0 
g02 i0.0 j20.0
g02 j-20.0
g01 x8
g02 i-8.0
(helical arc)
;g02 x15 y15 z11 i2.5 j2.5
;g02 x20 y10 z12 i2.5 j-2.5
;g02 x15 y5  z14 i
;g02 x10 y10 z18
;g02 x20 y10 i5 j0
;g02 x10 y10 i5
;g02 x15 i2.5 j0
;g02 x10 i2.5
;g02 x20 y20 


(set up G55 and switch to it)
;g10 l2 p2 x60 y60 z-30
;g55
;g0 z0 y0 z0 (starting point)
(full helical circles)
;g02 z5 i5.0 (x60 y60 z-25)
;g02 z10 j10.0 (x60 y60 z-20)

(full circle)
;g02 i2.5 (x60 y60 z-20)
;g02 j5.0 (x60 y60 z-20)

(helical)
;g02 x y z i j
;g02 x y z i
;g02 x y z j
;g02 x z i j
;g02 x z i
;g02 x z j
;g02 y z i j
;g02 y z i
;g02 y z j
;g02 z i j (*)


(flat)
;g02 x y i j
;g02 x y i
;g02 x y j
;g02 x i j
;g02 x i 
;g02 x j
;g02 y i j
;g02 y i
;g02 y j
;g02 i j (?)

(MSG@finishTest - G02_center.nc)
