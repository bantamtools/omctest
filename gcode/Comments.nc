(MSG@startTest - comments.nc)
g0 x0 y0 z0
g0 x1 (no trailing parentheses should be okay
g4 p1
g0 x2 ;this also counts as a comment
g4 p1
g0 x4 (valid and complete comment)
g4 p1
m3 s7800
(s13000)
;s13000
(m30)
;m30
g0 x5 y5 z5  (the move visually separates the m30 above from the m5 below)
g4 p3
m5
(multiple comment 1/4) (multiple comment 2/4) (multiple comment 3/4) (multiple comment 4/4)
g4 p1
(any command after a comment should be ignored with tinyg) g0 x8
g4 p1
;any command after a comment should be ignored with tinyg g0 x16
g4 p1
(any command after a comment should be ignored with tinyg g0 x32
g4 p1


(mill should be at x4)
(MSG@finishTest - comments.nc)