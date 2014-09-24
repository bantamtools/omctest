#!/usr/bin/env python

"""
Arc Buddy G-Code Generator
Version 1.6
Copyright (C) <2008>  <John Thornton>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

e-mail me any suggestions to "bjt 128 at gmail dot com"
If you make money using this software
you must donate $20 USD to a local food bank
or the food police will get you! Think of others from time to time...

To make it a menu item in Ubuntu use the Alacarte Menu Editor and add 
the command python YourPathToThisFile/face.py
make sure you have made the file execuatble by right
clicking and selecting properties then Permissions and Execute

To use with EMC2 see the instructions at: 
http://wiki.linuxcnc.org/cgi-bin/emcinfo.pl?Simple_EMC_G-Code_Generators

Inspired by Sebastian Jardi Estadella's addition to send the output to gEdit
I've decided to incorporate it into Arc Buddy and make some additions that
should make this program actually useful.

The following instructions are for Ubuntu 10.04
Open Gedit and navigate to Edit > Preferences > Plugins and check off
External Tools to add them to your menu.
Go to Tools > Manage External Tools and click on the page with a star in the
lower left corner above the Help button. This adds a new Tool. Change the name
of New Tool to something that makes sense to you like Arc Buddy and hit Enter
to save the new name. Add a shortcut key if you like. Change Output: to 
Insert at cursor position. In the Edit: box change line 1 to:
python full/path/to/arcbuddy/arcbuddy.py

Close the External Tools Manager and your ready to use Arc Buddy in Gedit
after you close and reopen Gedit.

When your creating G code in Gedit go to Tools > External Tools > Arc Buddy
Add the required data and click Show Me to see or click Send to send the
output to Gedit.

"""

from Tkinter import *
from math import *
import os
import random

IN_AXIS = os.environ.has_key("AXIS_PROGRESS_BAR")

