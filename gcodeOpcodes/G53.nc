(MSG@startTest - G53.nc)

(G53 should be modal and affect only the current line)
(for all other lines, the current coordinate system should take effect)
G10 L2 P1 x4 y4 y-4
g54
g0 x0 y0 z0  
g53 x0 y0 z0 
g0 x10 y10 z-10 (x14 y14 z-14)  

G10 L2 P2 x5 y5 y-5
g55
g0 x0 y0 z0  
g53 x0 y0 z0 
g0 x10 y10 z-10 (x15 y15 z-15)  

G10 L2 P3 x6 y6 y-6
g56
g0 x0 y0 z0  
g53 x0 y0 z0 
g0 x10 y10 z-10 (x16 y16 z-16)

G10 L2 P4 x7 y7 y-7
g57
g0 x0 y0 z0  
g53 x0 y0 z0 
g0 x10 y10 z-10 (x17 y17 z-17) 

G10 L2 P5 x8 y8 y-8
g58
g0 x0 y0 z0  
g53 x0 y0 z0 
g0 x10 y10 z-10 (x18 y18 z-18)  

G10 L2 P6 x9 y9 y-9
g59
g0 x0 y0 z0  
g53 x0 y0 z0 
g0 x10 y10 z-10  (x19 y19 z-19)

(mill should be in g59)
(mill should be at x19 y19 z-19)
(MSG@finishTest - G53.nc)
