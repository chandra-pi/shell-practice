#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-log"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "Script started executing at: $(date)" &>>$LOG_FILE


if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR: Please run the script with root access $N" &>>$LOG_FILE
    exit 1
else
    echo "You are running with root access" &>>$LOG_FILE
fi

#Validate function takes input as exit status, what command they try to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "Installing $2 is... $G Success $N" &>>$LOG_FILE
    else
        echo -e "Installing $2 is.... $R Failure $N" &>>$LOG_FILE
        exit 1
    fi
}

dnf list installed mysql &>>$LOG_FILE

if [ $? -ne 0 ]
then
    echo "mysql is not installed.... going to install it" &>>$LOG_FILE
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "Mysql"
else
    echo -e "mysql is already installed.... $G nothing to do $N" &>>$LOG_FILE
fi

dnf list installed python3 &>>$LOG_FILE

if [ $? -ne 0 ]
then
    echo "python3 is not installed.... going to install it" &>>$LOG_FILE
    dnf install python3 -y &>>$LOG_FILE
    VALIDATE $? "python3"
else
    echo -e "python3 is already installed.... $G nothing to do $N" &>>$LOG_FILE
fi

dnf list installed nginx &>>$LOG_FILE

if [ $? -ne 0 ]
then
    echo "nginx is not installed.... going to install it" &>>$LOG_FILE
    dnf install nginx -y &>>$LOG_FILE
    VALIDATE $? "nginx"
else
    echo -e "nginx is already installed.... $G nothing to do $N" &>>$LOG_FILE
fi


