#!/bin/bash
su -l deploy -c 'kill -KILL -s QUIT `cat /home/ec2-user/cafeshares/tmp/pids/unicorn.pid`'