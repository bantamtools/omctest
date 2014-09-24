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
(    2a. G17 - it is an error if X and Y are both omitted)  (tinyg does not adhere to this)
(    2b. G17 - it is an error if I and J are both omitted)
(    3a. G18 - it is an error if X and Z are both omitted)  (tinyg does not adhere to this)
(    3b. G18 - it is an error if I and K are both omitted)
(    4a. G19 - it is an error if Y and Z are both omitted)  (tinyg does not adhere to this)
(    4b. G19 - it is an error if J and K are both omitted)  

(MSG@startTest - G02_center_negative.nc)
f1000
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
(MSG@finishTest - G02_center_negative.nc)
