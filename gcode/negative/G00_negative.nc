(It is an error if:)
(  An axis letter is without a real value.)

(MSG@startTest - G00_negative.nc)
g10 l2 p6 x0 y0 z-60
g59
g00 x0 y0 z0
g00 xm y0 z0
g00 x1 ym z1
g00 x2 y2 zm
(each line should generate an error code)
(mill should be at x0 y0 z-60 machine coords)
(MSG@finishTest - G00_negative.nc)
