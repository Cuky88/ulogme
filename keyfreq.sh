#!/bin/bash


# logs the key press frequency over 9 second window. Logs are written 
# in logs/keyfreqX.txt every 9 seconds, where X is unix timestamp of 7am of the
# recording day.

LANG=de_DE.utf8

helperfile="/home/cuky/Devel/ulogme/logs/keyfreqraw.txt" # temporary helper file

mkdir -p logs

while true
do
  sudo /usr/bin/showkey > $helperfile &
  PID=$!
  
  # work in windows of 9 seconds 
  sleep 9
  #sudo kill -9 `ps -e | grep showkey | cut -b1-6`
  sudo kill $PID
  
  # count number of key release events
  num=$(cat $helperfile | grep losgelassen | wc -l)
  
  # append unix time stamp and the number into file
  logfile="/home/cuky/Devel/ulogme/logs/keyfreq_$(python /home/cuky/Devel/ulogme/rewind7am.py).txt"
  echo "$(date +%s) $num"  >> $logfile
  #echo "logged key frequency: $(date) $num release events detected into $logfile"
  
done

