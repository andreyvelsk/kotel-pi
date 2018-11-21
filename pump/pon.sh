#!/bin/bash

pump=`/home/pi/prkotel/pump/python/pumpon.py`
echo $pump
echo 1 > /home/pi/prkotel/pump/status
