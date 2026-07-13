#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR: Please run the script with root access"
    exit 1
else
    echo "You are running with root access"
fi

dnf install mysqlfdsafla -y

if [ $? -eq 0 ]
then
    echo "Installing mysql is... success"
else
    echo "Installing mysql is.... FAILURE"
fi