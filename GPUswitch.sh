#!/bin/bash

currentgpu=$(prime-select query)
chgstate=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state)
input="none"
displaymanager=$(systemctl status display-manager.service | grep -oP '(?<=/)[^/]+(?=\.service)' | head -n 1)

if [[ $chgstate == *"fully-charged"* || $chgstate == *"pending-charge"* || $chgstate == *" charging"* ]]; then
  if [[ $currentgpu == "intel" ]]; then
    echo "Switching to nvidia (performance) gpu"
    $(sudo prime-select nvidia)
    $(sudo systemctl restart $displaymanager)
  else
    echo "Nvidia (performance, AC power)  gpu is already in use"
    echo "continue switching to intel ?(y/n)"
    read input
    if [[ $input == "y" || $input == "Y" || $input == "yes" || $input == "YES" || $input == "Yes" ]]; then
      echo "Switching to intel (power saving) gpu"
      $(sudo prime-select intel)
      $(sudo systemctl restart $displaymanager)
    else
      exit
    fi
  fi
fi



if [[ $chgstate == *"discharging"* ]]; then
  if [[ $currentgpu == "nvidia" ]]; then
    echo "Switching to intel (power saving) gpu"
    $(sudo prime-select intel)
    $(sudo systemctl restart $displaymanager)
  else  
    echo "Intel (power saving, battery powered) gpu is already in use"
    echo "continue switching to nvidia ?(y/n)"
    read input 
    if [[$input == "y" || $input == "Y" || $input == "yes" || $input == "YES" || $input == "Yes" ]]; then
      echo "Switching to nvidia (performance) gpu"
      $(sudo prime-select nvidia)
      $(sudo systemctl restart $displaymanager)
    else
      exit
    fi
  fi
fi
