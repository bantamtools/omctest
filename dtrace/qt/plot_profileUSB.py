#!/usr/bin/python

# Parse dtrace script profileUSB.d output and generate plot
# $ ./plotProfileUSB.py <profileUSB.d output file>

import numpy as np
import matplotlib.pyplot as plt
import os
import sys

readPipeData = []
readPipeDataFull = []
readPipeDataEmpty = []
writePipeData = []

xRead0 = []
yRead0 = []
xRead1 = []
yRead1 = []
xWrite = []
yWrite = []

def findLines(searchString, inData, outData):
	for line in inData:
		if searchString in line:
			outData.append(line)
			
def findReadEmptyFull(inData, emptyData, fullData):
	for line in inData:
		if int(line.split()[5]) > 0:
			fullData.append(line)
		else:
			emptyData.append(line)

def genPlotData(x, y, inData, xIndex, yIndex, xOffset):
	for row in inData:
		if int(row.split()[yIndex]) < 100000000: # handle race condition in dtrace script
			x.append((int(row.split()[xIndex])/1000000) - xOffset)
			y.append(int(row.split()[yIndex]))
		else:
			print("Found error in data: " + row)

fileName = str(sys.argv[1])


with open(os.path.abspath(fileName)) as f:
    data = f.read()

data = data.split('\n')

findLines('readEnd', data, readPipeData)
print "# of readEnd lines: ", len(readPipeData)
findReadEmptyFull(readPipeData, readPipeDataEmpty, readPipeDataFull)
findLines('writeEnd', data, writePipeData)	
print "# of writeEnd lines: ", len(writePipeData)
		    
start = int(readPipeData[0].split()[9])/1000000

genPlotData(xRead0, yRead0, readPipeDataEmpty, 9, 7, start)
genPlotData(xRead1, yRead1, readPipeDataFull, 9, 7, start)
genPlotData(xWrite, yWrite, writePipeData, 12, 10, start)

fig = plt.figure()
ax1 = fig.add_subplot(111)

ax1.set_title("read behavior (" + fileName + ")")    
ax1.set_xlabel('timestamp (ms)') 
ax1.set_ylabel('time elapsed (ns)')

noDataLine, = ax1.plot(xRead0, yRead0, 'r+', label='read duration (no data)')
dataLine, = ax1.plot(xRead1, yRead1, 'g+', label='read duration (some data)')
writeLine, = ax1.plot(xWrite, yWrite, 'bx', label='write duration')

leg = ax1.legend(fancybox=True, shadow=True, markerscale=1.2, loc=2)
leg.get_frame().set_alpha(0.2)

plotLines = [noDataLine, dataLine, writeLine]
legendLines = dict()
for legend, plot in zip(leg.get_lines(), plotLines):
        legend.set_picker(5) # 5 pts tolerance
        legendLines[legend] = plot

def onpick(event):
        clickedLine = event.artist
        graphLine = legendLines[clickedLine]
        isVisible = graphLine.get_visible()
        graphLine.set_visible(not isVisible)  # toggle visibility

        # also change alpha on line in legend
        if isVisible:
                clickedLine.set_alpha(1.0)
        else:
                clickedLine.set_alpha(0.2)
        fig.canvas.draw()

fig.canvas.mpl_connect('pick_event', onpick)

#plt.xlim(0, 20000)
#plt.ylim(-10, 1000)

plt.show()
