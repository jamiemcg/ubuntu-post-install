#!/bin/bash
#
# Author: Jamie McGowan
# Description: Post installation script for Ubuntu
#
# DELETE ANY NOTES WHEN FINISHED
# Notes: 
# Universe repository:		sudo add-apt-repository universe

tabs 4	# set tab width
clear 	# clear the screen
shopt -s nocasematch	#case insensitive
echo "#------------------------------------#"
echo "		Ubuntu Post Install Script		"
echo "			Jamie Mc Gowan	 			"
echo "#------------------------------------#"

function main {
	echo
	echo "What would you like to do?"
	echo ""
	echo "1	Enable Universe (community maintained) repository"
	echo "2	Update and Upgrade System"
	echo "3	"
	echo "Q	Quit"
	echo ""

	echo "Enter your choice: " && read cmd
	if [[ $cmd == "1" ]]; then
		universe
	elif [[ $cmd == "2" ]]; then
		upgrade
	elif [[ $cmd == "Q" ]]; then
		exit
	else
		clear
		echo "I did not understand that. Try again"
		main
	fi
}

function universe {
	echo ""
	echo "Enabling Universe repository"
	echo "Requires root privileges"
	sudo add-apt-repository universe
	sudo apt-get update
	sudo add-apt-repository universe
	echo "Enabled Universe repository"
	main

}


function upgrade {
	echo ''
	echo 'Are you sure you want to upgrade the system? (Y)es, (N)o : ' 
	read REPLY

	case $REPLY in
		[Yy]* )
			echo "Requires root privileges"
			echo "------------------------"
			echo "Updating repositories"
			sudo apt-get update
			echo "Upgrading system"
			sudo apt-get upgrade -y
			sudo apt-get dist-upgrade -y
			echo ""
			echo "Finished upgrade"
			main
			;;
		[Nn]* )
			clear
			main
			;;
		* )
	    clear 
	    echo "Sorry, try again"
	    upgrade
	    ;;
	esac
}	


main