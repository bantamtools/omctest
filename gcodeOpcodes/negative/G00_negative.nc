(It is an error if:)
(  An axis letter is without a real value.)

(MSG@startTest - G00_negative.nc)
g10 l2 p6 x0 y0 z-40
g59
g01 x0 y0 z0 f1000 (move to starting position)
g00 xm y0 z0
g00 x1 ym z1
g00 x2 y2 zm
(each G00 line should generate an error code 42, 3 total errors)
(mill should be at x0 y0 z-40 machine coords)
(motion mode should still be G01)
(MSG@finishTest - G00_negative.nc)
