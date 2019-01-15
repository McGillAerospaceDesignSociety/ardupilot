#!/bin/bash

options=("Copter" "Plane" "Rover" "Quit")
vehicle=ArduCopter

echo "PLease select vehicle: "
select opt in "${options[@]}"
do
    case $opt in
        "Copter")
            simulator="../Tools/autotest/fg_quad_view.bat"
            break
            ;;
        "Plane")
            vehicle=ArduPlane
            simulator="../Tools/autotest/fg_plane_view.bat"
            break
            ;;
        "Rover")
            vehicle=ArduRover
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

cd $vehicle

echo "Display map and console?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) vars="--console --map"
        break
        ;;
        No ) vars=""
        break
        ;;
    esac
done

echo "Use default location?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) location="=-L KSFO"
        break
        ;;
        No ) read -p 'Specify location: ' specific
        location="-L $specific" 
        break
        ;;
    esac
done
cygstart $simulator
sim_vehicle.py $vars $location