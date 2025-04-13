#!/bin/bash

log="/tmp/wlsunset.log"
sunrise=`tac $log | grep -om 1 "dawn.*$"`
temperature=`tac $log | grep -Pom 1 "to\ \K[\\d]+"`
echo "{\"text\": \" ${temperature}K\",\"tooltip\": \"${sunrise}\"}"
