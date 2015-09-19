(error if all axis words are ommitted)

(MSG@startTest - G01_negative.nc)
g10 l2 p6 x0 y0 z-40
g59
g00 x0 y0 z0  (change motion mode to G00)
g01           (error in NIST RS274NGC if all axes are missing - in tinyg this just changes the motion mode to G01)
;g01 xm y2 z2  (error 42)
;g01 x3 y$ z3  (error 42)
;g01 x4 y4 z-  (error 42)
g01 f0        (error 64)
g01 x5 y5 z5  (error 64)
(each G01 line with feedrate of 0 should generate an error code 64, 2 total errors)
(mill should be at x0 y0 z-40 machine coords)
(motion mode should still be G00)
(MSG@finishTest - G01_negative.nc)
