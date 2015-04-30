#!/usr/bin/python

# Parse memAndCPUProfile output and generate a plot
# usage: ./plotMemAndCPUData.py <memAndCPUProfile.sh output file>

import numpy as np
import matplotlib.pyplot as plt
import os
import sys

timeData = []
cpuData = []
memoryData = []
stateData = []
rssData = []

fileName = str(sys.argv[1])
lineNum = 0

for line in open(os.path.abspath(fileName)):
    if (lineNum == 0):
        lineNum += 1
        continue
    lineNum += 1
    data = line.split()
    timeData.append(data[0])
    cpuData.append(float(data[1]))
    memoryData.append(float(data[2]))
    stateData.append(data[3])
    rssData.append(int(data[4]) / 1024)
    print "line ", lineNum, ": ", timeData[-1], ",", cpuData[-1], ",", memoryData[-1], ",", stateData[-1], ",", rssData[-1]

#fig = plt.figure()
#ax1 = fig.add_subplot(111)

#ax1.set_xlabel('time') 
#ax1.set_ylabel('percentage')
fig, ax = plt.subplots()
axes = [ax, ax.twinx()]
axes[0].set_title("memory and cpu usage\n(" + fileName + ")\n")    
fig.subplots_adjust(right=0.75)

axes[0].plot(cpuData, color='Blue')
axes[0].set_ylabel('cpu usage (%)', color='Blue')
axes[0].tick_params(axis='y', colors='Blue')
axes[1].plot(rssData, color='Green')
axes[1].set_ylabel('memory usage (M)', color='Green')
axes[1].tick_params(axis='y', colors='Green')
axes[0].set_xlabel('time')
    
#cpuLine, = ax1.plot(cpuData, 'b', label='cpu usage (%)')
#rssData, = ax1.plot(rssData, 'r', label='memory usage (M)')

#leg = ax1.legend(fancybox=True, shadow=True, markerscale=1.2, loc=2)
#leg.get_frame().set_alpha(0.2)

#plotLines = [noDataLine, dataLine, handlerLine, writeLine, errorLine]
#legendLines = dict()
#for legend, plot in zip(leg.get_lines(), plotLines):
#        legend.set_picker(5) # 5 pts tolerance
#        legendLines[legend] = plot

#def onpick(event):
#        clickedLine = event.artist
#        graphLine = legendLines[clickedLine]
#        isVisible = graphLine.get_visible()
#        graphLine.set_visible(not isVisible)  # toggle visibility

#        # also change alpha on line in legend
#        if isVisible:
#                clickedLine.set_alpha(1.0)
#        else:
#                clickedLine.set_alpha(0.2)
#        fig.canvas.draw()

#fig.canvas.mpl_connect('pick_event', onpick)

#plt.xlim(0, 20000)
#plt.ylim(-10, 1000)

plt.show()
