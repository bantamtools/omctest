(it is an error if:)
(  Axis words are programmed when G80 is active, unless a modal group 0 G code is programmed which uses axis words.

(MSG@startTest - G80.nc)
g90
g10 l2 p6 x60 y60 z-40
g59
g0 x0 y0 z0  (starting position - change as needed)
g80
x10
y10
z10

(mill should not move from starting position)
(mill should still be at x60 y60 z-40 in machine coords)
(MSG@finishTest - G80.nc)
