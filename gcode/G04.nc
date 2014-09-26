(MSG@startTest - G04.nc)

g0 x0 y0 z0  (starting position - change as needed)
g4 p1        (pause for 1 second)
g00 x5 y5
g4 p2        (pause for 2 seconds)
m3 s30000
g4 p5        (spindle should stay on at max speed for 5 seconds)
s1
g4 p5        (spindle should stay on at min speed for 5 seconds)
m5
g01 x40 f1000
g4 p2        (should move to x40 at f1000)
f200
g4 p10       (MSG should not appear for 10 seconds)

(spindle should have stayed on for a total of 10 seconds)
(?? total time for run?)
(MSG@finishTest - G04.nc)
