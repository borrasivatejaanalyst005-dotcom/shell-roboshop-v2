#!/bin/bash



app_name=payment
source  ./common.sh

check_root
python_setup
app_setup
systemd_setup

restart
total_time