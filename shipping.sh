#!/bin/bash
app_name=shipping
source  ./common.sh

check_root
java_setup
app_setup
systemd_setup

restart
total_time




