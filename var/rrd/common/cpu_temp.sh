#!/bin/sh
ipmitool -c -I lan -H 192.168.1.112 -f /var/rrd/common/xeon.psw -U root sdr list | grep "P1 Therm Margin" | awk -F, '{sum = $2 + 73; printf "%s",sum}'