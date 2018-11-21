#!/bin/bash

pump=`/home/pi/prkotel/pump/python/pumpstatus.py`
echo $pump
echo $pump > /home/pi/prkotel/pump/status
