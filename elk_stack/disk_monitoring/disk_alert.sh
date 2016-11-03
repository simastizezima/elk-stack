#!/bin/sh

df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output; 

do
  echo $outpot
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1 )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $usep -ge 10 ]; then
    echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" | 
     mail -s "Alert: Almost out of disk space $usep%" root@ubuntu
  fi
done
