(MSG@startTest - G04i_negative.nc)
(it is an error if the P number is negative)
g0 x0 y0 z0    (starting position - change as needed)
g4 p-3         (right now, this causes the Othermill to become unresponsive and it must be power cycled) 
g0 x10 y10 z10

(I would expect an error code returned by tinyg: 44, 46 or 47)
(MSG@finishTest - G04_negative.nc)
