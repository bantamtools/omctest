#!/usr/bin/env python

import sys
import os
import math

class Point:
    def __init__(self, x=0.0, y=0.0):
        self.x = x
        self.y = y

def append(line):
    global gcode
    gcode += line + "\n"


gcode = ""
#radius = 0.396875     # 1/32"
radius = 1.5875     # 1/8"
diameter = radius * 2
stepOver = 0.5
clearingStepOver = diameter * 0.65
material = Point(19.0,89.0) # standard 5"x4" FR-4 board

plungerate = 200
maxfeedrate = 1500
#stepDown = 0.0254  #0.001"
stepDown = 0.127  #0.005"
#stepDown = 0.635  #0.025"
#stepDown = 3.175  #0.125"
stepDownFrequency = 5
materialThickness = 22.5

# go with conventional milling (not climb milling)
append("g53 z0")
append("g00 x" + str(material.x) + " y" + str(material.y))
append("m3 s16500")
append("g01 z1 f800")

depth = 0.0
currY = material.y

while currY >= 0 and depth > -materialThickness:
    depth -= stepDown
    append("g01 z%2.5f f%4i" %(depth, plungerate))
    append("g04 p0.25")
    feedrate = min(maxfeedrate, (maxfeedrate * -(radius/depth)))
    append("g01 x0 f%d" %feedrate)
    if (stepDownFrequency > 1):
        # face an area equivalent to x = material width & y = (stepDownFrequency * stepOver)
        heightToFace = stepDownFrequency * stepOver * diameter
        passesToFace = int(math.ceil(heightToFace / clearingStepOver))
        append("g01 y%2.5f" %(currY - (clearingStepOver*passesToFace)))
        append("x%2.5f" %(material.x))
        append("y%2.5f" %(currY))
        append("x0")
        for y in range(1, passesToFace):
           append("y%2.5f" %(currY - y*clearingStepOver))
           append("x%2.5f" %(material.x))
           append("x0")
        currY -= stepDownFrequency*stepOver*diameter
    append("g00 z0.5")
    currY -= diameter * stepOver
    append("g00 x%2.5f y%2.5f" %(material.x, currY)) 

append("g53 z0")
append("m5")
append("m30")
print (gcode)
