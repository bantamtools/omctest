(MSG@startTest - G93_negative.nc)
(it is an error if:)
(inverse time feed rate mode is active and a line with G1, G2, or G3 (explicitly or implicitly) does not have an F word)
g10 l2 p6 x0 y0 z-40
g59
g0 x0 y0 z0  (starting position - change as needed)
g93
g01 x100 y100 z5  (should return error code)
g02 x10 y10 r10   (should return error code)
g03 x20 y20 r10   (should return error code)

(no movement should occur)
(mill should end at x0 y0 z-40 in machine coords)
(MSG@finishTest - G93_negative.nc)