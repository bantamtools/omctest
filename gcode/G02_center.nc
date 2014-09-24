(ijk format errors:)
(EMC2 - linuxcnc)
(    1. When the arc is projected on the selected plane, the distance from the current point to the center differs from the distance from the end point to the center by more than:)
(    1a. [.05 inch/.5 mm] OR ...)
(    1b. [[.0005 inch/.005mm] AND .1% of radius])
(    2. The axis words are all optional except that at least one of X and Y must be used to program an arc of less than 360 degrees) (THIS IS NOT TESTED HERE)
(    3a. G17 - it is an error if I and J are both omitted - if only one is specified, the value of the other is taken as 0)
(    3b. G18 - it is an error if I and K are both omitted - if only one is specified, the value of the other is taken as 0)
(    3c. G19 - it is an error if J and K are both omitted - if only one is specified, the value of the other is taken as 0)
(***********************************)
(NOTE: TinyG adheres to EMC2 here more than RS274NGC, hence the following)
(      error cases will not be tested.  The documentation is left in for)
(      completeness.)
(RS274NGC)
(    1. when the arc is projected on the selected plane, the distance from the current point to the center differs from the distance from the end point to the center by more than 0.0002 inch or 0.002 millimeter)
(    2a. G17 - it is an error if X and Y are both omitted)  (tinyg )
(    2b. G17 - it is an error if I and J are both omitted)
(    3a. G18 - it is an error if X and Z are both omitted)
(    3b. G18 - it is an error if I and K are both omitted)
(    4a. G19 - it is an error if Y and Z are both omitted)
(    4b. G19 - it is an error if J and K are both omitted)


(MSG@startTest - G02_center.nc)
f1000
g00 x10 y10 z10 
g17
(full cirlces, no axis words)
g2 i22.0 j0.0  (should end up at x54 y10 z10)
g2 i30.0
(helical arc)
g2 x15 y15 z11 i2.5 j2.5
g2 x20 y10 z12 i2.5 j-2.5
g2 x15 y5  z14 i
g2 x10 y10 z18
g2 x20 y10 i5 j0
g2 x10 y10 i5
g2 x15 i2.5 j0
g2 x10 i2.5
g2 x20 y20 


(The axis words are all optional except that at least one of X and Y must be 
 used to program an arc of less than 360 degrees. I and J are the offsets from 
 the current location (in the X and Y directions, respectively) of the center 
 of the circle. I and J are optional except that at least one of the two must 
 be used. If only one is specified, the value of the other is taken as 0. If 
 you include the Z word it will spiral. )
(set up G55 and switch to it)
g10 l2 p2 x60 y60 z-30
g55
g0 z0 y0 z0 (starting point)
(full helical circles)
g2 z5 i5.0 (x60 y60 z-25)
g2 z10 j10.0 (x60 y60 z-20)

(full circle)
g2 i2.5 (x60 y60 z-20)
g2 j5.0 (x60 y60 z-20)

(helical)
g2 x y z i j
g2 x y z i
g2 x y z j
g2 x z i j
g2 x z i
g2 x z j
g2 y z i j
g2 y z i
g2 y z j
g2 z i j (*)


(flat)
g2 x y i j
g2 x y i
g2 x y j
g2 x i j
g2 x i 
g2 x j
g2 y i j
g2 y i
g2 y j
g2 i j (?)







g00 x10 y10 z10 (starting point)
g17             (XY plane)
g02               (#3a) (this is not actually an error in tinyg - this is taken as a command to set the motion type)
g02 x10 y10       (#3a)
g02 z0            (#3a - x10 y10 z0)
g02 x12.6 i1      (#1a - start->center=1mm, end->center=1.6mm)
g02 x21.0055 i5.5 (#1b - start->center=5.5mm, end->center=5.555mm)
g02 y12.6 j1      (#1a - start->center=1mm, end->center=1.6mm)
g02 y21.0055 j5.5 (#1b - start->center=5.5mm, end->center=5.555mm)
g04 p1

x10 y10 z10 
g18             (XZ plane)
g02               (#3a) (this is not actually an error in tinyg - this is taken as a command to set the motion type)
g02 x10 z10       (#3a)
g02 y0            (#3a - x10 y0 z10)
g02 x12.6 i1      (#1a - start->center=1mm, end->center=1.6mm)
g02 x21.0055 i5.5 (#1b - start->center=5.5mm, end->center=5.555mm)
g02 z12.6 k1      (#1a - start->center=1mm, end->center=1.6mm)
g02 z21.0055 k5.5 (#1b - start->center=5.5mm, end->center=5.555mm)
g04 p1

x10 y10 z10 
g19             (YZ plane)
g02               (#3a) (this is not actually an error in tinyg - this is taken as a command to set the motion type)
g02 y10 z10       (#3a)
g02 x0            (#3a - x0 y10 z10)
g02 y12.6 j1      (#1a - start->center=1mm, end->center=1.6mm)
g02 y21.0055 j5.5 (#1b - start->center=5.5mm, end->center=5.555mm)
g02 z12.6 k1      (#1a - start->center=1mm, end->center=1.6mm)
g02 z21.0055 k5.5 (#1b - start->center=5.5mm, end->center=5.555mm)
g04 p1

x10 y10 z10

(should get back something like {"r":{},"f":[1,70,20,3678]} - one per command in error)
(mill should still be at x10 y10 z10)
(MSG@finishTest - G02_center.nc)
