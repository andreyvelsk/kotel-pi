#!/bin/bash

pump=`/home/pi/prkotel/pump/python/pumpoff.py`
echo $pump
echo 0 > /home/pi/prkotel/pump/status
