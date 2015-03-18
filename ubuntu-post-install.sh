#!/bin/bash
# 
#			** W I P ** 
# 
#
# Author: Jamie McGowan
# Description: Post installation script for Ubuntu
#
# DELETE ANY NOTES WHEN FINISHED
# Notes: 
# 	Functions to add:
#		Install favorite apps
#		Install .debs like chrome, etc... sublime,......
#		Install numix theme and icons
#		gsettings set org.gnome.desktop.interface gtk-theme "Numix Daily"
#		Change Icon-Theme:
#		gsettings set org.gnome.desktop.interface icon-theme 'Numix-Circle'
#		Change Window-Theme:		
# 		gsettings set org.gnome.desktop.wm.preferences theme "Numix Daily"
#
#


tabs 4	# set tab width
clear 	# clear the screen
shopt -s nocasematch	#case insensitive
echo "#------------------------------------#"
echo "		Ubuntu Post Install Script		"
echo "			Jamie Mc Gowan	 			"
echo "#------------------------------------#"

function main {
	echo ""
	echo "What would you like to do?"
	echo "	1	Enable Universe (community maintained) repository"
	echo "	2	Update and Upgrade System"
	echo "	3	Install Codecs"
	echo "	4	Switch to Numix themes"
	echo "	Q	Quit"
	echo ""

	echo "Enter your choice: " && read cmd
	if [[ $cmd == "1" ]]; then
		universe
	elif [[ $cmd == "2" ]]; then
		upgrade
	elif [[ $cmd == "3" ]]; then
		codecs
	elif [[ $cmd == "4" ]]; then
		theme
	elif [[ $cmd == "Q" ]]; then
		exit
	else
		clear
		echo "I did not understand that. Try again"
		main
	fi
}

function codecs {
	echo ""
	echo "Installing Ubuntu Restricted Extras"
	echo "Requires root privileges"
	sudo apt-get install -y ubuntu-restricted-extras
	main
}

function theme {
	echo ""
	echo "Changing the Icon theme to:				Numix-Circle"
	gsettings set org.gnome.desktop.interface icon-theme 'Numix-Circle'
	echo "Changing the GTK theme to:				Numix-Daily"
	gsettings set org.gnome.desktop.interface gtk-theme "Numix Daily"
	echo "Changing the Window Decoration theme to:	Numix-Daily"
	gsettings set org.gnome.desktop.wm.preferences theme "Numix Daily"
	echo "Finished changing themes"
	main
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