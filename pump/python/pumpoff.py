#!/usr/bin/env python

import serial
import time
import sys

ser = serial.Serial('/dev/ttyUSB0',9600)

if ser.isOpen() :
	ser.close()

ser.open()
time.sleep(2)
ser.write("4")
out = ser.readline()
sys.stdout.write(out)
sys.stdout.flush()

ser.close
