#!/bin/bash
su -l deploy -c 'kill -KILL -s QUIT `cat /opt/d-LAAJ9D5GR/deployment-archive/tmp/pids/unicorn.pid`'