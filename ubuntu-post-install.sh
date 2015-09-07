#!/bin/bash
# 
#			** W I P ** 
# 
#
# Author: Jamie McGowan
# Description: Post installation script for Ubuntu. Performs common trivial tasks.

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
	echo "	3   Install Third-party applications"
	echo "	4	Install Codecs"
	echo "	5	Switch to Numix themes"
	echo "	Q	Quit"
	echo ""

	echo "Enter your choice: " && read cmd
	if [[ $cmd == "1" ]]; then
		universe
	elif [[ $cmd == "2" ]]; then
		upgrade
	elif [[ $cmd == "3" ]]; then
		third
	elif [[ $cmd == "4" ]]; then
		codecs
	elif [[ $cmd == "5" ]]; then
		theme
	elif [[ $cmd == "Q" ]]; then
		echo "Goodbye!"
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

function third {
	echo ""
	echo "Installing Third-party Applications"
	echo "==================================="

	read -p "Install 'Google Chrome'? [Y/N]:" chrome
	read -p "Install 'GIMP'? [Y/N]:" gimp
	read -p "Install 'Skype'? [Y/N]:" skype
	read -p "Install 'Sublime Text'? [Y/N]:" sublime
	read -p "Install 'Synaptic'? [Y/N]:" synaptic
	read -p "Install 'VLC'? [Y/N]:" vlc

	echo ""
	echo "==================================="
	echo ""
	

	if [[ $chrome =~ ^[Yy]$ ]]
	then
		echo "Downloading Chrome"
		wget --quiet https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	    echo "Installing Chrome"
	    sudo dpkg -i "google-chrome-stable_current_amd64.deb"
	    rm "google-chrome-stable_current_amd64.deb"
	fi

	if [[ $gimp =~ ^[Yy]$ ]]
	then
	    echo "Installing GIMP"
	    sudo apt-get install gimp > /dev/null
	fi	


	if [[ $skype =~ ^[Yy]$ ]]
	then
		echo "Downloading Skype"
		wget --quiet http://download.skype.com/linux/skype-ubuntu-precise_4.3.0.37-1_i386.deb
	    echo "Installing Skype"
	    sudo dpkg -i skype-ubuntu-precise_4.3.0.37-1_i386.deb > /dev/null
	    rm skype-ubuntu-precise_4.3.0.37-1_i386.deb
	fi


	if [[ $sublime =~ ^[Yy]$ ]]
	then
		echo "Downloading Sublime Text"
		wget --quiet http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_amd64.deb
	    echo "Installing Sublime Text"
	    sudo dpkg -i sublime-text_build-3083_amd64.deb > /dev/null
	    rm sublime-text_build-3083_amd64.deb
	fi

	if [[ $vlc =~ ^[Yy]$ ]]
	then
	    echo "Installing VLC"
	    sudo apt-get install vlc > /dev/null
		
	fi

	if [[ $synaptic =~ ^[Yy]$ ]]
	then
	    echo "Installing Synaptic"
	    sudo apt-get install synaptic > /dev/null
		
	fi

	main
}

function theme {
	echo ""

	#Ensure the themes are install
	echo "Have you added the Numix Repository and installed the themes? [Y/N]:"
	read REPLY
	case $REPLY in
		[Nn]* )
			echo "Okay I will do that for you now!"
			echo "Installing/Upgrading Numix themes"
			echo ""
			sudo apt-add-repository -y ppa:numix/ppa
			sudo apt-get install numix-icon-theme-circle numix-gtk-theme
			sudo apt-get update
			;;
		[Yy]* )
			;;
		* )
			echo "Sorry I didn't understand that, try again"
			theme
			;;
	esac		

	echo ""
	echo "Changing the Icon theme to:				Numix-Circle"
	gsettings set org.gnome.desktop.interface icon-theme 'Numix-Circle'
	echo "Changing the GTK theme to:				Numix-Daily"
	gsettings set org.gnome.desktop.interface gtk-theme "Numix Daily"
	echo "Changing the Window Decoration theme to:	Numix-Daily"
	gsettings set org.gnome.desktop.wm.preferences theme "Numix Daily"
	
	echo ""
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
			sudo apt-get update > /dev/null
			echo "Upgrading system"
			sudo apt-get upgrade -y > /dev/null
			sudo apt-get dist-upgrade -y > /dev/null
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
