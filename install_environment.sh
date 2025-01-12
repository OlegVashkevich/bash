#!/bin/bash

#console colors
. ./common/colors.sh

#arrservices=(midnightcommander php composer git mysql nginx memcached opensearch dashboards munin rabbitmq minio redis)
arrservices=( $(ls ./install/ | grep '.sh' | sed 's/.sh$//') )

for service in ${arrservices[*]}
do
    . ./install/$service.sh
done

echo "What do you wish to install?"
PS3="Select operation: "
select yn in "${arrservices[@]}" "exit" 
do
    if [ "$yn" == "exit" ]
    then exit;
    elif [ "$yn" ]
    then install_$yn;
    fi
done
