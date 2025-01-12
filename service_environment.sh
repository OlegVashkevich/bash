#!/bin/bash

#console colors
. ./common/colors.sh

showMenu(){
    echo "--------------------------------"
    echo "    Service your environment   "
    echo "--------------------------------"
    echo "[1] add site(in development)"
    echo "[2] remove site(in development)"
    echo "--------------------------------"
    echo "           services            "
    echo "--------------------------------"
    echo "[3] check all services"
    echo "[4] select service"
    echo "--------------------------------"
    echo "[0] exit"
    echo "--------------------------------"

    read -p "Please Select A Number: " mc
    return $mc
}

service(){
    echo "you choose $1"
    systemctl status $1 --no-pager
    echo "What you want to do with $1"
    PS3="Select number: "
    arractions=(enable disable start stop status)
    select ym in "exit" "${arractions[@]}" 
    do
        if [ "$ym" == "exit" ]
        then break;
        elif [ "$ym" ]
        then action $1 $ym;
        fi
    done
    read -p "$(echo -e $Green"Press enter to show menu"$Color_Off)"
}
action(){
    if [[ "$2" == "enable" ]]; then
        systemctl enable $1
        echo "$1 enabled"
    elif [[ "$2" == "disable" ]]; then
        systemctl disable $1
        echo "$1 disabled"
    elif [[ "$2" == "start" ]]; then
        systemctl start $1
        echo "$1 started"
    elif [[ "$2" == "stop" ]]; then
        systemctl stop $1
        echo "$1 stopped"
    elif [[ "$2" == "status" ]]; then
        systemctl status $1
    fi
    read -p "$(echo -e $Green"Press enter to show menu"$Color_Off)"
}

while [[ "$m" != "0" ]]
do
    if [[ "$m" == "1" ]]; then
        echo "add site to nginx"

    elif [[ "$m" == "2" ]]; then
        echo "remove site from nginx"
    elif [[ "$m" == "3" ]]; then
        systemctl --no-pager list-units --type service
        read -p "$(echo -e $Green"Press enter to show menu"$Color_Off)"
    elif [[ "$m" == "4" ]]; then
        #get all services
        arrservices=($(systemctl list-units -t service --plain --no-legend --no-page | awk -F[@\.] '{print $1}'))
        echo "Choose one of service"
        PS3="Select number: "
        select yn in "exit" "${arrservices[@]}" 
        do
            if [ "$yn" == "exit" ]
            then break;
            elif [ "$yn" ]
            then service $yn;
            fi
        done
        read -p "$(echo -e $Green"Press enter to show menu"$Color_Off)"
    fi
    showMenu
    m=$?
done

exit 0;