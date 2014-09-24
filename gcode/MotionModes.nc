(MSG@startTest - MotionModes.nc)
(spec has it as an error if all axis words are ommitted)
(NOTE: in tinyg, this is not an error.  instead, it changes the motion mode to g00/rapid)
g0 x0 y0 z0
g0   (motion mode should change to G0)
( -- insert json for getting current motion mode)
( -- motion mode in Otherplan should also be verified)
g1   (motion mode should change to G1)
( -- insert json for getting current motion mode)
( -- motion mode in Otherplan should also be verified)
g2   (motion mode should change to G2 - is g2 modal?)
( -- insert json for getting current motion mode)
( -- motion mode in Otherplan should also be verified)
g3   (motion mode should change to G3 - is g3 modal?)
( -- insert json for getting current motion mode)
( -- motion mode in Otherplan should also be verified)

g0 (reset motion mode to g0)

(mill should be in G0 motion mode)
(MSG@finishTest - MotionModes.nc)