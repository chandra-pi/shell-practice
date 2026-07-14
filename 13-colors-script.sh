#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR: Please run the script with root access $N"
    exit 1
else
    echo "You are running with root access"
fi

#Validate function takes input as exit status, what command they try to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "Installing $2 is... $G Success $N"
    else
        echo -e "Installing $2 is.... $R Failure $N"
        exit 1
    fi
}

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed.... going to install it"
    dnf install mysql -y
    VALIDATE $? "Mysql"
else
    echo -e "mysql is already installed.... $G nothing to do $N"
fi

dnf list installed python3

if [ $? -ne 0 ]
then
    echo "python3 is not installed.... going to install it"
    dnf install python3 -y
    VALIDATE $? "python3"
else
    echo -e "python3 is already installed.... $G nothing to do $N"
fi

dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "nginx is not installed.... going to install it"
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo -e "nginx is already installed.... $G nothing to do $N"
fi


