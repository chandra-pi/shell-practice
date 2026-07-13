#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR: Please run the script with root access"
    exit 1
else
    echo "You are running with root access"
fi

dnf list installed mysql

if [ $? -eq 0 ]
then
    echo "Mysql is not installed .... going to install it"
    dnf install mysql -y
    if [ $? -eq 0 ]
    then
        echo "Installing mysql is... Success"
    else
        echo "Installing mysql is..... Failure"
        exit 1
    fi
else
    echo "mysql is already installed..... nothing to do"
fi


