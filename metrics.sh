#!/bin/bash  
while [[ -n "$1" ]]; do
  param=$1
  shift
  case $param in
      --types)
      types=$1
      shift
      ;;
  esac
done

if [[ "${types}"          == "" ]]; then
  echo "wrong type" 
  exit -1
fi

echo ${types}
if [[ "${types}" == "cpu" ]]; then
echo system.cpu.idle | tr "\n" " "
top -n 1 | grep -i cpu\(s\) | gawk -F, '{print $4}' | sed 's/%.*//'| tr id " "; 
echo system.cpu.user | tr "\n" " "
top -n 1 | grep -i Cpu\(s\) | gawk -F, '{print $1}' |sed 's/%.*://'| tr us " "; #us
echo  system.cpu.iowait | tr "\n" " "
top -n 1 | grep -i Cpu\(s\) | gawk -F, '{print $5}' |sed 's/%.*://'| tr wa " "; #iowait
echo system.cpu.stolen  | tr "\n" " "
top -n 1 | grep -i Cpu\(s\) | gawk -F, '{print $8}' |sed 's/%.*://'| tr st " "; #stoplen
echo system.cpu.system | tr "\n" " "
top -n 1 | grep -i Cpu\(s\) | gawk -F, '{print $2}' |sed 's/%.*://'| tr sy " "; #system
fi
if [[ "${types}" == "ram" ]]; then
echo "virtual total" | tr "\n" " "
vmstat -s | egrep 'total memory'|tr "K total memory" " "
echo "used memory" | tr "\n" " "
vmstat -s | egrep 'used memory' |tr "K used memory" " "
echo "free memory" | tr "\n" " "
vmstat -s | egrep 'free memory' |tr "K free memory" " "
echo "total swap" | tr "\n" " "
vmstat -s | egrep 'total swap'  |tr "K total swap" " "
echo "used swap" | tr "\n" " "
vmstat -s | egrep 'used swap'   |tr "K used swap" " "
echo "free swap" | tr "\n" " "
vmstat -s | egrep 'free swap'   |tr "K free swap" " "
fi

