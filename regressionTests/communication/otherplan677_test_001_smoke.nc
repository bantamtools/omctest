( test_001_smoke.h )
( This test checks basic functionality:)
(	- motor 1 CW at full speed ~3 seconds)
(	- motor 1 CCW at full speed ~3 seconds)
(	- motor 2 CW at full speed ~3 seconds)
(	- motor 2 CCW at full speed ~3 seconds)
(	- motor 3 CW at full speed ~3 seconds)
(	- motor 3 CCW at full speed ~3 seconds)
(	- motor 4 CW at full speed ~3 seconds)
(	- motor 4 CCW at full speed ~3 seconds)
(	- all motors CW at full speed ~3 seconds)
(	- all motors CCW at full speed ~3 seconds)
(	- all motors CW at medium speed ~3 seconds)
(	- all motors CCW at medium speed ~3 seconds)
(	- all motors CW at slow speed ~3 seconds)
(	- all motors CCW at slow speed ~3 seconds)
(	- light LEDs 1,2 and 4 in sequence for about 1 second each:)
(	- short finishing move)

G00 G17 G21 G40 G49 G80 G90
g0x0y0z0
g00 x30
x0
y30
y0
z30
z0
a30
a0
G00 x30 y30 z30 a30
G00 x0 y0 z0 a0
G01 f30 x2 y2 z2 a2
x0 y0 z0 a0
m3g4p1
m5g4p1
m4g4p1
m3g4p1
m5g4p1
m7g4p1
m9g4p1
m8g4p1
m9
g0x1
g0x0
m2
G01 f200 x10 y10 z10 a10
x0 y0 z0 a0
