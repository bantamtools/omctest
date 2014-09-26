(MSG@startTest - G01.nc)

g10 l2 p6 x10 y10 z-30
g59
g00 x0 y0 z0   (starting position - change as needed)
g01 x80 f100   (x90 y10 z-30)
g01 y80 f400   (x90 y90 z-30)
g01 x0 f800    (x10 y90 z-30)
g01 y0 f1200   (x10 y10 z-30)
g01 z-25 f1500 (x10 y10 z-55)
g01 z20  f300  (x10 y10 z-10)

(?? time taken to execute moves? ~81 seconds)
(mill should be at x10 y10 z-10 in machine coords)
(MSG@finishTest - G01.nc)
