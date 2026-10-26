#! /bin/bash

user_id=$(id -u)
logs_folder="/var/log/roboshop"
logs_file="${logs_folder}/${0}.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


if [ $user_id -ne 0 ]; then
echo "please run this script with sudo access"
exit 1
fi

mkdir -p $logs_folder

echo "script started excuetion at $(date +"%F %T")" &>> $logs_file

validate() {
    if [ $1 -ne 0 ]; then
echo "${2}..failed" | tee -a $logs_file
exit 1
else 
echo "${2}..sucess" | tee -a $logs_file
fi

}
cp mongo.repo /etc/yum.repos.d/mongo.repo
validate $? "adding mongo repo"

dnf install mongodb-org -y &>> $logs_file
validate $? "install mongodb"

systemctl enable mongod &>> $logs_file
systemctl start mongod &>> $logs_file
validate $? "enable and start mongodb"

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
validate $? "updateing remote connecting to mongodb"

systemctl restart mongod
validate $? "restarting mongodb"




