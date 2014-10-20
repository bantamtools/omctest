#!/usr/bin/env python

from Tkinter import *
from math import *

class Point:
   def __init__(self, x=0, y=0):
      self.x = x
      self.y = y

class Shapes(Frame):
   def __init__(self, master=None):
      Frame.__init__(self, master)
      self.initialize()
      self.createUI()
      self.grid(sticky=N+S+E+W)


   def initialize(self):
      self.canvasWidth = 600
      self.canvasHeight = 600
      self.points = []
      self.intersectionsDrawn = False


   def createUI(self):
      self.mainFrame = Frame(self)
      self.mainFrame.grid(row=0, column=0)
      self.canvas = Canvas(self.mainFrame, width=self.canvasWidth, height=self.canvasHeight, bg='black')
      self.canvas.grid(sticky=N+S+E+W)  # ?
      
      self.inputFrame = Frame(self, bd=5)
      self.inputFrame.grid(row=0, column=1)
      
      Label(self.inputFrame, text='# of sides').grid(row=0, column=0)
      self.numSides = IntVar(value=3)
      self.numSidesInput = Entry(self.inputFrame, textvariable=self.numSides, width=5)
      self.numSidesInput.grid(row=0, column=1)

      Label(self.inputFrame, text='length of side (mm)').grid(row=1, column=0)
      self.sideLength = StringVar(value=2)
      self.sideLengthInput = Entry(self.inputFrame, textvariable=self.sideLength, width=5)
      self.sideLengthInput.grid(row=1, column=1)

      self.intersectionsShown = BooleanVar()
      self.intersectionsInput = Checkbutton(self.inputFrame, text='Show Intersections', variable=self.intersectionsShown, command=self.intersectionsClicked)
      self.intersectionsInput.grid(row=2, columnspan=2)
      
      Button(self.inputFrame, text='Create', command=self.calculateShape).grid(row=3, columnspan=2)
      Button(self.inputFrame, text='Clear All', command=self.deleteAll).grid(row=4, columnspan=2)
      Button(self.inputFrame, text='Export Gcode to Clipboard', command=self.exportGcode).grid(row=5, columnspan=2)
      #Button(self.inputFrame, text='Delete Last', command=self.deleteLast).grid(row=4,column=1)

    
   def calculateShape(self):
      sides = self.numSides.get()
      length = float(self.sideLength.get())
      degreesPerSide = 360.0/self.numSides.get()
      x = 0 
      y = 0
      totalDegrees = 0 
      #self.previousShapeIds = []
      self.points = []
      self.points.append(Point(x,y))
      self.minx = self.maxx = self.miny = self.maxy = 0

      while totalDegrees < 360:
         newx = cos(radians(totalDegrees)) * length + x
         newy = sin(radians(totalDegrees)) * length + y
         self.minx = min(newx, self.minx)
         self.maxx = max(newx, self.maxx)
         self.miny = min(newy, self.miny)
         self.maxy = max(newy, self.maxy)
         #print "next point: %2.4f, %2.4f" %(newx, newy)
         self.points.append(Point(newx, newy))
         totalDegrees += degreesPerSide
         #print "   total degrees: %2.4f" %(totalDegrees)
         x = newx
         y = newy
      # move all x coordinates into positive space
      xoffset = abs(self.minx)
      self.points = [Point(p.x+xoffset, p.y) for p in self.points]
      self.shapeWidth = self.maxx - self.minx
      self.shapeHeight = self.maxy - self.miny
      #print "shape dimensions: %2.4f, %2.4f" %(self.shapeWidth, self.shapeHeight)
      self.drawShape()


   def drawShape(self):
      self.canvas.delete(ALL)
      self.scaleDimension = max(self.shapeWidth, self.shapeHeight)
      self.scaleFactor = self.canvasWidth / (self.scaleDimension + 1)
      self.offset = (self.canvasWidth - (self.scaleDimension * self.scaleFactor)) / 2
      #print "scale factor: %2.4f" %(self.scaleFactor)

      for i in range(0, len(self.points)):
         if i < len(self.points) - 1:
            startPoint = self.points[i]
            endPoint = self.points[i+1]
         else:
            startPoint = self.points[i]
            endPoint = self.points[0]

         lineId = self.drawLine(startPoint, endPoint)
      #self.previousShapeIds.append(lineId)
      self.intersectionsDrawn = False
      self.intersectionsClicked()

   
   def deleteAll(self):
      self.canvas.delete(ALL)
      self.points = []
      self.intersectionsDrawn = False
      #self.intersectionsShown.set(0)

  
   def exportGcode(self):
      # export shape outline first
      if len(self.points) > 1:
         self.gcode = '' 
         for i in range(1, len(self.points)):
            self.gcode += 'G01 X%.3f Y%.3f F1000\n' %(self.points[i].x, self.points[i].y)
         self.clipboard_clear()
         self.clipboard_append('G55 G21 G90\n')
         self.clipboard_append('G00 X%.3f Y%.3f\n' %(self.points[0].x, self.points[0].y))
         self.clipboard_append('G01 Z1 F700\n')
         self.clipboard_append('G01 Z0.5 F200\n')
         self.clipboard_append('M3 S12000\n')
         self.clipboard_append('G04 P.5\n')
         self.clipboard_append('G01 Z-0.2 F70\n')
         self.clipboard_append(self.gcode + '\n')
         self.clipboard_append('G00 Z10\n')
         self.clipboard_append('M30\n')


   #def deleteLast(self):
   #   for id in previousShapeIds:
   #      self.canvas.delete(id)


   def intersectionsClicked(self):
      if self.intersectionsDrawn == False:
         if self.intersectionsShown.get() == True:
            intersections = [[0 for i in range(self.numSides.get())] for j in range(self.numSides.get())]
            # mark off already drawn lines
            numIntersections = 0

            for i in range(len(intersections)):
               following = self.wrap(i+1)
               preceding = self.wrap(i-1)
               intersections[i][i] = 1
               intersections[i][following] = 1
               intersections[i][preceding] = 1
               numIntersections += 3

            currentPoint = 0
            while numIntersections < pow(self.numSides.get(), 2):
               lineDrawn = False
               for i in range(self.numSides.get()):
                  if intersections[currentPoint][i] == 0:
                     line = self.drawLine(self.points[currentPoint], self.points[i], 'intersection')
                     intersections[currentPoint][i] = 1
                     numIntersections += 1
                     currentPoint = i
                     lineDrawn = True
                     break
               if lineDrawn == False:
                  if currentPoint == self.numSides.get()-1:
                     currentPoint = 0
                  else:
                     currentPoint += 1
            self.intersectionsDrawn = True
      elif self.intersectionsShown.get() == False:
         intersectionLines = self.canvas.find_withtag('intersection')
         for i in intersectionLines:
            self.canvas.itemconfig(i, state=HIDDEN)
      else:
         intersectionLines = self.canvas.find_withtag('intersection')
         for i in intersectionLines:
            self.canvas.itemconfig(i, state=NORMAL)
      
   
   def wrap(self, index):
      if index >= self.numSides.get():
         index = self.numSides.get() - index
      elif index < 0:
         index = self.numSides.get() + index
      return index

   
   def drawLine(self, startPoint, endPoint, tags=None):
      return  self.canvas.create_line((startPoint.x) * self.scaleFactor + self.offset, self.canvasHeight - (startPoint.y*self.scaleFactor) - self.offset, \
                                      (endPoint.x) * self.scaleFactor + self.offset, self.canvasHeight - (endPoint.y*self.scaleFactor) - self.offset, fill='white', tags=tags)
      


root = Tk()
app = Shapes(root)
app.master.title("2D Shape -> Gcode")
app.mainloop()
