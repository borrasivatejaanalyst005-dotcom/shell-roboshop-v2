#! /bin/bash

source  ./common.sh

chech_root

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


total_time