class Application(Frame):
  def __init__(self, master=None):
    Frame.__init__(self, master)
    self.grid()
    self.initialize()
    self.createWidgets()

  def initialize(self):
    self.offsetx = 140
    self.offsety = 140
    self.xmax = 135
    self.xmin = 0
    self.ymax = 115
    self.ymin = 0
    self.gcodeDict = {}

  def createWidgets(self):
    self.PreviewFrame = Frame(self)
    self.PreviewFrame.grid(row=0, column=0)
    self.PreviewCanvas = Canvas(self.PreviewFrame,width=600, height=600, bg='white')
    self.PreviewCanvas.grid(sticky=N+S+E+W)
    self.Outline = self.PreviewCanvas.create_rectangle(self.offsetx, self.offsety,self.xmax*2+self.offsetx, self.ymax*2+self.offsety)

    self.EntryFrame = Frame(self,bd=5)
    self.EntryFrame.grid(row=0, column=1)

    self.st00 = Label(self.EntryFrame, text='Figure out the G2/3 Code')
    self.st00.grid(row=0, column=0, columnspan=2)

    self.st01 = Label(self.EntryFrame, text='X Center of Arc')
    self.st01.grid(row=1, column=0)
    self.XArcCenterVar = StringVar()
    self.XArcCenter = Entry(self.EntryFrame, textvariable=self.XArcCenterVar ,width=15)
    self.XArcCenter.grid(row=1, column=1)

    self.st02 = Label(self.EntryFrame, text='Y Center of Arc')
    self.st02.grid(row=2, column=0)
    self.YArcCenterVar = StringVar()
    self.YArcCenter = Entry(self.EntryFrame, textvariable=self.YArcCenterVar ,width=15)
    self.YArcCenter.grid(row=2, column=1)

    self.st03 = Label(self.EntryFrame, text='Diameter of Arc')
    self.st03.grid(row=3, column=0)
    self.ArcDiameterVar = StringVar()
    self.ArcDiameter = Entry(self.EntryFrame, textvariable=self.ArcDiameterVar ,width=15)
    self.ArcDiameter.grid(row=3, column=1)

    self.st04 = Label(self.EntryFrame, text='Start Angle')
    self.st04.grid(row=4, column=0)
    self.StartAngleVar = StringVar()
    self.StartAngle = Entry(self.EntryFrame, textvariable=self.StartAngleVar ,width=15)
    self.StartAngle.grid(row=4, column=1)

    self.st05 = Label(self.EntryFrame, text='End Angle')
    self.st05.grid(row=5, column=0)
    self.EndAngleVar = StringVar()
    self.EndAngle = Entry(self.EntryFrame, textvariable=self.EndAngleVar ,width=15)
    self.EndAngle.grid(row=5, column=1)

    self.st05 = Label(self.EntryFrame, text='Direction')
    self.st05.grid(row=6, column=0)        
    self.DirectionVar = IntVar()
    self.CCWButton = Radiobutton(self.EntryFrame, text='CCW', value=0, variable=self.DirectionVar)
    self.CCWButton.grid(row=6, column=1, sticky = W)

    self.CWButton = Radiobutton(self.EntryFrame, text='CW', value=1, variable=self.DirectionVar)
    self.CWButton.grid(row=6, column=1, sticky = E)

    self.st07 = Label(self.EntryFrame, text='Feed Rate')
    self.st07.grid(row=7, column=0)
    self.FeedRateVar = StringVar()
    self.FeedRate = Entry(self.EntryFrame, textvariable=self.FeedRateVar ,width=15)
    self.FeedRate.grid(row=7, column=1)

    self.sp00 = Label(self.EntryFrame, text=' ')
    self.sp00.grid(row=8)

    self.st06 = Label(self.EntryFrame, text='Starting Point for the Arc')
    self.st06.grid(row=9, column=0, columnspan=2) 
    self.StartPointVar = StringVar()  
    self.StartPoint = Entry(self.EntryFrame, width=30, textvariable = self.StartPointVar)
    self.StartPoint.grid(row=10, column=0, columnspan=2)

    self.st06 = Label(self.EntryFrame, text='G Code for the Arc')
    self.st06.grid(row=11, column=0, columnspan=2) 
    self.ArcCodeVar = StringVar()  
    self.ArcCode = Entry(self.EntryFrame, width=35, textvariable = self.ArcCodeVar)
    self.ArcCode.grid(row=12, column=0, columnspan=2)

    self.sp01 = Label(self.EntryFrame, text=' ')
    self.sp01.grid(row=13)
    
    self.DoItButton = Button(self.EntryFrame, text='Show Me', command=self.DoIt)
    self.DoItButton.grid(row=14, column=0)
    
    self.ToClipboard = Button(self.EntryFrame, text='To Clipboard', command=self.CopyClipboard)
    self.ToClipboard.grid(row=14, column=1)

    self.RandomizeButton = Button(self.EntryFrame, text='Randomize', command=self.Randomize)
    self.RandomizeButton.grid(row=15, column=0)

    self.ClearButton = Button(self.EntryFrame, text='Clear All', command=self.ClearAll)
    self.ClearButton.grid(row=15, column=1)
    
    self.quitButton = Button(self, text='Quit', command=self.quit)
    self.quitButton.grid(row=16, column=2, sticky=S)


  def DoIt(self):
      self.XArcCenterN = float(self.XArcCenterVar.get())
      self.YArcCenterN = float(self.YArcCenterVar.get())
      self.ArcStart = float(self.StartAngleVar.get())
      self.ArcEnd = float(self.EndAngleVar.get())
      self.ArcDirection = float(self.DirectionVar.get())
      self.ArcRadius = float(self.ArcDiameterVar.get())/2

      if self.ArcDirection == 0: #CCW
          if self.ArcStart < self.ArcEnd:
              self.ArcDegrees = self.ArcEnd - self.ArcStart
          elif self.ArcStart > self.ArcEnd:
              self.ArcDegrees = (360 - self.ArcStart) + self.ArcEnd
          elif self.ArcStart == self.ArcEnd:
              self.ArcDegrees = 360
          startDegree = self.ArcStart

      elif self.ArcDirection == 1: # CW
          if self.ArcStart > self.ArcEnd:
              self.ArcDegrees = self.ArcStart - self.ArcEnd
          elif self.ArcStart < self.ArcEnd:
              self.ArcDegrees = (360 - self.ArcEnd) + self.ArcStart
          elif self.ArcStart == self.ArcEnd:
              self.ArcDegrees = 360
          startDegree = self.ArcEnd

      # draw the arc
      #boundingbox = (self.XArcCenterN-self.ArcRadius)*2+self.offsetx, (self.YArcCenterN-self.ArcRadius)*2+self.offsety,\
      #    (self.XArcCenterN+self.ArcRadius)*2+self.offsetx, (self.YArcCenterN+self.ArcRadius)*2+self.offsety
      boundingbox = (self.XArcCenterN-self.ArcRadius)*2+self.offsetx, (self.ymax-self.YArcCenterN-self.ArcRadius)*2+self.offsety,\
          (self.XArcCenterN+self.ArcRadius)*2+self.offsetx, (self.ymax-self.YArcCenterN+self.ArcRadius)*2+self.offsety
      self.ArcId = self.PreviewCanvas.create_arc(boundingbox, extent=self.ArcDegrees, start=startDegree, style='arc', tag='generatedArc')

      # draw the center of the arc
      self.OvalId = self.PreviewCanvas.create_oval(self.XArcCenterN*2+self.offsetx-1, (self.ymax-self.YArcCenterN)*2+self.offsety-1, \
          self.XArcCenterN*2+self.offsetx+1, (self.ymax-self.YArcCenterN)*2+self.offsetx+1, fill="blue", tag='generatedCenter')
      self.PreviewCanvas.tag_bind(self.OvalId, '<Button-1>', self.OnArcClick)

      # generate the G code
      
      # find the X and Y start point and offset
      if self.ArcStart <= 90: # Quadrant 1
          self.XStart = self.XArcCenterN + (self.ArcRadius * cos(radians(self.ArcStart)))
          self.YStart = self.YArcCenterN + (self.ArcRadius * sin(radians(self.ArcStart)))
          self.StartPointVar.set('X%3.4f Y%3.4f' %(self.XStart, self.YStart))
          self.IOffset = -(self.XStart - self.XArcCenterN)
          self.JOffset = -(self.YStart - self.YArcCenterN)

      elif self.ArcStart > 90 and self.ArcStart <= 180: # Quadrant 2
          self.XStart = self.XArcCenterN - (self.ArcRadius*sin(radians(self.ArcStart-90)))
          self.YStart = self.YArcCenterN + (self.ArcRadius*cos(radians(self.ArcStart-90)))
          self.StartPointVar.set('X%3.4f Y%3.4f' %(self.XStart, self.YStart))
          self.IOffset = abs(self.XStart - self.XArcCenterN)
          self.JOffset = -(self.YStart - self.YArcCenterN)

      elif self.ArcStart > 180 and self.ArcStart <= 270: # Quadrant 3
          self.XStart = self.XArcCenterN - (self.ArcRadius*cos(radians(self.ArcStart-180)))
          self.YStart = self.YArcCenterN - (self.ArcRadius*sin(radians(self.ArcStart-180)))
          self.StartPointVar.set('X%3.4f Y%3.4f' %(self.XStart, self.YStart))
          self.IOffset = abs(self.XStart - self.XArcCenterN)
          self.JOffset = abs(self.YStart - self.YArcCenterN)

      elif self.ArcStart > 270 and self.ArcStart <= 360: # Quadrant 4
          self.XStart = self.XArcCenterN + (self.ArcRadius*sin(radians(self.ArcStart-270)))
          self.YStart = self.YArcCenterN - (self.ArcRadius*cos(radians(self.ArcStart-270)))
          self.StartPointVar.set('X%3.4f Y%3.4f' %(self.XStart, self.YStart))
          self.IOffset = -(self.XStart - self.XArcCenterN)
          self.JOffset = -(self.YStart - self.YArcCenterN)

      # find the X and Y end point
      if self.ArcEnd <= 90: # Quadrant 1
          self.XEnd = self.XArcCenterN + (self.ArcRadius * cos(radians(self.ArcEnd)))
          self.YEnd = self.YArcCenterN + (self.ArcRadius * sin(radians(self.ArcEnd)))
          self.ArcEndPoint = 'X%3.4f Y%3.4f' %(self.XStart, self.YStart)
      elif self.ArcEnd > 90 and self.ArcEnd <= 180: # Quadrant 2
          self.XEnd = self.XArcCenterN - (self.ArcRadius*sin(radians(self.ArcEnd-90)))
          self.YEnd = self.YArcCenterN + (self.ArcRadius*cos(radians(self.ArcEnd-90)))
          self.ArcEndPoint = 'X%3.4f Y%3.4f' %(self.XStart, self.YStart)
      elif self.ArcEnd > 180 and self.ArcEnd <= 270: # Quadrant 3
          self.XEnd = self.XArcCenterN - (self.ArcRadius*cos(radians(self.ArcEnd-180)))
          self.YEnd = self.YArcCenterN - (self.ArcRadius*sin(radians(self.ArcEnd-180)))
          self.ArcEndPoint = 'X%3.4f Y%3.4f' %(self.XStart, self.YStart)
      elif self.ArcEnd > 270 and self.ArcEnd <= 360: # Quadrant 4
          self.XEnd = self.XArcCenterN + (self.ArcRadius*sin(radians(self.ArcEnd-270)))
          self.YEnd = self.YArcCenterN - (self.ArcRadius*cos(radians(self.ArcEnd-270)))
          self.ArcEndPoint = 'X%3.4f Y%3.4f' %(self.XStart, self.YStart)


      # alternate between CW and CCW arcs
      # also randomly choose between center and radius format arcs
      if self.ArcDirection == 0: # CCW
          arcCode = "G3 "
      elif self.ArcDirection == 1: # CW
          arcCode = "G2 "
      arcCode += 'X%.3f Y%.3f ' %(self.XEnd, self.YEnd)
      if (random.getrandbits(4)%2 == 0):    # radius arc
          if (self.ArcDegrees >= 180): 
              arcCode += 'R-%.3f' %(self.ArcRadius) 
          else:
              arcCode += 'R%.3f' %(self.ArcRadius)
      else:                                 # center arc
          arcCode += 'I%.3f J%.3f' %(self.IOffset, self.JOffset)

      self.ArcCodeVar.set(arcCode)

      if self.FeedRateVar.get() <> '':
          self.gcode = 'F' + self.FeedRateVar.get() + '\n'
      else:
          self.gcode = ''
      self.gcode += 'G0 '+ self.StartPointVar.get() + '\n'
      self.gcode += self.ArcCodeVar.get() + '\n'
      self.gcodeDict[self.ArcId] = self.gcode

  def CopyClipboard(self):
      self.clipboard_clear()
      text = ''
      for key, value in self.gcodeDict.items():
          text += value 
      self.clipboard_append(text)
      self.clipboard_append('M30')   # append gcode to end program
  
  def Randomize(self): 
      # don't randomize feedrate, keep that constant (for now)
      # randomize diff values: 
      radiusmax = min(self.xmax/2.0, self.ymax/2.0)
      radiusmin = 0
      anglemax = 360
      anglemin = 0
   
      randomx = random.uniform(self.xmin, self.xmax)
      randomy = random.uniform(self.ymin, self.ymax)
      randomr = random.uniform(radiusmin, radiusmax)
      self.XArcCenter.delete(0, END)
      self.XArcCenter.insert(0, randomx)
      self.YArcCenter.delete(0, END)
      self.YArcCenter.insert(0, randomy)
      randomr = min(randomr, randomx, randomy, self.xmax-randomx, self.ymax-randomy)
      self.ArcDiameter.delete(0, END)
      self.ArcDiameter.insert(0, randomr*2.0)
      self.StartAngle.delete(0, END)
      self.StartAngle.insert(0, random.uniform(anglemin, anglemax))
      self.EndAngle.delete(0, END)
      self.EndAngle.insert(0, random.uniform(anglemin, anglemax))

      # alternate between CW and CCW arcs
      if self.DirectionVar.get() == 0:
        self.CCWButton.deselect()
        self.CWButton.select()
      else:
        self.CWButton.deselect()
        self.CCWButton.select() 
      self.DoIt()

  def ClearAll(self):
      arcs = self.PreviewCanvas.find_withtag('generatedArc')
      for id in arcs:
        self.PreviewCanvas.delete(id)

      centers = self.PreviewCanvas.find_withtag('generatedCenter')
      for id in centers:
        self.PreviewCanvas.delete(id)
     
      self.gcodeDict = {}

          
  def OnArcClick(self, event):
      canvas = event.widget
      x = canvas.canvasx(event.x)
      y = canvas.canvasy(event.y)
      item = canvas.find_closest(canvas.canvasx(event.x), canvas.canvasy(event.y))

      # delete the center oval of the arc, the clickable part
      try:
        canvas.delete(item)
      except AttributeError:
        print ("didn't find arc center item: ", item)
        pass

      # delete the arc associated with the oval, which should be the previously created item id
      try:
        canvas.delete(item[0]-1)
      except AttributeError:
        print ("didn't find arc item: ", item[0]-1)
        pass
      


app = Application()
app.master.title("Arc Buddy 1.6")
app.PreviewCanvas.pack()
app.mainloop()        


