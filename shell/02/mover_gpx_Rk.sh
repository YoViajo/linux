#!/bin/bash

cd /home/yoviajo/Dropbox/tmp/mi_watch_lite/
for f in *.gpx
do 
   mv -v "$f" /home/yoviajo/OneDrive/LAB/geomat/gps/mi_watch_lite/rocky/"${f%.gpx}".gpx
done

