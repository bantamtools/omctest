#!/usr/bin/env python

import serial
import json
import sys
import os
import subprocess
import time

global repeat
debug = False

def getValue(command):
    return command[command.index(":")+1:]


# simple error checking - at least one argument, file must exist
print sys.argv
#if sys.argv[2] == "--debug":
#    debug = True
if len(sys.argv) <= 1:
    print "Please pass in a gcode file to run"
    exit(1)
elif not os.path.isfile(sys.argv[1]):
    print "Specified file does not exist: ", argv[1]
    exit(1)

# list the usb devices and use the first one
if (not debug):
    command = "ls /dev/cu.*usb*"
    try:
        results = subprocess.check_output(command, stderr=subprocess.STDOUT, shell=True)
        print "usb devices list: ", results
        if len(results) <= 0:
            print "No USB devices found using '" + command + "'. Exiting."
            exit(1)
        else:
            devices = results.split()
    except subprocess.CalledProcessError:
        print "Error calling '" + command + "'.  Exiting."
        exit(1)

# load the file, the error checking above should have ensured it's existence
input_file = open(sys.argv[1], 'r')
lines = list(input_file)

# setup and open serial connection to the mill
if (not debug):
    ser = serial.Serial()
    # for now, use the first device found
    ser.port = devices[0]
    ser.baudrate = 115200
    ser.bytesize = 8
    ser.parity = 'N'
    ser.stopbits = 1
    ser.xonxoff = True
    ser.timeout = 0.5

    ser.open()

    if not ser.isOpen():
        print "Could not open the serial port"
        exit(1)

# parse header for variables and remove them from the list as they are found
for x in range(0, len(lines)):
    if lines[x].startswith("("):
        command = lines[x].strip()[1:-1] # get everything between the parentheses
        if command.startswith("repeat"):
            global repeat
            repeat = int(getValue(command))
            del lines[x]
            print "Will repeat the file ", repeat, " times"
        elif command.startswith("MSG"):
            print "message: " + command
            break
    
for y in range(0, repeat):
    print "\n**** ITERATION ", y+1, " OF ", repeat, " ****"
    for line in lines:
        if line.startswith("("):
            #parseCommand(line)
            command = line.strip()[1:-1] # get everything between the parentheses
            if command.startswith("pause") or command.startswith("wait"):
                duration = getValue(command)
                print "pausing for " + duration + " seconds"
                time.sleep(int(duration)) 
            #elif command.startswith("error"):
            #    errorCode = getValue(command)
            #    expectErrorCode = True
            #    print "expecting error code " + errorCode + " after next gcode command"
            elif command.startswith("MSG"):
                print "message: " + command
            else:
                print "comment: " + command
        else:
            print line.rstrip('\n')

        if (not debug):
            ser.write(line)
            line = ser.readline()
            while len(line) > 0:
                print line
                line = ser.readline()
                #if (expectErrorCode):
                #   # regex for errorCode here
                #   print "expecting error: " + errorCode
                
        #if (not foundErrorCode):
if (not debug):
    if (ser.isOpen()):
        ser.close()
       
