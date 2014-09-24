(It is an error if:)
(  all axis words are omitted.)

(MSG@startTest - G92_negative.nc)
g10 l2 p6 x30 y30 z-40
g59
g92
(should get error code back from tinyg - 65?)
(MSG@finishTest - G92_negative.nc)
