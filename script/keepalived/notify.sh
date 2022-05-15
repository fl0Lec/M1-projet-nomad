#!/bin/bash

TYPE=$1
NAME=$2
STATE=$3

HOME=/home/ubuntu/keep
echo "oui oui" > $HOME
case $STATE in 
    "MASTER")   echo "master" > $HOME
		cp /home/ubuntu/nomad_master.hcl /etc/nomad.d/nomad.hcl
		systemctl restart nomad.service
                echo "done" >> $HOME
                exit 0
                ;;
    "BACKUP")   echo "slave" > $HOME
		cp /home/ubuntu/nomad_slave.hcl /etc/nomad.d/nomad.hcl
		systemctl restart nomad.service
		echo "done" >> $HOME
                exit 0
                ;;
    "FAULT")    echo "fault "> $HOME
                exit 0
                ;;
    *)          echo "error unknown state" > $HOME
                exit 1
                ;;
esac
